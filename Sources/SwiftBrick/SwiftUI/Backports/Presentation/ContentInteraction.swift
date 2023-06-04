import SwiftUI

@available(iOS, deprecated: 16.4)
@available(tvOS, deprecated: 16.4)
@available(macOS, deprecated: 13.3)
@available(watchOS, deprecated: 9.4)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) 
public extension SwiftBrickWrapper<Any> {
    /// A behavior that you can use to influence how a presentation responds to
    /// swipe gestures.
    ///
    /// Use values of this type with the
    /// ``View/presentationContentInteraction(_:)`` modifier.
    struct PresentationContentInteraction: Hashable {
        enum Interaction: Hashable {
            case automatic
            case resizes
            case scrolls
        }

        let interaction: Interaction

        /// The default swipe behavior for the presentation.
        public static var automatic: PresentationContentInteraction { .init(interaction: .automatic) }

        /// A behavior that prioritizes resizing a presentation when swiping, rather
        /// than scrolling the content of the presentation.
        public static var resizes: PresentationContentInteraction { .init(interaction: .resizes) }

        /// A behavior that prioritizes scrolling the content of a presentation when
        /// swiping, rather than resizing the presentation.
        public static var scrolls: PresentationContentInteraction { .init(interaction: .scrolls) }
    }
}

@available(iOS, deprecated: 16.4)
@available(tvOS, deprecated: 16.4)
@available(macOS, deprecated: 13.3)
@available(watchOS, deprecated: 9.4)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) 
public extension SwiftBrickWrapper where Wrapped: View {
    @ViewBuilder
    func presentationContentInteraction(_ interaction: SwiftBrickWrapper<Any>.PresentationContentInteraction) -> some View {
        #if os(iOS)
        if #available(iOS 15, *) {
            wrapped.background(SwiftBrickWrapper<Any>.Representable(interaction: interaction))
        } else {
            wrapped
        }
        #else
        wrapped
        #endif
    }
}

#if os(iOS)
@available(iOS 15, *)
private extension SwiftBrickWrapper where Wrapped == Any {
    struct Representable: UIViewControllerRepresentable {
        let interaction: SwiftBrickWrapper<Any>.PresentationContentInteraction

        func makeUIViewController(context: Context) -> SwiftBrickWrapper.Representable.Controller {
            Controller(interaction: interaction)
        }

        func updateUIViewController(_ controller: SwiftBrickWrapper.Representable.Controller, context: Context) {
            controller.update(interaction: interaction)
        }
    }
}

@available(iOS 15, *)
private extension SwiftBrickWrapper.Representable {
    final class Controller: UIViewController, UISheetPresentationControllerDelegate {
        var interaction: SwiftBrickWrapper<Any>.PresentationContentInteraction

        init(interaction: SwiftBrickWrapper<Any>.PresentationContentInteraction) {
            self.interaction = interaction
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            update(interaction: interaction)
        }

        override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
            super.willTransition(to: newCollection, with: coordinator)
            update(interaction: interaction)
        }

        func update(interaction: SwiftBrickWrapper<Any>.PresentationContentInteraction) {
            self.interaction = interaction

            if let controller = parent?.sheetPresentationController {
                controller.animateChanges {
                    switch interaction.interaction {
                    case .automatic, .resizes:
                        controller.prefersScrollingExpandsWhenScrolledToEdge = true
                    case .scrolls:
                        controller.prefersScrollingExpandsWhenScrolledToEdge = false
                    }
                }
            }
        }
    }
}
#endif
