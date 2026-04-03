//
//  UIButtonEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/1/15.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
// MARK: ===================================Extension: UIButton Image and Text Layout=========================================
// MARK: ===================================扩展: UIButton扩展图文=========================================
/// Image position relative to text / 图片相对文本的位置
public enum ImagePosition {
    case imagePositionLeft
    case imagePositionRight
    case imagePositionTop
    case imagePositionBottom
}

public extension SwiftBrickWrapper where Wrapped: UIButton {
    /// UIButton image and text layout - variable size, fixed spacing / UIButton 图文布局 外观大小不固定 固定间距
    /// - Parameters:
    ///   - postion: Layout style / 布局样式
    ///   - space: Image-text spacing / 图文间距
    func layoutButton(_ postion: ImagePosition, space: CGFloat) {
        
        guard
            let imageSize = wrapped.imageView?.image?.size,
            let text = wrapped.titleLabel?.text,
            let font = wrapped.titleLabel?.font else { return }
        
        let titleSize = text.size(withAttributes: [.font: font])
        
        let imageOffsetX = (imageSize.width + titleSize.width) / 2 - imageSize.width / 2//image center offset X / image中心移动的x距离
        let imageOffsetY = imageSize.height / 2 + space / 2//image center offset Y / image中心移动的y距离
        let labelOffsetX = (imageSize.width + titleSize.width / 2) - (imageSize.width + titleSize.width) / 2//label center offset X / label中心移动的x距离
        let labelOffsetY = titleSize.height / 2 + space / 2//label center offset Y / label中心移动的y距离
        
        let tempWidth = max(titleSize.width, imageSize.width)
        let changedWidth = titleSize.width + imageSize.width - tempWidth
        let tempHeight = max(titleSize.height, imageSize.height);
        let changedHeight = titleSize.height + imageSize.height + space - tempHeight

        switch postion {
        case .imagePositionTop:
            wrapped.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            wrapped.titleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
            wrapped.contentEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -0.5 * changedWidth, bottom: changedHeight-imageOffsetY, right: -0.5 * changedWidth)
            
        case .imagePositionBottom:
            wrapped.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            wrapped.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom:labelOffsetY, right: labelOffsetX)
            wrapped.contentEdgeInsets = UIEdgeInsets(top: changedHeight-imageOffsetY, left: -0.5 * changedWidth, bottom: imageOffsetY, right: -0.5 * changedWidth)
            
        case .imagePositionRight:
            wrapped.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + 0.5 * space, bottom: 0, right: -(titleSize.width + 0.5 * space))
            wrapped.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + 0.5 * space), bottom: 0, right: imageSize.width + space * 0.5)
            wrapped.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.5 * space, bottom: 0, right: 0.5*space)
            
        default:
            wrapped.imageEdgeInsets = UIEdgeInsets(top: 0, left: -0.5 * space, bottom: 0, right: 0.5 * space)
            wrapped.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0.5 * space, bottom: 0, right: -0.5 * space)
            wrapped.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.5 * space, bottom: 0, right: 0.5 * space)
        }

    }
    
    /// UIButton image and text layout - fixed size / UIButton 图文布局 外观大小固定
    /// - Parameters:
    ///   - postion: Layout style / 布局样式
    ///   - margin: Image-text distance from both sides / 图文距离左右两边
    func layoutButton(_ postion: ImagePosition, margin: CGFloat) {

        guard
            let imageSize = wrapped.imageView?.image?.size,
            let text = wrapped.titleLabel?.text,
            let font = wrapped.titleLabel?.font else { return }
        
        let titleSize = text.size(withAttributes: [.font: font])
        
        let space = wrapped.bounds.size.width - imageSize.width - titleSize.width - 2 * margin
        layoutButton(postion, space: space)
    }

    /// Create solid color image / 创建纯色图片
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    /// Set background color for state / 为指定状态设置背景色
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        wrapped.setBackgroundImage(image(withColor: color), for: state)
    }
}

@available(iOS 14.0, *)
public extension SwiftBrickWrapper where Wrapped: UIControl {
    /// Add action for control event / 为控件事件添加动作
    func addAction(for event: UIControl.Event, handler: @escaping UIActionHandler) {
        wrapped.addAction(UIAction(handler:handler), for:event)
    }
}

public typealias ButtonClosure = (_ sender: UIButton) -> Void

public extension UIButton {
    
    struct AssociatedKeys {
        static var buttonTouchUpKey: UInt8 = 0
    }

    @objc internal var actionClosure: ButtonClosure? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.buttonTouchUpKey) as? ButtonClosure
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.buttonTouchUpKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// Add touch up inside button action with closure / 添加按钮点击事件闭包
    func addTouchUpInSideBtnAction(touchUp: ButtonClosure?){
        
        removeTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
        guard let ges = touchUp else {
            return
        }
        actionClosure = ges
        addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
    }
    
    /// Touch up inside button action handler / 按钮内部点击事件处理
    @objc func touchUpInSideBtnAction() {
        if let action = actionClosure  {
            action(self)
        }
    }
}

public extension UIButton {
    @IBInspectable
    var imageForDisabled: UIImage? {
        get { return image(for: .disabled) }
        set { setImage(newValue, for: .disabled) }
    }

    @IBInspectable
    var imageForHighlighted: UIImage? {
        get { return image(for: .highlighted) }
        set { setImage(newValue, for: .highlighted) }
    }

    @IBInspectable
    var imageForNormal: UIImage? {
        get { return image(for: .normal) }
        set { setImage(newValue, for: .normal) }
    }

    @IBInspectable
    var imageForSelected: UIImage? {
        get { return image(for: .selected) }
        set { setImage(newValue, for: .selected) }
    }

    @IBInspectable
    var titleColorForDisabled: UIColor? {
        get { return titleColor(for: .disabled) }
        set { setTitleColor(newValue, for: .disabled) }
    }

    @IBInspectable
    var titleColorForHighlighted: UIColor? {
        get { return titleColor(for: .highlighted) }
        set { setTitleColor(newValue, for: .highlighted) }
    }

    @IBInspectable
    var titleColorForNormal: UIColor? {
        get { return titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }

    @IBInspectable
    var titleColorForSelected: UIColor? {
        get { return titleColor(for: .selected) }
        set { setTitleColor(newValue, for: .selected) }
    }

    @IBInspectable
    var titleForDisabled: String? {
        get { return title(for: .disabled) }
        set { setTitle(newValue, for: .disabled) }
    }

    @IBInspectable
    var titleForHighlighted: String? {
        get { return title(for: .highlighted) }
        set { setTitle(newValue, for: .highlighted) }
    }

    @IBInspectable
    var titleForNormal: String? {
        get { return title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }

    @IBInspectable
    var titleForSelected: String? {
        get { return title(for: .selected) }
        set { setTitle(newValue, for: .selected) }
    }
    
    @IBInspectable
    var backImageForNormal: UIImage? {
        get { return backgroundImage(for: .normal) }
        set { setBackgroundImage(newValue, for: .normal) }
    }
    
    @IBInspectable
    var backImageForHighlighted: UIImage? {
        get { return backgroundImage(for: .highlighted) }
        set { setBackgroundImage(newValue, for: .highlighted) }
    }
    
    @IBInspectable
    var backImageForSelected: UIImage? {
        get { return backgroundImage(for: .selected) }
        set { setBackgroundImage(newValue, for: .selected) }
    }
    
    @IBInspectable
    var backImageForDisabled: UIImage? {
        get { return backgroundImage(for: .disabled) }
        set { setBackgroundImage(newValue, for: .disabled) }
    }

}
