import SwiftUI
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public struct SharePreview<Image, Icon> {
    let title: String
    var icon: Icon?
    var image: Image?
    
    private init() { fatalError() }
}

@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
public extension SharePreview {
    init<S: StringProtocol>(_ title: S) where Image == Never, Icon == Never {
        self.title = title.description
    }
    
    init<S: StringProtocol>(_ title: S, icon: Icon) where Icon: View, Image == Never {
        self.title = title.description
        self.icon = icon
    }
    
    init<S: StringProtocol>(_ title: S, image: Image, icon: Icon) where Image: View, Icon: View {
        self.title = title.description
        self.image = image
        self.icon = icon
    }
}
