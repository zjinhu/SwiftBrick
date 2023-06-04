import SwiftUI
 
@available(iOS, deprecated: 15)
@available(macOS, deprecated: 12)
@available(tvOS, deprecated: 15)
@available(watchOS, deprecated: 8)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) 
extension SwiftBrickWrapper where Wrapped == Any {

    public enum Visibility: Hashable, CaseIterable {
        /// The element may be visible or hidden depending on the policies of the
        /// component accepting the visibility configuration.
        ///
        /// For example, some components employ different automatic behavior
        /// depending on factors including the platform, the surrounding container,
        /// user settings, etc.
        case automatic

        /// The element may be visible.
        ///
        /// Some APIs may use this value to represent a hint or preference, rather
        /// than a mandatory assertion. For example, setting list row separator
        /// visibility to `visible` using the
        /// ``View/listRowSeparator(_:edges:)`` modifier may not always
        /// result in any visible separators, especially for list styles that do not
        /// include separators as part of their design.
        case visible

        /// The element may be hidden.
        ///
        /// Some APIs may use this value to represent a hint or preference, rather
        /// than a mandatory assertion. For example, setting confirmation dialog
        /// title visibility to `hidden` using the
        /// ``View/confirmationDialog(_:isPresented:titleVisibility:actions:)-87n66``
        /// modifier may not always hide the dialog title, which is required on
        /// some platforms.
        case hidden
    }

}
