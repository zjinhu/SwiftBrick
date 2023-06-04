#if os(macOS) || os(iOS)
import SwiftUI
 
@available(iOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
@available(tvOS, unavailable)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension SwiftBrickWrapper.ShareLink where Wrapped == Any {
    init(items: Data, subject: String? = nil, message: String? = nil)
    where PreviewImage == Never, PreviewIcon == Never, Data.Element == String, Label == DefaultShareLinkLabel {
        self.label = .init()
        self.data = items
        self.subject = subject
        self.message = message
        self.preview = { .init($0) }
    }

    init(items: Data, subject: String? = nil, message: String? = nil)
    where PreviewImage == Never, PreviewIcon == Never, Data.Element == URL, Label == DefaultShareLinkLabel {
        self.label = .init()
        self.data = items
        self.subject = subject
        self.message = message
        self.preview = { .init($0.absoluteString) }
    }

    init(items: Data, subject: String? = nil, message: String? = nil, @ViewBuilder label: () -> Label)
    where PreviewImage == Never, PreviewIcon == Never, Data.Element == String {
        self.label = label()
        self.data = items
        self.subject = subject
        self.message = message
        self.preview = { .init($0) }
    }

    init(items: Data, subject: String? = nil, message: String? = nil, @ViewBuilder label: () -> Label)
    where PreviewImage == Never, PreviewIcon == Never, Data.Element == URL {
        self.label = label()
        self.data = items
        self.subject = subject
        self.message = message
        self.preview = { .init($0.absoluteString) }
    }
}
#endif
