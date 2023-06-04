#if os(macOS) || os(iOS)
import SwiftUI
#if canImport(LinkPresentation)
import LinkPresentation
#endif

@available(iOS, deprecated: 16)
@available(macOS, deprecated: 13)
@available(watchOS, deprecated: 9)
@available(tvOS, unavailable)
@available(iOS 14, tvOS 14, macOS 12, watchOS 8, *)
public extension SwiftBrickWrapper where Wrapped == Any {
    struct ShareLink<Data, PreviewImage, PreviewIcon, Label>: View where Data: RandomAccessCollection, Data.Element: Shareable, Label: View {
        @State private var activity: ActivityItem<Data>?

        let label: Label
        let data: Data
        let subject: String?
        let message: String?
        let preview: (Data.Element) -> SharePreview<PreviewImage, PreviewIcon>

        public var body: some View {
            Button {
                activity = ActivityItem(data: data)
            } label: {
                label
            }
            .shareSheet(item: $activity)
        }
    }
}

#endif
