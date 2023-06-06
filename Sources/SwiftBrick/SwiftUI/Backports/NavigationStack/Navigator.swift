import SwiftUI

public protocol NavigatorScreen: Hashable {}

/// A navigator to use when the `NBNavigationStack` is initialized with a `NBNavigationPath` binding or no binding.`
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public typealias PathNavigator = Navigator<AnyHashable>

/// An object available via the environment that gives access to the current path.
/// Supports push and pop operations when `Screen` conforms to `NBScreen`.
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
@MainActor
public class Navigator<Screen>: ObservableObject {
    let pathBinding: Binding<[Screen]>
    
    /// The current navigation path.
    public var path: [Screen] {
        get { pathBinding.wrappedValue }
        set { pathBinding.wrappedValue = newValue }
    }
    
    init(_ pathBinding: Binding<[Screen]>) {
        self.pathBinding = pathBinding
    }
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension Navigator where Screen: NavigatorScreen {
    /// Pushes a new screen via a push navigation.
    /// - Parameter screen: The screen to push.
    func push(_ screen: Screen) {
        path.push(screen)
    }
    
    /// Pops a given number of screens off the stack.
    /// - Parameter count: The number of screens to go back. Defaults to 1.
    func pop(_ count: Int = 1) {
        path.pop(count)
    }
    
    /// Pops to a given index in the array of screens. The resulting screen count
    /// will be index.
    /// - Parameter index: The index that should become top of the stack.
    func popTo(index: Int) {
        path.popTo(index: index)
    }
    
    /// Pops to the root screen (index 0). The resulting screen count
    /// will be 1.
    func popToRoot() {
        path.popToRoot()
    }
    
    /// Pops to the topmost (most recently pushed) screen in the stack
    /// that satisfies the given condition. If no screens satisfy the condition,
    /// the screens array will be unchanged.
    /// - Parameter condition: The predicate indicating which screen to pop to.
    /// - Returns: A `Bool` indicating whether a screen was found.
    @discardableResult
    func popTo(where condition: (Screen) -> Bool) -> Bool {
        path.popTo(where: condition)
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension Navigator where Screen: NavigatorScreen & Equatable {
    /// Pops to the topmost (most recently pushed) screen in the stack
    /// equal to the given screen. If no screens are found,
    /// the screens array will be unchanged.
    /// - Parameter screen: The predicate indicating which screen to go back to.
    /// - Returns: A `Bool` indicating whether a matching screen was found.
    @discardableResult
    func popTo(_ screen: Screen) -> Bool {
        return path.popTo(screen)
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension Navigator where Screen: NavigatorScreen & Identifiable {
    /// Pops to the topmost (most recently pushed) identifiable screen in the stack
    /// with the given ID. If no screens are found, the screens array will be unchanged.
    /// - Parameter id: The id of the screen to goBack to.
    /// - Returns: A `Bool` indicating whether a matching screen was found.
    @discardableResult
    func popTo(id: Screen.ID) -> Bool {
        path.popTo(id: id)
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension Navigator where Screen == AnyHashable {
    /// Pops to the topmost (most recently pushed) identifiable screen in the stack
    /// with the given ID. If no screens are found, the screens array will be unchanged.
    /// - Parameter id: The id of the screen to goBack to.
    /// - Returns: A `Bool` indicating whether a matching screen was found.
    @discardableResult
    func popTo<T: Hashable>(_: T.Type) -> Bool {
        popTo(where: { $0 is T })
    }
}
