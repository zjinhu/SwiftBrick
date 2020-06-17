//
//  CALayerExtension.swift
//  SwiftBrick
//
//  Created by iOS on 22/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

public extension CALayer {
    
    /// 设置阴影--sketch效果
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - alpha: 透明度
    ///   - x: 以view的center算
    ///   - y: 以view的center算
    ///   - blur: 半径,多大阴影需要多大半径,必须比view的半径大
    ///   - spread: 模糊范围
    func sketchShadow(color: UIColor? = .black,
                       alpha: CGFloat = 0.5,
                       x: CGFloat = 0,
                       y: CGFloat = 0,
                       blur: CGFloat = 0,
                       spread: CGFloat = 0) {
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur * 0.5
        shadowColor = color?.cgColor
        shadowOpacity = Float(alpha)
        
        let rect = bounds.insetBy(dx: -spread, dy: -spread)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        shadowPath = path.cgPath
    }
}

//layer.jhSetShadow(color: .black, alpha: 0.5,
//                    x: 0, y: 10,
//                    blur: 20,
//                    spread: 10)


