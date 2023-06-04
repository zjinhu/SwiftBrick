#if os(iOS)
import SwiftUI
@available(iOS 14.0, *)
public extension SwiftBrickWrapper<Any> {
    enum ToolbarItemPlacement {
        case automatic
        case primaryAction
        case confirmationAction
        case cancellationAction
        case destructiveAction
        case principal
        case bottomBar

        var isLeading: Bool {
            switch self {
            case .cancellationAction:
                return true
            default:
                return false
            }
        }

        var isTrailing: Bool {
            switch self {
            case .automatic, .primaryAction, .confirmationAction, .destructiveAction:
                return true
            default:
                return false
            }
        }
    }

    struct ToolbarItem: View {
        let id: String
        let placement: SwiftBrickWrapper.ToolbarItemPlacement
        let content: AnyView

        public init<Content: View>(id: String = UUID().uuidString, placement: SwiftBrickWrapper.ToolbarItemPlacement = .automatic, @ViewBuilder content: () -> Content) {
            self.id = id
            self.placement = placement
            self.content = AnyView(content())
        }

        public var body: some View {
            content.id(id)
        }
    }
}
@available(iOS 14.0, *)
extension Collection where Element == SwiftBrickWrapper<Any>.ToolbarItem, Indices: RandomAccessCollection, Indices.Index: Hashable {
    @ViewBuilder var content: some View {
        if !isEmpty {
            HStack {
                ForEach(indices, id: \.self) { index in
                    self[index].content
                }
            }
        }
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
private extension SwiftBrickWrapper where Wrapped: View {
    func largeScale() -> some View {
        #if os(macOS)
        if #available(macOS 11, *) {
            wrapped.imageScale(.large)
        } else {
            wrapped
        }
        #else
        wrapped.imageScale(.large)
        #endif
    }
}
@available(iOS 14.0, *)
public extension SwiftBrickWrapper<Any> {
    @resultBuilder struct ToolbarContentBuilder { }
}
@available(iOS 14.0, *)
public extension SwiftBrickWrapper<Any>.ToolbarContentBuilder {
    static func buildBlock() -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [.init(content: EmptyView.init)]
    }

    static func buildBlock(_ content: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [content]
    }

    static func buildIf(_ content: SwiftBrickWrapper<Any>.ToolbarItem?) -> [SwiftBrickWrapper<Any>.ToolbarItem?] {
        [content].compactMap { $0 }
    }

    static func buildEither(first: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [first]
    }

    static func buildEither(second: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [second]
    }

    static func buildLimitedAvailability(_ content: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [content]
    }

    static func buildBlock(_ c0: SwiftBrickWrapper<Any>.ToolbarItem, _ c1: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [c0, c1]
    }

    static func buildBlock(_ c0: SwiftBrickWrapper<Any>.ToolbarItem, _ c1: SwiftBrickWrapper<Any>.ToolbarItem, _ c2: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [c0, c1, c2]
    }

    static func buildBlock(_ c0: SwiftBrickWrapper<Any>.ToolbarItem, _ c1: SwiftBrickWrapper<Any>.ToolbarItem, _ c2: SwiftBrickWrapper<Any>.ToolbarItem, _ c3: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [c0, c1, c2, c3]
    }

    static func buildBlock(_ c0: SwiftBrickWrapper<Any>.ToolbarItem, _ c1: SwiftBrickWrapper<Any>.ToolbarItem, _ c2: SwiftBrickWrapper<Any>.ToolbarItem, _ c3: SwiftBrickWrapper<Any>.ToolbarItem, _ c4: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [c0, c1, c2, c3, c4]
    }

    static func buildBlock(_ c0: SwiftBrickWrapper<Any>.ToolbarItem, _ c1: SwiftBrickWrapper<Any>.ToolbarItem, _ c2: SwiftBrickWrapper<Any>.ToolbarItem, _ c3: SwiftBrickWrapper<Any>.ToolbarItem, _ c4: SwiftBrickWrapper<Any>.ToolbarItem, _ c5: SwiftBrickWrapper<Any>.ToolbarItem) -> [SwiftBrickWrapper<Any>.ToolbarItem] {
        [c0, c1, c2, c3, c4, c5]
    }
}
#endif
