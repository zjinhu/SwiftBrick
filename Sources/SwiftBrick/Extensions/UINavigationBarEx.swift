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
    
    /// 全局修改主题色(返回按钮)
    /// - Parameter color
    static func setTintColor(_ color: UIColor){
        UINavigationBar.appearance().tintColor = color
    }

    /// 全局修改背景色
    /// - Parameter color
    @available(iOS 13.0, *)
    static func setBackgroundColor(_ color: UIColor){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
         //设置背景颜色
        appearance.backgroundColor = color // UIColor
         //统一各种情况下的显示样式
        setAppearance(appearance)
    }
    
    /// 全局修改标题色
    /// - Parameter color
    @available(iOS 13.0, *)
    static func setTitleColor(_ color: UIColor){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
         //设置标题颜色
        appearance.titleTextAttributes = [.foregroundColor: color] // UIColor
         //统一各种情况下的显示样式
        setAppearance(appearance)
    }
    
    @available(iOS 13.0, *)
    static func setShadowColor(_ color: UIColor = .clear){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
         //设置颜色
        appearance.shadowColor = color // UIColor
         //统一各种情况下的显示样式
        setAppearance(appearance)
    }
    
    @available(iOS 13.0, *)
    static func setAppearance(_ appearance: UINavigationBarAppearance){
         //统一各种情况下的显示样式
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
}

public extension SwiftBrickWrapper where Wrapped: UINavigationBar {
    
    /// 设置导航栏背景色
    /// - Parameter color: 颜色
    func setBackgroundColor(_ color: UIColor) {
        
        if wrapped.overlay == nil {
            wrapped.setBackgroundImage(UIImage(), for: .default)
            wrapped.overlay = UIView(frame: CGRect(x: 0, y: -Define.statusBarHeight(), width: wrapped.bounds.width, height: wrapped.bounds.height + Define.statusBarHeight() ))
            wrapped.overlay?.isUserInteractionEnabled = false
            wrapped.overlay?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            wrapped.overlay?.layer.zPosition = -9999
            wrapped.insertSubview(wrapped.overlay!, at: 0)
        }
        
        wrapped.overlay?.backgroundColor = color
    }
    
    func setTranslationY(_ translation: CGFloat) {
        wrapped.transform  = CGAffineTransform(translationX: 0, y: translation)
    }
    
    func setAlphaElements(_ alpha: CGFloat) {
        wrapped.alpha = alpha
        _ = wrapped.subviews.map { (subView)  in
            subView.alpha = alpha
        }
    }
    
    func reset() {
        wrapped.setBackgroundImage(nil, for: .default)
        wrapped.overlay?.removeFromSuperview()
        wrapped.overlay = nil
    }
    
    /// 隐藏/展示分割线
    /// - Parameter hidden: true/false
    func setLineHidden(hidden: Bool) {
        if let shadowImg = seekLineImageView(view: wrapped) {
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
