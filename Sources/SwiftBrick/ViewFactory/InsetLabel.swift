//
//  InsetLabel.swift
//  SwiftBrick
//
//  Created by iOS on 2021/3/16.
//  Copyright © 2021 狄烨 . All rights reserved.
//

import UIKit
// MARK: ===================================Factory: UILabel with Insets=========================================
// MARK: ===================================工厂类:带内边距UILabel=========================================
/// Label with text insets support / 带内边距的Label
public class InsetLabel: UILabel {
    // 1. Property for text insets / 定义一个接受间距的属性
    public var textInsets = UIEdgeInsets.zero
    
    //2. Return recalculated text rectangle / 返回 label 重新计算过 text 的 rectangle
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard text != nil else {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
        
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    //3. Draw text with insets / 绘制文本时，对当前 rectangle 添加间距
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
