import SwiftUI
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
private struct OnFirstAppear: ViewModifier {
    let action: (() -> Void)?
    
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !hasAppeared {
                hasAppeared = true
                action?()
            }
        }
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension View {
    func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnFirstAppear(action: action))
    }
}
