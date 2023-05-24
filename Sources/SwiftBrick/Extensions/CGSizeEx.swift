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
public extension SwiftBrickWrapper where Base == CGSize {

    var minimumDimensionLength: CGFloat {
        min(base.width, base.height)
    }
    
    var maximumDimensionLength: CGFloat {
        max(base.width, base.height)
    }
    
    var isAreaZero: Bool {
        minimumDimensionLength.isZero
    }
}
