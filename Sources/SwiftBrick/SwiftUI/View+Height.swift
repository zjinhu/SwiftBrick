//
//  ViewEx.swift
//  SwiftBrick
//
//  Created by iOS on 2023/4/20.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public extension View {
    func readHeight(onChange action: @escaping (CGFloat) -> ()) -> some View {
        background(heightReader)
            .onPreferenceChange(HeightPreferenceKey.self, perform: action)
    }
}

@available(iOS 13.0, *)
private extension View {
    var heightReader: some View {
        GeometryReader {
            Color.clear
                .preference(key: HeightPreferenceKey.self, value: $0.size.height)
        }
    }
}

fileprivate struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
