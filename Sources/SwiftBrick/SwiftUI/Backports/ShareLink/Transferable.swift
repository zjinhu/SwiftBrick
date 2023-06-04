#if os(macOS) || os(iOS)
import SwiftUI

@available(iOS, deprecated: 16.0)
@available(macOS, deprecated: 13.0)
@available(watchOS, deprecated: 9.0)

/// TEMPORARY, DO NOT RELY ON THIS!
/// 
/// - Note: This **will be removed** in an upcoming release, regardless of semantic versioning
@available(iOS, message: "This **will be removed** in an upcoming release, regardless of semantic versioning")
@available(macOS, message: "This **will be removed** in an upcoming release, regardless of semantic versioning")
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public protocol Shareable {
    var pathExtension: String { get }
    var itemProvider: NSItemProvider? { get }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
internal struct ActivityItem<Data> where Data: RandomAccessCollection, Data.Element: Shareable {
    internal var data: Data
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension String: Shareable {
    public var pathExtension: String { "txt" }
    public var itemProvider: NSItemProvider? {
        do {
            let url = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent("\(UUID().uuidString)")
                .appendingPathExtension(pathExtension)
            try write(to: url, atomically: true, encoding: .utf8)
            return .init(contentsOf: url)
        } catch {
            return nil
        }
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension URL: Shareable {
    public var itemProvider: NSItemProvider? {
        .init(contentsOf: self)
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension Image: Shareable {
    public var pathExtension: String { "jpg" }
    public var itemProvider: NSItemProvider? {
        do {
            let url = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent("\(UUID().uuidString)")
                .appendingPathExtension(pathExtension)
            let renderer = SwiftBrickWrapper.ImageRenderer(content: self)

            #if os(iOS)
            let data = renderer.uiImage?.jpegData(compressionQuality: 0.8)
            #else
            let data = renderer.nsImage?.jpg(quality: 0.8)
            #endif

            try data?.write(to: url, options: .atomic)
            return .init(contentsOf: url)
        } catch {
            return nil
        }
    }
}
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) 
extension PlatformImage: Shareable {
    public var pathExtension: String { "jpg" }
    public var itemProvider: NSItemProvider? {
        do {
            let url = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent("\(UUID().uuidString)")
                .appendingPathExtension(pathExtension)
            let data = jpg(quality: 0.8)
            try data?.write(to: url, options: .atomic)
            return .init(contentsOf: url)
        } catch {
            return nil
        }
    }
}
#endif
