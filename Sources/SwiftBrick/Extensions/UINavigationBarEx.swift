//
//  UINavigationBarEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/9/4.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
// MARK: ===================================Extension: UINavigationBar Background and Divider=========================================
// MARK: ===================================扩展: UINavigationBar 背景色 分割线=========================================
public extension UINavigationBar {
 
    fileprivate struct AssociatedKeys {
        static var OverlayKey: UInt8 = 0
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
    
    /// Globally modify tint color (back button) / 全局修改主题色(返回按钮)
    /// - Parameter color: Tint color / 颜色
    static func setTintColor(_ color: UIColor){
        UINavigationBar.appearance().tintColor = color
    }

    /// Globally modify background color / 全局修改背景色
    /// - Parameter color: Background color / 颜色
    @available(iOS 13.0, *)
    static func setBackgroundColor(_ color: UIColor){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
         // Set background color / 设置背景颜色
        appearance.backgroundColor = color // UIColor
         // Unified appearance for all states / 统一各种情况下的显示样式
        setAppearance(appearance)
    }
    
    /// Globally modify title color / 全局修改标题色
    /// - Parameter color: Title color / 颜色
    @available(iOS 13.0, *)
    static func setTitleColor(_ color: UIColor){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
         // Set title color / 设置标题颜色
        appearance.titleTextAttributes = [.foregroundColor: color] // UIColor
         // Unified appearance for all states / 统一各种情况下的显示样式
        setAppearance(appearance)
    }
    
    /// Set shadow color / 设置阴影颜色
    @available(iOS 13.0, *)
    static func setShadowColor(_ color: UIColor = .clear){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
         // Set color / 设置颜色
        appearance.shadowColor = color // UIColor
         // Unified appearance for all states / 统一各种情况下的显示样式
        setAppearance(appearance)
    }
    
    /// Set navigation bar appearance / 设置导航栏外观
    @available(iOS 13.0, *)
    static func setAppearance(_ appearance: UINavigationBarAppearance){
         // Unified appearance for all states / 统一各种情况下的显示样式
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
}

public extension SwiftBrickWrapper where Wrapped: UINavigationBar {
    
    /// Set navigation bar background color / 设置导航栏背景色
    /// - Parameter color: Color / 颜色
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
    
    /// Set navigation bar translation Y / 设置导航栏Y轴平移
    func setTranslationY(_ translation: CGFloat) {
        wrapped.transform  = CGAffineTransform(translationX: 0, y: translation)
    }
    
    /// Set navigation bar element alpha / 设置导航栏元素透明度
    func setAlphaElements(_ alpha: CGFloat) {
        wrapped.alpha = alpha
        _ = wrapped.subviews.map { (subView)  in
            subView.alpha = alpha
        }
    }
    
    /// Reset navigation bar to default / 重置导航栏为默认
    func reset() {
        wrapped.setBackgroundImage(nil, for: .default)
        wrapped.overlay?.removeFromSuperview()
        wrapped.overlay = nil
    }
    
    /// Show/hide divider line / 隐藏|展示分割线
    /// - Parameter hidden: true/false / true/false
    func setLineHidden(hidden: Bool) {
        if let shadowImg = seekLineImageView(view: wrapped) {
            shadowImg.isHidden = hidden
        }
    }
    
    /// Recursively find divider image view / 递归查找分割线imageView
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
