//
//  UINavigationBarEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/9/4.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
// MARK: ===================================扩展: UINavigationBar 背景色 分割线=========================================
public extension UINavigationBar {
    
    fileprivate struct AssociatedKeys {
        static var OverlayKey = "overlayKey"
    }
    
    fileprivate var overlay: UIView? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.OverlayKey) as? UIView
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject( self, &AssociatedKeys.OverlayKey, newValue as UIView?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
}

public extension SwiftBrickWrapper where Base: UINavigationBar {
    
    /// 设置导航栏背景色
    /// - Parameter color: 颜色
    func setBackgroundColor(_ color: UIColor) {
        
        if base.overlay == nil {
            base.setBackgroundImage(UIImage(), for: .default)
            base.overlay = UIView(frame: CGRect(x: 0, y: -Define.statusBarHeight(), width: base.bounds.width, height: base.bounds.height + Define.statusBarHeight() ))
            base.overlay?.isUserInteractionEnabled = false
            base.overlay?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            base.overlay?.layer.zPosition = -9999
            base.insertSubview(base.overlay!, at: 0)
        }
        
        base.overlay?.backgroundColor = color
    }
    
    func setTranslationY(_ translation: CGFloat) {
        base.transform  = CGAffineTransform(translationX: 0, y: translation)
    }
    
    func setAlphaElements(_ alpha: CGFloat) {
        base.alpha = alpha
        _ = base.subviews.map { (subView)  in
            subView.alpha = alpha
        }
    }
    
    func reset() {
        base.setBackgroundImage(nil, for: .default)
        base.overlay?.removeFromSuperview()
        base.overlay = nil
    }
    
    /// 隐藏/展示分割线
    /// - Parameter hidden: true/false
    func setLineHidden(hidden: Bool) {
        if let shadowImg = seekLineImageView(view: base) {
            shadowImg.isHidden = hidden
        }
    }
    
    fileprivate func seekLineImageView(view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }

        for subview in view.subviews {
            if let imageView = seekLineImageView(view: subview) {
                return imageView
            }
        }
        return nil
    }
}
