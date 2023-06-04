import SwiftUI

#if os(iOS)

import UIKit

public typealias PlatformImage = UIImage
public typealias PlatformScreen = UIScreen

internal typealias PlatformView = UIView
internal typealias PlatformScrollView = UIScrollView
internal typealias PlatformViewController = UIViewController

extension UIScreen {
    @nonobjc
    public static var mainScreen: UIScreen { .main }
}

extension UIImage {
    public var png: Data? { pngData() }
    public func jpg(quality: CGFloat) -> Data? { jpegData(compressionQuality: quality) }
}

extension CGContext {
    internal static var current: CGContext? {
        UIGraphicsGetCurrentContext()
    }
}


#elseif os(macOS)

import AppKit

public typealias PlatformImage = NSImage
public typealias PlatformScreen = NSScreen

internal typealias PlatformView = NSView
internal typealias PlatformScrollView = NSScrollView
internal typealias PlatformViewController = NSViewController

extension NSScreen {
    public static var mainScreen: NSScreen { NSScreen.main! }
    public var scale: CGFloat { backingScaleFactor }
}

extension NSImage {
    public var png: Data? {
        return NSBitmapImageRep(data: tiffRepresentation!)?.representation(using: .png, properties: [:])
    }

    public func jpg(quality: CGFloat) -> Data? {
        return NSBitmapImageRep(data: tiffRepresentation!)?.representation(using: .jpeg, properties: [.compressionFactor: quality])
    }
}

extension CGContext {
    internal static var current: CGContext? {
        NSGraphicsContext.current?.cgContext
    }
}
#endif

#if os(iOS) || os(macOS)

internal extension PlatformViewController {
    func ancestor<ControllerType: PlatformViewController>(ofType type: ControllerType.Type) -> ControllerType? {
        var controller = parent
        while let c = controller {
            if let typed = c as? ControllerType {
                return typed
            }
            controller = c.parent
        }
        return nil
    }

    func sibling<ControllerType: PlatformViewController>(ofType type: ControllerType.Type) -> ControllerType? {
        guard let controller = parent, let index = controller.children.firstIndex(of: self) else { return nil }

        var children = controller.children
        children.remove(at: index)

        for c in children.reversed() {
            if let typed = c as? ControllerType {
                return typed
            } else if let typed = c.descendent(ofType: type) {
                return typed
            }
        }

        return nil
    }

    func descendent<ControllerType: PlatformViewController>(ofType type: ControllerType.Type) -> ControllerType? {
        for c in children {
            if let typed = c as? ControllerType {
                return typed
            } else if let typed = c.descendent(ofType: type) {
                return typed
            }
        }

        return nil
    }
}

internal extension PlatformView {
    func ancestor<ViewType: PlatformView>(ofType type: ViewType.Type) -> ViewType? {
        var view = superview
        while let s = view {
            if let typed = s as? ViewType {
                return typed
            }
            view = s.superview
        }
        return nil
    }

    func sibling<ViewType: PlatformView>(ofType type: ViewType.Type) -> ViewType? {
        guard let superview = superview, let index = superview.subviews.firstIndex(of: self) else { return nil }

        var views = superview.subviews
        views.remove(at: index)

        for subview in views.reversed() {
            if let typed = subview as? ViewType {
                return typed
            } else if let typed = subview.descendent(ofType: type) {
                return typed
            }
        }

        return nil
    }

    func descendent<ViewType: PlatformView>(ofType type: ViewType.Type) -> ViewType? {
        for subview in subviews {
            if let typed = subview as? ViewType {
                return typed
            } else if let typed = subview.descendent(ofType: type) {
                return typed
            }
        }

        return nil
    }

    var host: PlatformView? {
        var view = superview
        while let s = view {
            if NSStringFromClass(type(of: s)).contains("ViewHost") {
                return s
            }
            view = s.superview
        }
        return nil
    }
}

internal struct Inspector {
    var hostView: PlatformView
    var sourceView: PlatformView
    var sourceController: PlatformViewController

    func `any`<ViewType: PlatformView>(ofType: ViewType.Type) -> ViewType? {
        ancestor(ofType: ViewType.self)
        ?? sibling(ofType: ViewType.self)
        ?? descendent(ofType: ViewType.self)
    }

    func ancestor<ViewType: PlatformView>(ofType: ViewType.Type) -> ViewType? {
        hostView.ancestor(ofType: ViewType.self)
    }

    func sibling<ViewType: PlatformView>(ofType: ViewType.Type) -> ViewType? {
        hostView.sibling(ofType: ViewType.self)
    }

    func descendent<ViewType: PlatformView>(ofType: ViewType.Type) -> ViewType? {
        hostView.descendent(ofType: ViewType.self)
    }

    func `any`<ControllerType: PlatformViewController>(ofType: ControllerType.Type) -> ControllerType? {
        ancestor(ofType: ControllerType.self)
        ?? sibling(ofType: ControllerType.self)
        ?? descendent(ofType: ControllerType.self)
    }

    func ancestor<ControllerType: PlatformViewController>(ofType: ControllerType.Type) -> ControllerType? {
        sourceController.ancestor(ofType: ControllerType.self)
    }

    func sibling<ControllerType: PlatformViewController>(ofType: ControllerType.Type) -> ControllerType? {
        sourceController.sibling(ofType: ControllerType.self)
    }

    func descendent<ControllerType: PlatformViewController>(ofType: ControllerType.Type) -> ControllerType? {
        sourceController.descendent(ofType: ControllerType.self)
    }
}

internal struct Proxy<T> {
    let inspector: Inspector
    let instance: T
}

@available(iOS 14, macOS 11, *)
extension View {
    private func inject<Wrapped>(_ wrapped: Wrapped) -> some View where Wrapped: View {
        overlay(wrapped.frame(width: 0, height: 0))
    }

    func `any`<T: PlatformView>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.any(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }

    func ancestor<T: PlatformView>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.ancestor(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }

    func sibling<T: PlatformView>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.sibling(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }

    func descendent<T: PlatformView>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.descendent(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }

    func `any`<T: PlatformViewController>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.any(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }

    func ancestor<T: PlatformViewController>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.ancestor(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }

    func sibling<T: PlatformViewController>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.sibling(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }

    func descendent<T: PlatformViewController>(forType type: T.Type, body: @escaping (Proxy<T>) -> Void) -> some View {
        inject(InspectionView { inspector in
            inspector.descendent(ofType: T.self)
        } customize: { proxy in
            body(proxy)
        })
    }
}
@available(iOS 14, macOS 11, *)
private struct InspectionView<T>: View {
    let selector: (Inspector) -> T?
    let customize: (Proxy<T>) -> Void

    var body: some View {
        Representable(parent: self)
    }
}
@available(iOS 14, macOS 11, *)
private class SourceView: PlatformView {
    required init() {
        super.init(frame: .zero)
        isHidden = true
#if os(iOS)
        isUserInteractionEnabled = false
#endif
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif

#if os(iOS)
@available(iOS 14.0, *)
private extension InspectionView {
    struct Representable: UIViewRepresentable {
        let parent: InspectionView

        func makeUIView(context: Context) -> UIView { .init() }
        func updateUIView(_ view: UIView, context: Context) {
            DispatchQueue.main.async {
                guard let host = view.host else { return }

                let inspector = Inspector(
                    hostView: host,
                    sourceView: view,
                    sourceController: view.parentController
                    ?? view.window?.rootViewController
                    ?? UIViewController()
                )

                guard let target = parent.selector(inspector) else { return }
                parent.customize(.init(inspector: inspector, instance: target))
            }
        }
    }
}
#elseif os(macOS)
@available(macOS 11, *)
private extension InspectionView {
    struct Representable: NSViewRepresentable {
        let parent: InspectionView

        func makeNSView(context: Context) -> NSView {
            .init(frame: .zero)
        }

        func updateNSView(_ view: NSView, context: Context) {
            DispatchQueue.main.async {
                guard let host = view.host else { return }

                let inspector = Inspector(
                    hostView: host,
                    sourceView: view,
                    sourceController: view.parentController ?? NSViewController(nibName: nil, bundle: nil)
                )

                guard let target = parent.selector(inspector) else { return }
                parent.customize(.init(inspector: inspector, instance: target))
            }
        }
    }
}
#endif
