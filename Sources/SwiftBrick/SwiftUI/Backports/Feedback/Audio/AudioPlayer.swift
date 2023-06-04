import SwiftUI
import AVFoundation
@available(iOS 14, *)
private enum PlayerError: LocalizedError {
    case badUrl(Audio)
    var errorDescription: String? {
        switch self {
        case let .badUrl(audio):
            return "Couldn't play sound: \(audio.url.lastPathComponent), the URL was invalid."
        }
    }
}
@available(iOS 14, *)
internal final class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    
    @MainActor
    func play(audio: Audio) async throws {
#if os(iOS)
        await stop()

        try AVAudioSession.sharedInstance().setCategory(.ambient)
        try AVAudioSession.sharedInstance().setActive(true)
        
        player = try AVAudioPlayer(contentsOf: audio.url)
        player?.delegate = self
        player?.play()
#else
#warning("macOS audio not implemented")
#endif
    }
    
    @MainActor
    func stop() async {
        player?.stop()
        player = nil
    }

#if os(iOS)
    @MainActor
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Task { await stop() }
    }
#endif
}
