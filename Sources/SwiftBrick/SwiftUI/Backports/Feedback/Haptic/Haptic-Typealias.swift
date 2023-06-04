import SwiftUI
#if canImport(CoreHaptics)
import CoreHaptics
#endif

#if os(iOS)

/// Returns the result of recomputing the view's body with the provided animation.
/// - Parameters:
///   - style: The system haptic to perform alonside the body
///   - body: The content of this value will be called alongside the haptic
///
@available(iOS 14.0, *)
public func withHaptic<Result>(_ style: HapticStyle = .selection, _ body: () throws -> Result) rethrows -> Result {
    let haptic = SystemHaptic(style: style)
    Task { await haptic.perform() }
    return try body()
}

/// Returns the result of recomputing the view's body with the provided animation.
/// - Parameters:
///   - intensity: The intensity of the feedback
///   - sharpness: The sharpness of the feedback
///   - relativeTime: The relative time for the feedback, useful when combining haptic feedback
///   - duration: The duration of the feedback
///   - body: The content of this value will be called alongside the haptic
@available(iOS 14.0, *)
public func withHaptic<Result>(intensity: Double, sharpness: Double, relativeTime: TimeInterval = 0, duration: TimeInterval = 0, _ body: () throws -> Result) rethrows -> Result {
    let event = HapticEvent.haptic(intensity: intensity, sharpness: sharpness, relativeTime: relativeTime, duration: duration)
    let haptic = PatternHaptic(style: .events([event]))
    Task { await haptic.perform() }
    return try body()
}

/// Returns the result of recomputing the view's body with the provided animation.
/// - Parameters:
///   - events: The events representing the haptic feedback
///   - body: The content of this value will be called alongside the haptic
@available(iOS 14.0, *)
public func withHaptic<Result>(_ events: [HapticEvent], _ body: () throws -> Result) rethrows -> Result {
    let haptic = PatternHaptic(style: .events(events))
    Task { await haptic.perform() }
    return try body()
}

/// Returns the result of recomputing the view's body with the provided animation.
/// - Parameters:
///   - pattern: The pattern representing the haptic feedback
///   - body: The content of this value will be called alongside the haptic
@available(iOS 14.0, *)
public func withHaptic<Result>(_ pattern: CHHapticPattern, _ body: () throws -> Result) rethrows -> Result {
    let haptic = PatternHaptic(style: .pattern(pattern))
    Task { await haptic.perform() }
    return try body()
}

/// Returns the result of recomputing the view's body with the provided animation.
/// - Parameters:
///   - url: The url representing the haptic feedback pattern
///   - body: The content of this value will be called alongside the haptic
@available(iOS 14.0, *)
public func withHaptic<Result>(_ url: URL, _ body: () throws -> Result) rethrows -> Result {
    let haptic = PatternHaptic(style: .url(url))
    Task { await haptic.perform() }
    return try body()
}

#endif

#if os(iOS)
@available(iOS 14.0, *)
public extension View {

    /// Attaches a haptic to this view when the specified value changes
    /// - Parameters:
    ///   - style: The system haptic to perform alonside the body
    ///   - value: The value to observe for changes
    func haptic<V>(_ style: HapticStyle, value: V) -> some View where V: Equatable {
        modifier(FeedbackModifier(feedback: AnyFeedback.haptic(style), value: value))
    }

    /// Attaches a haptic to this view when the specified value changes
    /// - Parameters:
    ///   - events: The events representing the haptic feedback
    ///   - value: The value to observe for changes
    func haptic<V>(_ events: [HapticEvent], value: V) -> some View where V: Equatable {
        modifier(FeedbackModifier(feedback: PatternHaptic(style: .events(events)), value: value))
    }

    /// Attaches a haptic to this view when the specified value changes
    /// - Parameters:
    ///   - pattern: The pattern representing the haptic feedback
    ///   - value: The value to observe for changes
    func haptic<V>(_ pattern: CHHapticPattern, value: V) -> some View where V: Equatable {
        modifier(FeedbackModifier(feedback: PatternHaptic(style: .pattern(pattern)), value: value))
    }

    /// Attaches a haptic to this view when the specified value changes
    /// - Parameters:
    ///   - url: The url representing the haptic feedback pattern
    ///   - value: The value to observe for changes
    func haptic<V>(_ url: URL, value: V) -> some View where V: Equatable {
        modifier(FeedbackModifier(feedback: PatternHaptic(style: .url(url)), value: value))
    }
}
#endif
