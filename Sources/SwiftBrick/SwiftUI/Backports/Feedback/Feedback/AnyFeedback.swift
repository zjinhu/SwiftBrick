import SwiftUI
@available(iOS 14, *)
/// A type-erased Feedback
public struct AnyFeedback: Feedback {
    private var haptic: Feedback

    /// The feedback to type-erase
    public init(_ haptic: Feedback) {
        self.haptic = haptic
    }

    /// Asks the type-erased feedback to perform
    public func perform() async {
        await haptic.perform()
    }
}
