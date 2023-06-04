import SwiftUI

@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension SwiftBrickWrapper where Wrapped: View {
    /// Sets the available detents for the enclosing sheet.
    ///
    /// By default, sheets support the ``PresentationDetent/large`` detent.
    ///
    ///     struct ContentView: View {
    ///         @State private var showSettings = false
    ///
    ///         var body: some View {
    ///             Button("View Settings") {
    ///                 showSettings = true
    ///             }
    ///             .sheet(isPresented: $showSettings) {
    ///                 SettingsView()
    ///                     .presentationDetents([.medium, .large])
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameter detents: A set of supported detents for the sheet.
    ///   If you provide more than one detent, people can drag the sheet
    ///   to resize it.
    @ViewBuilder
    @available(iOS, introduced: 15, deprecated: 16, message: "Presentation detents are only supported in iOS 15+")
    func presentationDetents(_ detents: Set<SwiftBrickWrapper<Any>.PresentationDetent>) -> some View {
        #if os(iOS)
        wrapped.background(SwiftBrickWrapper<Any>.Representable(detents: detents, selection: nil))
        #else
        wrapped
        #endif
    }


    /// Sets the available detents for the enclosing sheet, giving you
    /// programmatic control of the currently selected detent.
    ///
    /// By default, sheets support the ``PresentationDetent/large`` detent.
    ///
    ///     struct ContentView: View {
    ///         @State private var showSettings = false
    ///         @State private var settingsDetent = PresentationDetent.medium
    ///
    ///         var body: some View {
    ///             Button("View Settings") {
    ///                 showSettings = true
    ///             }
    ///             .sheet(isPresented: $showSettings) {
    ///                 SettingsView()
    ///                     .presentationDetents:(
    ///                         [.medium, .large],
    ///                         selection: $settingsDetent
    ///                      )
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - detents: A set of supported detents for the sheet.
    ///     If you provide more that one detent, people can drag the sheet
    ///     to resize it.
    ///   - selection: A ``Binding`` to the currently selected detent.
    ///     Ensure that the value matches one of the detents that you
    ///     provide for the `detents` parameter.
    @ViewBuilder
    @available(iOS, introduced: 15, deprecated: 16, message: "Presentation detents are only supported in iOS 15+")
    func presentationDetents(_ detents: Set<SwiftBrickWrapper<Any>.PresentationDetent>, selection: Binding<SwiftBrickWrapper<Any>.PresentationDetent>) -> some View {
        #if os(iOS)
        wrapped.background(SwiftBrickWrapper<Any>.Representable(detents: detents, selection: selection))
        #else
        wrapped
        #endif
    }
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) 
public extension SwiftBrickWrapper<Any> {

    /// A type that represents a height where a sheet naturally rests.
    struct PresentationDetent: Hashable, Comparable {

        public struct Identifier: RawRepresentable, Hashable {
            public var rawValue: String
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            public static var medium: Identifier {
                .init(rawValue: "com.apple.UIKit.medium")
            }

            public static var large: Identifier {
                .init(rawValue: "com.apple.UIKit.large")
            }
        }

        public let id: Identifier

        /// The system detent for a sheet that's approximately half the height of
        /// the screen, and is inactive in compact height.
        public static var medium: PresentationDetent {
            .init(id: .medium)
        }

        /// The system detent for a sheet at full height.
        public static var large: PresentationDetent {
            .init(id: .large)
        }

        fileprivate static var none: PresentationDetent {
            return .init(id: .init(rawValue: ""))
        }

        public static func < (lhs: PresentationDetent, rhs: PresentationDetent) -> Bool {
            switch (lhs, rhs) {
            case (.large, .medium):
                return false
            default:
                return true
            }
        }
    }
}

#if os(iOS)
@available(iOS 15, *)
private extension SwiftBrickWrapper<Any> {
    struct Representable: UIViewControllerRepresentable {
        let detents: Set<SwiftBrickWrapper<Any>.PresentationDetent>
        let selection: Binding<SwiftBrickWrapper<Any>.PresentationDetent>?

        func makeUIViewController(context: Context) -> SwiftBrickWrapper.Representable.Controller {
            Controller(detents: detents, selection: selection)
        }

        func updateUIViewController(_ controller: SwiftBrickWrapper.Representable.Controller, context: Context) {
            controller.update(detents: detents, selection: selection)
        }
    }
}

@available(iOS 15, *)
private extension SwiftBrickWrapper.Representable {
    final class Controller: UIViewController, UISheetPresentationControllerDelegate {

        var detents: Set<SwiftBrickWrapper<Any>.PresentationDetent>
        var selection: Binding<SwiftBrickWrapper<Any>.PresentationDetent>?
        var largestUndimmed: SwiftBrickWrapper<Any>.PresentationDetent?
        weak var _delegate: UISheetPresentationControllerDelegate?

        init(detents: Set<SwiftBrickWrapper<Any>.PresentationDetent>, selection: Binding<SwiftBrickWrapper<Any>.PresentationDetent>?) {
            self.detents = detents
            self.selection = selection
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            if let controller = parent?.sheetPresentationController {
                if controller.delegate !== self {
                    _delegate = controller.delegate
                    controller.delegate = self
                }
            }
            update(detents: detents, selection: selection)
        }

        override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
            super.willTransition(to: newCollection, with: coordinator)
            update(detents: detents, selection: selection)
        }

        func update(detents: Set<SwiftBrickWrapper<Any>.PresentationDetent>, selection: Binding<SwiftBrickWrapper<Any>.PresentationDetent>?) {
            self.detents = detents
            self.selection = selection

            if let controller = parent?.sheetPresentationController {
                controller.animateChanges {
                    controller.detents = detents.sorted().map {
                        switch $0 {
                        case .medium:
                            return .medium()
                        default:
                            return .large()
                        }
                    }

                    if let selection = selection {
                        controller.selectedDetentIdentifier = .init(selection.wrappedValue.id.rawValue)
                    }

                    controller.prefersScrollingExpandsWhenScrolledToEdge = true
                }

                UIView.animate(withDuration: 0.25) {
                    if let undimmed = controller.largestUndimmedDetentIdentifier {
                        controller.presentingViewController.view?.tintAdjustmentMode = (selection?.wrappedValue ?? .large) >= .init(id: .init(rawValue: undimmed.rawValue)) ? .automatic : .normal
                    } else {
                        controller.presentingViewController.view?.tintAdjustmentMode = .automatic
                    }
                }
            }
        }

        func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
            guard
                let selection = selection,
                let id = sheetPresentationController.selectedDetentIdentifier?.rawValue,
                selection.wrappedValue.id.rawValue != id
            else { return }

            selection.wrappedValue = .init(id: .init(rawValue: id))
        }

        override func responds(to aSelector: Selector!) -> Bool {
            if super.responds(to: aSelector) { return true }
            if _delegate?.responds(to: aSelector) ?? false { return true }
            return false
        }

        override func forwardingTarget(for aSelector: Selector!) -> Any? {
            if super.responds(to: aSelector) { return self }
            return _delegate
        }
    }
}
#endif
