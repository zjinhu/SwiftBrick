//
//  NavigationLink.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2023/6/6.
//
import SwiftUI
@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper where Wrapped == Any {
    public struct NavigationLink<P: Hashable, Label: View>: View {
        var value: P?
        var label: Label
        
        @EnvironmentObject var pathAppender: PathAppender
        
        public init(value: P?, @ViewBuilder label: () -> Label) {
            self.value = value
            self.label = label()
        }
        
        public var body: some View {
            // TODO: Ensure this button is styled more like a NavigationLink within a List.
            // See: https://gist.github.com/tgrapperon/034069d6116ff69b6240265132fd9ef7
            Button(
                action: {
                    guard let value = value else { return }
                    pathAppender.append?(value)
                },
                label: { label }
            )
        }
    }
}

@available(iOS, deprecated: 16)
@available(tvOS, deprecated: 16)
@available(watchOS, deprecated: 9)
@available(macOS, deprecated: 13)
@available(iOS 14, macOS 11, watchOS 7, tvOS 14, *)
extension SwiftBrickWrapper.NavigationLink where Label == Text {
    public init(_ titleKey: LocalizedStringKey, value: P?) {
        self.init(value: value) { Text(titleKey) }
    }
    
    public init<S>(_ title: S, value: P?) where S: StringProtocol {
        self.init(value: value) { Text(title) }
    }
}
