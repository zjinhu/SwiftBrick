import SwiftUI
@available(iOS 14, *)
public extension AnyFeedback {
    /// Specifies feedback that plays an audio file
    /// - Parameter audio: The audio to play when this feedback is triggered
    static func audio(_ audio: Audio) -> Self {
        .init(AudioFeedback(audio: audio))
    }
}
@available(iOS 14, *)
private struct AudioPlayerEnvironmentKey: EnvironmentKey {
    static var defaultValue: AudioPlayer = .init()
}
@available(iOS 14, *)
private extension EnvironmentValues {
    var audioPlayer: AudioPlayer {
        get { self[AudioPlayerEnvironmentKey.self] }
        set { self[AudioPlayerEnvironmentKey.self] = newValue }
    }
}
@available(iOS 14, *)
private struct AudioFeedback: Feedback, ViewModifier {
    @Environment(\.audioPlayer) private var player
    typealias Body = Never
    
    var audio: Audio
    
    init(audio: Audio) {
        self.audio = audio
    }
    
    func perform() async {
        do {
            try await player.play(audio: audio)
        } catch {
            print(error)
        }
    }
}
