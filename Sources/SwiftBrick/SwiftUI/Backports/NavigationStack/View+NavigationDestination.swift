import Foundation
import SwiftUI
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension SwiftBrickWrapper where Wrapped: View {
    func navigationDestination<D: Hashable, C: View>(for pathElementType: D.Type, @ViewBuilder destination builder: @escaping (D) -> C) -> some View {
        return wrapped.modifier(DestinationBuilderModifier(typedDestinationBuilder: { AnyView(builder($0)) }))
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension SwiftBrickWrapper where Wrapped: View {
    /// Associates a destination view with a binding that can be used to push
    /// the view onto a ``SwiftBrickWrapper.NavigationStack``.
    ///
    /// In general, favor binding a path to a navigation stack for programmatic
    /// navigation. Add this view modifer to a view inside a ``SwiftBrickWrapper.NavigationStack``
    /// to programmatically push a single view onto the stack. This is useful
    /// for building components that can push an associated view. For example,
    /// you can present a `ColorDetail` view for a particular color:
    ///
    ///     @State private var showDetails = false
    ///     var favoriteColor: Color
    ///
    ///     SwiftBrickWrapper.NavigationStack {
    ///         VStack {
    ///             Circle()
    ///                 .fill(favoriteColor)
    ///             Button("Show details") {
    ///                 showDetails = true
    ///             }
    ///         }
    ///         .ss.avigationDestination(isPresented: $showDetails) {
    ///             ColorDetail(color: favoriteColor)
    ///         }
    ///         .navigationTitle("My Favorite Color")
    ///     }
    ///
    /// Do not put a navigation destination modifier inside a "lazy" container,
    /// like ``List`` or ``LazyVStack``. These containers create child views
    /// only when needed to render on screen. Add the navigation destination
    /// modifier outside these containers so that the navigation stack can
    /// always see the destination.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that indicates whether
    ///     `destination` is currently presented.
    ///   - destination: A view to present.
    func navigationDestination<V>(isPresented: Binding<Bool>, @ViewBuilder destination: () -> V) -> some View where V: View {
        let builtDestination = AnyView(destination())
        return wrapped.modifier(
            LocalDestinationBuilderModifier(
                isPresented: isPresented,
                builder: { builtDestination }
            )
        )
    }
    
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension SwiftBrickWrapper where Wrapped: View {
    func navigationDestination<Destination: View>(isActive: Binding<Bool>, destination: Destination) -> some View {
        return wrapped.modifier(NavigationLinkModifier(isActiveBinding: isActive, destination: destination))
    }
}
