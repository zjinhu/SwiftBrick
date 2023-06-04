import SwiftUI
 
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension EnvironmentValues {

    /// The visiblity to apply to scroll indicators of any
    /// vertically scrollable content.
    public var verticalScrollIndicatorVisibility: SwiftBrickWrapper<Any>.ScrollIndicatorVisibility {
        get { self[VerticalIndicatorKey.self] }
        set { self[VerticalIndicatorKey.self] = newValue }
    }

    /// The visibility to apply to scroll indicators of any
    /// horizontally scrollable content.
    public var horizontalScrollIndicatorVisibility: SwiftBrickWrapper<Any>.ScrollIndicatorVisibility {
        get { self[HorizontalIndicatorKey.self] }
        set { self[HorizontalIndicatorKey.self] = newValue }
    }

    /// The way that scrollable content interacts with the software keyboard.
    ///
    /// The default value is ``SwiftBrickWrapper.ScrollDismissesKeyboardMode.automatic``. Use the
    /// ``View.ss.scrollDismissesKeyboard(_:)`` modifier to configure this
    /// property.
    public var scrollDismissesKeyboardMode: SwiftBrickWrapper<Any>.ScrollDismissesKeyboardMode {
        get { self[KeyboardDismissKey.self] }
        set { self[KeyboardDismissKey.self] = newValue }
    }

    /// A Boolean value that indicates whether any scroll views associated
    /// with this environment allow scrolling to occur.
    ///
    /// The default value is `true`. Use the ``View.ss.scrollDisabled(_:)``
    /// modifier to configure this property.
    public var isScrollEnabled: Bool {
        get { self[ScrollEnabledKey.self] }
        set { self[ScrollEnabledKey.self] = newValue }
    }
    
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
private struct VerticalIndicatorKey: EnvironmentKey {
    static var defaultValue: SwiftBrickWrapper<Any>.ScrollIndicatorVisibility = .automatic
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
private struct HorizontalIndicatorKey: EnvironmentKey {
    static var defaultValue: SwiftBrickWrapper<Any>.ScrollIndicatorVisibility = .automatic
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
private struct KeyboardDismissKey: EnvironmentKey {
    static var defaultValue: SwiftBrickWrapper<Any>.ScrollDismissesKeyboardMode = .automatic
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
private struct ScrollEnabledKey: EnvironmentKey {
    static var defaultValue: Bool = true
}
