import SwiftUI

/// A scrollable `VStack` that respects elemnts like `Spacer()`
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) 
public struct VScrollStack<Content: View>: View {
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat?
    private let showsIndicators: Bool
    private let content: Content

    /// Creates a new instance that’s vertically scrollable and can show indicators while scrolling.
    /// - Parameters:
    ///   - alignment: The guide for aligning the subviews in this stack. This guide has the same horizontal screen coordinate for every subview
    ///   - spacing: The distance between adjacent subviews, or nil if you want the stack to choose a default distance for each pair of subviews.
    ///   - showsIndicators: A Boolean value that indicates whether the scroll view displays the scrollable component of the content offset, in a way suitable for the platform. The default value for this parameter is true.
    ///   - content: The view builder that creates the scrollable view.
    public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, showsIndicators: Bool = true, @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.content = content()
    }

    public var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: showsIndicators) {
                VStack(alignment: alignment, spacing: spacing) {
                    content
                }
                .frame(
                    maxWidth: geo.size.width,
                    minHeight: geo.size.height
                )
            }
        }
    }
}
