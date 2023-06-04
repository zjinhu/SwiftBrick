//
//  JHBaseVC.swift
//  SwiftBrick
//
//  Created by iOS on 2023/4/24.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import Foundation
import UIKit

public extension SwiftBrick{
    ///当导航栏从隐藏的页面滑动到有导航栏的页面或者从有到无的页面滑动,使过度更加平滑,vc需要隐藏导航栏设置下prefersNavigationBarHidden = true
    //MARK: ‼️APP初始化时需要交换一下方法‼️重要①‼️
    static func inits() {
        SwizzleNavBar.swizzle
    }
}

public extension SwiftBrickWrapper where Wrapped: UIViewController {
    
    func hideDefaultBackBarButton(){
        wrapped.navigationItem.hidesBackButton = true
    }
    
    func addLeftBarButton(normalImage: UIImage?,
                          highLightImage: UIImage? = nil,
                          touchUp: ButtonClosure?){
        
        configLeftBarButton(text:"      ",
                            normalImage: normalImage,
                            highLightImage: highLightImage)
        
        let btnItem = UIBarButtonItem(customView: wrapped.leftBarButton)
        
        fixSpaceLeftBarButton(btnItem: btnItem)
        guard let ges = touchUp else {
            return
        }
        wrapped.leftBarButton.addTouchUpInSideBtnAction(touchUp: ges)
    }
    
    func addLeftBarButton(text: String,
                          font: UIFont? = nil,
                          normalColor: UIColor? = nil,
                          highlightColor: UIColor? = nil,
                          touchUp: ButtonClosure?){
        configLeftBarButton(text: text,
                            font: font,
                            normalColor: normalColor,
                            highlightColor: highlightColor)
        let btnItem = UIBarButtonItem(customView: wrapped.leftBarButton)
        
        fixSpaceLeftBarButton(btnItem: btnItem)
        guard let ges = touchUp else {
            return
        }
        wrapped.leftBarButton.addTouchUpInSideBtnAction(touchUp: ges)
    }
    
    func addRightBarButton(normalImage: UIImage? = nil,
                           highLightImage: UIImage? = nil,
                           selectedImage: UIImage? = nil,
                           disableImage: UIImage? = nil,
                           fixSpace: CGFloat = 0,
                           touchUp: ButtonClosure?){
        
        configRightBarButton(normalImage: normalImage,
                             highLightImage: highLightImage,
                             selectedImage: selectedImage,
                             disableImage: disableImage)
        let btnItem = UIBarButtonItem(customView: wrapped.rightBarButton)
        
        fixSpaceRightBarButton(btnItem: btnItem, fixSpace: fixSpace)
        guard let ges = touchUp else {
            return
        }
        wrapped.rightBarButton.addTouchUpInSideBtnAction(touchUp: ges)
    }
    
    func addRightBarButton(text: String,
                           font: UIFont? = nil,
                           normalColor: UIColor? = nil,
                           highlightColor: UIColor? = nil,
                           selectedColor: UIColor? = nil,
                           disableColor: UIColor? = nil,
                           fixSpace: CGFloat = 0,
                           touchUp: ButtonClosure?){
        configRightBarButton(text: text,
                             font: font,
                             normalColor: normalColor,
                             highlightColor: highlightColor,
                             selectedColor: selectedColor,
                             disableColor: disableColor)
        let btnItem = UIBarButtonItem(customView: wrapped.rightBarButton)
        
        fixSpaceRightBarButton(btnItem: btnItem, fixSpace: fixSpace)
        guard let ges = touchUp else {
            return
        }
        wrapped.rightBarButton.addTouchUpInSideBtnAction(touchUp: ges)
    }
    
    func configLeftBarButton(text: String? = nil,
                             font: UIFont? = nil,
                             normalColor: UIColor? = nil,
                             highlightColor: UIColor? = nil,
                             normalImage: UIImage? = nil,
                             highLightImage: UIImage? = nil){
        wrapped.leftBarButton.titleLabel?.font = font ?? Font.systemFont(14)
        wrapped.leftBarButton.setTitle(text, for: .normal)
        wrapped.leftBarButton.setTitle(text, for: .highlighted)
        wrapped.leftBarButton.setTitleColor(normalColor, for: .normal)
        wrapped.leftBarButton.setTitleColor(highlightColor, for: .highlighted)
        
        wrapped.leftBarButton.setImage(normalImage, for: .normal)
        wrapped.leftBarButton.setImage(highLightImage, for: .highlighted)
    }
    
    func configRightBarButton(text: String? = nil,
                              font: UIFont? = nil,
                              normalColor: UIColor? = nil,
                              highlightColor: UIColor? = nil,
                              selectedColor: UIColor? = nil,
                              disableColor: UIColor? = nil,
                              normalImage: UIImage? = nil,
                              highLightImage: UIImage? = nil,
                              selectedImage: UIImage? = nil,
                              disableImage: UIImage? = nil){
        
        wrapped.rightBarButton.titleLabel?.font = font ?? Font.systemFont(14)
        wrapped.rightBarButton.setTitle(text, for: .normal)
        wrapped.rightBarButton.setTitle(text, for: .highlighted)
        wrapped.rightBarButton.setTitle(text, for: .selected)
        wrapped.rightBarButton.setTitle(text, for: .disabled)
        
        wrapped.rightBarButton.setTitleColor(normalColor, for: .normal)
        wrapped.rightBarButton.setTitleColor(highlightColor, for: .highlighted)
        wrapped.rightBarButton.setTitleColor(selectedColor, for: .selected)
        wrapped.rightBarButton.setTitleColor(disableColor, for: .disabled)
        
        wrapped.rightBarButton.setImage(normalImage, for: .normal)
        wrapped.rightBarButton.setImage(highLightImage, for: .highlighted)
        wrapped.rightBarButton.setImage(selectedImage, for: .selected)
        wrapped.rightBarButton.setImage(disableImage, for: .disabled)
    }
    
    func fixSpaceLeftBarButton(btnItem: UIBarButtonItem){
        wrapped.leftBarButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: SwiftBrick.navBarLeftFixSpace, bottom: 0, right: 0)
        wrapped.navigationItem.leftBarButtonItem = btnItem
    }
    
    func fixSpaceRightBarButton(btnItem: UIBarButtonItem, fixSpace: CGFloat = 0){
        wrapped.rightBarButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (fixSpace != 0 ? fixSpace: SwiftBrick.navBarRightFixSpace))
        wrapped.navigationItem.rightBarButtonItem = btnItem
    }
}

public extension UIViewController {
    struct AssociatedKeys {
        static var leftButtonKey: String = "ButtonLeftKey"
        static var rightButtonKey: String = "ButtonRightKey"
    }
    
    var leftBarButton: UIButton {
        get {
            var button = UIButton(type: .custom)
            button.imageView?.contentMode = .center
            button.frame = CGRect(x: 0, y: 0, width: 0, height: Define.navBarHeight())
            if let b = objc_getAssociatedObject(self, &AssociatedKeys.leftButtonKey) as? UIButton {
                button = b
            } else {
                objc_setAssociatedObject(self, &AssociatedKeys.leftButtonKey, button, .OBJC_ASSOCIATION_RETAIN)
            }
            return button
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.leftButtonKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var rightBarButton: UIButton {
        get {
            var button = UIButton(type: .custom)
            button.imageView?.contentMode = .center
            button.frame = CGRect(x: 0, y: 0, width: 0, height: Define.navBarHeight())
            if let b = objc_getAssociatedObject(self, &AssociatedKeys.rightButtonKey) as? UIButton {
                button = b
            } else {
                objc_setAssociatedObject(self, &AssociatedKeys.rightButtonKey, button, .OBJC_ASSOCIATION_RETAIN)
            }
            return button
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.rightButtonKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
