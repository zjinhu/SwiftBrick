//
//  CALayerExtension.swift
//  SwiftBrick
//
//  Created by iOS on 22/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
// MARK: ===================================Extension: Shadow, Border, Corner Radius=========================================
// MARK: ===================================扩展: 阴影 边框 圆角=========================================
public extension SwiftBrickWrapper where Wrapped == CALayer {
    
    /// Set sketch-style shadow / 设置阴影--sketch效果
    /// - Parameters:
    ///   - color: Shadow color / 阴影颜色
    ///   - alpha: Opacity / 透明度
    ///   - x: X offset from center / 以view的center算
    ///   - y: Y offset from center / 以view的center算
    ///   - blur: Shadow radius, must be larger than view radius / 半径,多大阴影需要多大半径,必须比view的半径大
    ///   - spread: Blur range / 模糊范围
    func sketchShadow(color: UIColor? = .black,
                       alpha: CGFloat = 0.5,
                       x: CGFloat = 0,
                       y: CGFloat = 0,
                       blur: CGFloat = 0,
                       spread: CGFloat = 0) {
        wrapped.shadowOffset = CGSize(width: x, height: y)
        wrapped.shadowRadius = blur * 0.5
        wrapped.shadowColor = color?.cgColor
        wrapped.shadowOpacity = Float(alpha)
        
        let rect = wrapped.bounds.insetBy(dx: -spread, dy: -spread)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: wrapped.cornerRadius)
        wrapped.shadowPath = path.cgPath
    }
    
    /// Set shadow properties / 设置阴影
    /// - Parameters:
    ///   - color: Shadow color / 阴影颜色
    ///   - x: shadowOffset X / shadowOffset
    ///   - y: shadowOffset Y / shadowOffset
    ///   - alpha: shadowOpacity / shadowOpacity
    ///   - radius: shadowRadius / shadowRadius
    func setShadow(color: UIColor? = .black,
                   x: CGFloat = 0,
                   y: CGFloat = 0,
                   alpha: Float = 0.5,
                   radius: CGFloat = 0) {
        // Set shadow color / 设置阴影颜色
        wrapped.shadowColor = color?.cgColor
        // Set opacity / 设置透明度
        wrapped.shadowOpacity = alpha
        // Set shadow radius / 设置阴影半径
        wrapped.shadowRadius = radius
        // Set shadow offset / 设置阴影偏移量
        wrapped.shadowOffset = CGSize(width: x, height: y)
    }
    
    /// Set border or corner radius / 设置边框 或 圆角
    /// - Parameters:
    ///   - color: Border color / 阴影颜色
    ///   - width: borderWidth / borderWidth
    ///   - corner: cornerRadius / cornerRadius
    func setBorder(color: UIColor? = .clear,
                   width: CGFloat = 0.5,
                   corner: CGFloat = 0){
        // Set border width / 设置视图边框宽度
        wrapped.borderWidth = width
        // Set border color / 设置边框颜色
        wrapped.borderColor = color?.cgColor
        // Set corner radius / 设置边框圆角
        wrapped.cornerRadius = corner
    }

    /// Set partial corner radius, view must set clipsToBounds = true / 设置部分圆角 需要View设置clipsToBounds = true
    /// - Parameters:
    ///   - radius: Corner radius / 圆角半径
    ///   - corners: CACornerMask - rightBottom, rightTop, leftBottom, leftTop, all, bothTop, bothBottom, bothLeft, bothRight / CACornerMask集合 rightBottom:右下  rightTop:右上  leftBottom:左下  leftTop:左上  all:全部 bothTop:上边  bothBottom:下边  bothLeft:左边  bothRight:右边
    func setCorners(_ radius: CGFloat, corners: CACornerMask){
        wrapped.cornerRadius = radius
        wrapped.maskedCorners = corners
    }
}

public extension CACornerMask {

    /// Top-left corner / 左上角
    static let leftTop = CACornerMask.layerMinXMinYCorner

    /// Top-right corner / 右上角
    static let rightTop = CACornerMask.layerMaxXMinYCorner

    /// Bottom-left corner / 左下角
    static let leftBottom = CACornerMask.layerMinXMaxYCorner

    /// Bottom-right corner / 右下角
    static let rightBottom = CACornerMask.layerMaxXMaxYCorner
    
    /// All corners / 全部角
    static let all: CACornerMask = [.leftTop, .rightTop, .leftBottom, .rightBottom]
    
    /// Both top corners / 上边两角
    static let bothTop: CACornerMask = [.leftTop, .rightTop]
    
    /// Both bottom corners / 下边两角
    static let bothBottom: CACornerMask = [.leftBottom, .rightBottom]
    
    /// Both left corners / 左边两角
    static let bothLeft: CACornerMask = [.leftTop, .leftBottom]
    
    /// Both right corners / 右边两角
    static let bothRight: CACornerMask = [.rightTop, .rightBottom]
}
