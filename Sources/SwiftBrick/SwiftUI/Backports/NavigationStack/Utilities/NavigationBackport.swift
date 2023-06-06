import Foundation
import SwiftUI
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
typealias DestinationBuilder<T> = (T) -> AnyView
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
enum NavigationBackport {
    /// Calculates the minimal number of steps to update from one stack of screens to another, within the constraints of SwiftUI.
    /// - Parameters:
    ///   - start: The initial state.
    ///   - end: The goal state.
    /// - Returns: A series of state updates from the start to end.
    public static func calculateSteps<Screen>(from start: [Screen], to end: [Screen]) -> [[Screen]] {
        let replacableScreens = end.prefix(start.count)
        let remainingScreens = start.count < end.count ? end.suffix(from: start.count) : []
        
        var steps = [Array(replacableScreens)]
        var lastStep: [Screen] { steps.last! }
        
        for screen in remainingScreens {
            steps.append(lastStep + [screen])
        }
        
        return steps
    }
    
    static func canSynchronouslyUpdate<Screen>(from start: [Screen], to end: [Screen]) -> Bool {
        // If there are less than 3 steps, the transformation can be applied in one update.
        let steps = calculateSteps(from: start, to: end)
        return steps.count < 3
    }
}
