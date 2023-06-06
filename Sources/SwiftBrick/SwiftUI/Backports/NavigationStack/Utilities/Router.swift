import Foundation
import SwiftUI
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
struct Router<Screen, RootView: View>: View {
    let rootView: RootView
    
    @Binding var screens: [Screen]
    
    init(rootView: RootView, screens: Binding<[Screen]>) {
        self.rootView = rootView
        _screens = screens
    }
    
    var pushedScreens: some View {
        Node(allScreens: $screens, truncateToIndex: { screens = Array(screens.prefix($0)) }, index: 0)
    }
    
    private var isActiveBinding: Binding<Bool> {
        Binding(
            get: { !screens.isEmpty },
            set: { isShowing in
                guard !isShowing else { return }
                guard !screens.isEmpty else { return }
                screens = []
            }
        )
    }
    
    var body: some View {
        rootView
            .ss.navigationDestination(isActive: isActiveBinding, destination: pushedScreens)
    }
}
