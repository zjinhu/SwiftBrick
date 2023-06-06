import SwiftUI
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
struct NavigationWrapper<Content: View>: View {
    var content: Content
    @Environment(\.useNavigationStack) var useNavigationStack
    
    var body: some View {
        if #available(iOS 16.0, *, macOS 13.0, *, watchOS 7.0, *, tvOS 14.0, *), useNavigationStack == .whenAvailable {
            return AnyView(NavigationStack { content })
                .environment(\.isWithinNavigationStack, true)
        } else {
            return AnyView(NavigationView { content }
                .navigationViewStyle(supportedNavigationViewStyle))
            .environment(\.isWithinNavigationStack, false)
        }
    }
    
    init(content: () -> Content) {
        self.content = content()
    }
}

public enum UseNavigationStackPolicy {
    case whenAvailable
    case never
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
private var supportedNavigationViewStyle: some NavigationViewStyle {
#if os(macOS)
    .automatic
#else
    .stack
#endif
}
