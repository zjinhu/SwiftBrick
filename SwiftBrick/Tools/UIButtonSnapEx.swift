//
//  UIButtonSnapEx.swift
//  SwiftBrick
//
//  Created by iOS on 22/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import SnapKit
// MARK: ===================================工厂类:UIButton SnapKit=========================================
public extension UIButton {

    /// 快速初始化UIButton 包含默认参数,初始化过程可以删除部分默认参数简化方法
    /// - Parameters:
    ///   - supView:  被添加的位置 有默认参数
    ///   - title: 标题 有默认参数
    ///   - font: 字体 有默认参数
    ///   - titleNorColor: 默认字体颜色 有默认参数
    ///   - titleHigColor: 高亮字体颜色 有默认参数
    ///   - norImage: 默认图片 有默认参数
    ///   - higImage: 高亮图片 有默认参数
    ///   - snapKitMaker: SnapKit 有默认参数
    ///   - touchUp: 点击Block 有默认参数
    ///   - backColor: 背景色
    @discardableResult
    class func snpButton(supView: UIView? = nil,
                         backColor: UIColor? = .clear,
                         title: String? = nil,
                         font: UIFont? = nil,
                         titleNorColor: UIColor? = nil,
                         titleHigColor: UIColor? = nil,
                         norImage: UIImage? = nil,
                         higImage: UIImage? = nil,
                         touchUp: ButtonClosure? = nil,
                         snapKitMaker: ((_ make: ConstraintMaker) -> Void)? = nil) -> UIButton {
        
        let btn = UIButton(type: .custom)
        btn.backgroundColor = backColor
        
        if title != nil {
            btn.setTitle(title, for: .normal)
        }
        
        if font != nil {
            btn.titleLabel?.font = font
        }else{
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        
        if titleNorColor != nil {
            btn.setTitleColor(titleNorColor, for: .normal)
        }else{
            btn.setTitleColor(.black, for: .normal)
        }
        
        if titleHigColor != nil {
            btn.setTitleColor(titleHigColor, for: .highlighted)
        }
        
        if norImage != nil {
            btn.setImage(norImage, for: .normal)
        }
        
        if higImage != nil {
            btn.setImage(higImage, for: .highlighted)
        }
        
        guard let sv = supView, let maker = snapKitMaker else {
            return btn
        }
        sv.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            maker(make)
        }
        guard let ges = touchUp else {
            return btn
        }
        btn.addTouchUpInSideBtnAction(touchUp: ges)

        return btn
    }

}
