import SwiftUI
 
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) 
extension SwiftBrickWrapper where Wrapped == Any {

    /// The visibility of scroll indicators of a UI element.
    ///
    /// Pass a value of this type to the ``View.ss.scrollIndicators(_:axes:)`` method
    /// to specify the preferred scroll indicator visibility of a view hierarchy.
    public struct ScrollIndicatorVisibility: Hashable, CustomStringConvertible {
        internal enum IndicatorVisibility: Hashable {
            case automatic
            case visible
            case hidden
        }

        let visibility: SwiftBrickWrapper.Visibility

        var scrollViewVisible: Bool {
            visibility != .hidden
        }

        public var description: String {
            String(describing: visibility)
        }

        /// Scroll indicator visibility depends on the
        /// policies of the component accepting the visibility configuration.
        public static var automatic: ScrollIndicatorVisibility {
            .init(visibility: .automatic)
        }

        /// Show the scroll indicators.
        ///
        /// The actual visibility of the indicators depends on platform
        /// conventions like auto-hiding behaviors in iOS or user preference
        /// behaviors in macOS.
        public static var visible: ScrollIndicatorVisibility {
            .init(visibility: .visible)
        }

        /// Hide the scroll indicators.
        ///
        /// By default, scroll views in macOS show indicators when a
        /// mouse is connected. Use ``never`` to indicate
        /// a stronger preference that can override this behavior.
        public static var hidden: ScrollIndicatorVisibility {
            .init(visibility: .hidden)
        }
    }

}
