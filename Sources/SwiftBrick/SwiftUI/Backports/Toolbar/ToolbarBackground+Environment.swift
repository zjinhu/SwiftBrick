#if os(iOS)
import SwiftUI
@available(iOS 14.0, *)
struct ToolbarViews {
    var navigationBar: AnyView?
    var bottomBar: AnyView?
    var tabBar: AnyView?
}
@available(iOS 14.0, *)
struct ToolbarVisibility {
    var navigationBar: SwiftBrickWrapper<Any>.Visibility?
    var bottomBar: SwiftBrickWrapper<Any>.Visibility?
    var tabBar: SwiftBrickWrapper<Any>.Visibility?
}
@available(iOS 14.0, *)
private struct ToolbarViewsKey: EnvironmentKey {
    static var defaultValue: ToolbarViews = .init()
}
@available(iOS 14.0, *)
private struct ToolbarVisibilityKey: EnvironmentKey {
    static var defaultValue: ToolbarVisibility = .init()
}
@available(iOS 14.0, *)
internal extension EnvironmentValues {
    var toolbarViews: ToolbarViews {
        get { self[ToolbarViewsKey.self] }
        set { self[ToolbarViewsKey.self] = newValue }
    }
}
@available(iOS 14.0, *)
internal extension EnvironmentValues {
    var toolbarVisibility: ToolbarVisibility {
        get { self[ToolbarVisibilityKey.self] }
        set { self[ToolbarVisibilityKey.self] = newValue }
    }
}
#endif
