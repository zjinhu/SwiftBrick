#if os(iOS)
import SwiftUI
@available(iOS 14.0, *)
public extension SwiftBrickWrapper<Any> {
    struct ToolbarPlacement: Hashable {
        enum Placement: Hashable {
            var id: Self { self }
            case bottomBar
            case navigationbar
            case tabBar
        }

        let placement: Placement

        /// The bottom toolbar of an app.
        @available(macOS, unavailable)
        public static var bottomBar: ToolbarPlacement {
            .init(placement: .bottomBar)
        }

        /// The navigation bar of an app.
        @available(macOS, unavailable)
        public static var navigationBar: ToolbarPlacement {
            .init(placement: .navigationbar)
        }

        /// The tab bar of an app.
        @available(macOS, unavailable)
        public static var tabBar: ToolbarPlacement {
            .init(placement: .tabBar)
        }
    }
}

#endif
