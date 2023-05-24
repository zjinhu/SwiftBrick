//
// Copyright (c) Vatsal Manot
//

import SwiftUI

@available(iOS 13.0, *)
public extension Image {
    init(systemName: SFSymbolName) {
        #if os(macOS)
        if #available(OSX 11.0, *) {
            self.init(systemName: systemName.rawValue)
        } else {
            fatalError()
        }
        #else
        self.init(systemName: systemName.rawValue)
        #endif
    }
}

@available(iOS 13.0, *)
extension Image {

    public func sizeToFit(
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        alignment: Alignment = .center
    ) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height, alignment: alignment)
    }
    
    @_disfavoredOverload
    public func sizeToFit(
        _ size: CGSize? = nil,
        alignment: Alignment = .center
    ) -> some View {
        sizeToFit(width: size?.width, height: size?.height, alignment: alignment)
    }
    
    public func sizeToFitSquare(
        sideLength: CGFloat?,
        alignment: Alignment = .center
    ) -> some View {
        sizeToFit(width: sideLength, height: sideLength, alignment: alignment)
    }
}
