//
//  CGSizeEx.swift
//  SwiftBrick
//
//  Created by iOS on 2023/5/9.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import Foundation
public extension CGSize{
    static var greatestFiniteSize: CGSize {
        .init(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )
    }
}
public extension SwiftBrickWrapper where Wrapped == CGSize {

    var minimumDimensionLength: CGFloat {
        min(wrapped.width, wrapped.height)
    }
    
    var maximumDimensionLength: CGFloat {
        max(wrapped.width, wrapped.height)
    }
    
    var isAreaZero: Bool {
        minimumDimensionLength.isZero
    }
}
