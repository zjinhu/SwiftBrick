import SwiftUI
#if canImport(CoreHaptics)
import CoreHaptics
#endif
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension AnyFeedback {
    /// Specifies haptic feedback
    /// - Parameters:
    ///   - intensity: The intensity of the feedback
    ///   - sharpness: The sharpness of the feedback
    ///   - relativeTime: The relative time for the feedback, useful when combining haptic feedback
    ///   - duration: The duration of the feedback
    static func haptic(intensity: Double, sharpness: Double, relativeTime: TimeInterval = 0, duration: TimeInterval = 0) -> Self {
        let event = HapticEvent.haptic(intensity: intensity, sharpness: sharpness, relativeTime: relativeTime, duration: duration)
        return .init(PatternHaptic(style: .events([event])))
    }

    /// Specifies haptic feedback, defined by the specified events
    /// - Parameter events: The events representing the haptic feedback
    static func haptic(_ events: HapticEvent...) -> Self {
        .init(PatternHaptic(style: .events(events)))
    }

    /// Specifies haptic feedback, defined by the specified events
    /// - Parameter events: The events representing the haptic feedback
    static func haptic(_ events: [HapticEvent]) -> Self {
        .init(PatternHaptic(style: .events(events)))
    }

#if os(iOS) || os(macOS)
    /// Specifies haptic feedback, defined by the specified pattern
    /// - Parameter pattern: The pattern representing the haptic feedback
    static func haptic(_ pattern: CHHapticPattern) -> Self {
        .init(PatternHaptic(style: .pattern(pattern)))
    }

    /// Specifies haptic feedback, loaded from a file
    /// - Parameter url: The url representing the haptic feedback pattern
    @available(iOS 16, *)
    static func haptic(url: URL) -> Self {
        .init(PatternHaptic(style: .url(url)))
    }
#endif
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
internal struct PatternHaptic: Feedback {
    enum Style: CustomStringConvertible {
        case events([HapticEvent])
#if os(iOS) || os(macOS)
        case pattern(CHHapticPattern)
        case url(URL)
#endif
        
        var description: String {
            switch self {
            case let .events(events):
                return events.map { 
                    "- \($0.description)"
                }.joined(separator: "\n")
#if os(iOS) || os(macOS)
            case let .pattern(pattern):
                return pattern.description
            case let .url(url):
                return url.absoluteString
#endif
            }
        }
    }

    let style: Style

    public func perform() async {
#if os(iOS) || os(macOS)
        do {
            let engine = try CHHapticEngine()
            let pattern: CHHapticPattern

            engine.playsHapticsOnly = true

            switch style {
            case let .events(events):
                pattern = try CHHapticPattern(events: events.map { $0.event }, parameters: [])
            case let .url(url):
                if #available(iOS 16, macOS 13, *) {
                    pattern = try CHHapticPattern(contentsOf: url)
                } else {
                    fatalError("This should never occur since the API will be limited to iOS 16+")
                }
            case let .pattern(pat):
                pattern = pat
            }

            try await engine.start()

            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)

            // this ensures we stop when we're done but its also
            // IMPORTANT since it 'captures' the engine temporarily
            // ensuring haptics play for the entire duration
            DispatchQueue.main.asyncAfter(deadline: .now() + pattern.duration) {
                engine.stop()
            }
        } catch {
            print("Haptic pattern could not be played")
        }
#endif
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public enum HapticEvent: CustomStringConvertible {
    case haptic(intensity: Double, sharpness: Double, relativeTime: TimeInterval = 0, duration: TimeInterval = 0.01)

    public var description: String {
        switch self {
        case let .haptic(intensity, sharpness, relativeTime, duration):
            return "Haptic (intensity: \(intensity), sharpness: \(sharpness), time: \(relativeTime), duration: \(duration))"
        }
    }

#if os(iOS) || os(macOS)
    internal var event: CHHapticEvent {
        switch self {
        case let .haptic(intensity, sharpness, relativeTime, duration):
            return .init(
                eventType: .hapticContinuous,
                parameters: [
                    CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(intensity)),
                    CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(sharpness)),
                ],
                relativeTime: relativeTime,
                duration: duration
            )
        }
    }
#endif
}
