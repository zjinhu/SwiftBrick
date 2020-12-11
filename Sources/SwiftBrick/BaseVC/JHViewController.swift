//
//  JHBaseViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

open class JHViewController: UIViewController {
    
    // MARK: - 参数变量
    public lazy var leftBarButton: UIButton = {
        let leftBarButton = UIButton(type: .custom)
        leftBarButton.imageView?.contentMode = .center
        leftBarButton.contentHorizontalAlignment = .leading
        //        leftBarButton.backgroundColor = .white
        //        leftBarButton.titleLabel?.backgroundColor = .orange
        //        leftBarButton.imageView?.backgroundColor = .red
        leftBarButton.frame = CGRect(x: 0, y: 0, width: SwiftBrick.navBarLeftButtonWidth, height: NavBarHeight())
        return leftBarButton
    }()
    
    public lazy var rightBarButton: UIButton = {
        let rightBarButton = UIButton(type: .custom)
        rightBarButton.imageView?.contentMode = .center
        rightBarButton.contentHorizontalAlignment = .trailing
        //        rightBarButton.backgroundColor = .white
        //        rightBarButton.titleLabel?.backgroundColor = .orange
        //        rightBarButton.imageView?.backgroundColor = .red
        rightBarButton.frame = CGRect(x: 0, y: 0, width: SwiftBrick.navBarRightButtonWidth, height: NavBarHeight())
        return rightBarButton
    }()
    
    public typealias buttonClosure = () -> Void
    
    fileprivate var leftAction: buttonClosure?
    fileprivate var rightAction: buttonClosure?
    
    // MARK: - 布局
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = L.color("bgColor")
        edgesForExtendedLayout = .all
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        if let viewControllers: [UIViewController] = navigationController?.viewControllers , viewControllers.count > 1{
            addDefaultBackBarButton()
        }
    }
    
    // MARK: - Navigation 关闭手势返回
    public func closePopGestureRecognizer() {
        let target = navigationController?.interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: nil)
        view.addGestureRecognizer(pan)
    }
    
    // MARK: - 返回方法
    @objc
    open func goBack() {
        if let viewControllers: [UIViewController] = navigationController?.viewControllers {
            guard viewControllers.count <= 1 else {
                navigationController?.popViewController(animated: true)
                return
            }
        }
        
        if (presentingViewController != nil) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - 设置导航栏按钮方法
    /**
     *  修正左侧按钮位置
     */
    fileprivate func fixSpaceLeftBarButton(btnItem: UIBarButtonItem){
        leftBarButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: SwiftBrick.navBarLeftFixSpace, bottom: 0, right: 0)
        leftBarButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: SwiftBrick.navBarLeftFixSpace, bottom: 0, right: 0)
        btnItem.imageInsets = UIEdgeInsets(top: 0, left: SwiftBrick.navBarLeftFixSpace, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = btnItem
    }
    
    /**
     *  修正右侧按钮位置
     */
    fileprivate func fixSpaceRightBarButton(btnItem: UIBarButtonItem, fixSpace: CGFloat = 0){
        rightBarButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (fixSpace != 0 ? fixSpace: SwiftBrick.navBarRightFixSpace))
        rightBarButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (fixSpace != 0 ? fixSpace: SwiftBrick.navBarRightFixSpace))
        btnItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (fixSpace != 0 ? fixSpace: SwiftBrick.navBarRightFixSpace))
        navigationItem.rightBarButtonItem = btnItem
    }
    
    /// 设置导航默认返回按钮
    public func addDefaultBackBarButton() {
        addLeftBarButton(normalImage: SwiftBrick.navBarNorBackImage ?? L.image("nav_ic_back"),
                         highLightImage: SwiftBrick.navBarHigBackImage ?? L.image("nav_ic_back"))
    }
    
    public func hideDefaultBackBarButton(){
        leftBarButton.isHidden = true
        navigationItem.hidesBackButton = true
    }
    /// 设置导航左侧按钮图片
    /// - Parameters:
    ///   - normalImage: normalImage
    ///   - highLightImage: highLightImage
    public func addLeftBarButton(normalImage: UIImage? = nil,
                                 highLightImage: UIImage? = nil,
                                 touchUp: buttonClosure? = nil){
        
        configLeftBarButton(normalImage: normalImage,
                            highLightImage: highLightImage)
        let btnItem = UIBarButtonItem(customView: leftBarButton)
        
        fixSpaceLeftBarButton(btnItem: btnItem)
        
        addLeftBarButtonAction(touchUp: touchUp)
    }
    
    /// 设置导航左侧按钮文本
    /// - Parameters:
    ///   - text: text
    ///   - normalColor: normalColor
    ///   - highlightColor: highlightColor
    public func addLeftBarButton(text: String,
                                 normalColor: UIColor? = .textTitleColor,
                                 highlightColor: UIColor? = .textDesColor,
                                 touchUp: buttonClosure? = nil){
        
        configLeftBarButton(text: text,
                            normalColor: normalColor,
                            highlightColor: highlightColor)
        let btnItem = UIBarButtonItem(customView: leftBarButton)
        
        fixSpaceLeftBarButton(btnItem: btnItem)
        
        addLeftBarButtonAction(touchUp: touchUp)
    }
    
    /// 设置导航右侧按钮图片
    /// - Parameters:
    ///   - normalImage: normalImage
    ///   - highLightImage: highLightImage
    ///   - fixSpace: 图片修正或者文字修正
    public func addRightBarButton(normalImage: UIImage? = nil,
                                  highLightImage: UIImage? = nil,
                                  fixSpace: CGFloat = 0,
                                  touchUp: buttonClosure?){
        
        configRightBarButton(normalImage: normalImage,
                             highLightImage: highLightImage)
        let btnItem = UIBarButtonItem(customView: rightBarButton)
        
        fixSpaceRightBarButton(btnItem: btnItem, fixSpace: fixSpace)
        
        addRightBarButtonAction(touchUp: touchUp)
    }
    
    /// 设置导航右侧按钮文本
    /// - Parameters:
    ///   - text: text
    ///   - normalColor: normalColor
    ///   - highlightColor: highlightColor
    ///   - fixSpace: 图片修正或者文字修正
    public func addRightBarButton(text: String,
                                  normalColor: UIColor? = .textTitleColor,
                                  highlightColor: UIColor? = .textDesColor,
                                  fixSpace: CGFloat = 0,
                                  touchUp: buttonClosure?){
        
        configRightBarButton(text: text,
                             normalColor: normalColor,
                             highlightColor: highlightColor)
        let btnItem = UIBarButtonItem(customView: rightBarButton)
        
        fixSpaceRightBarButton(btnItem: btnItem, fixSpace: fixSpace)
        
        addRightBarButtonAction(touchUp: touchUp)
    }
    
    /// 配置左侧导航栏按钮
    /// - Parameters:
    ///   - text: text
    ///   - font: font
    ///   - normalColor: normalColor
    ///   - highlightColor: highlightColor
    ///   - normalImage: normalImage
    ///   - highLightImage: highLightImage
    public func configLeftBarButton(text: String? = nil,
                                    font: UIFont? = Font16,
                                    normalColor: UIColor? = .textTitleColor,
                                    highlightColor: UIColor? = .textDesColor,
                                    normalImage: UIImage? = nil,
                                    highLightImage: UIImage? = nil){
        
        leftBarButton.titleLabel?.font = font
        leftBarButton.setTitle(text, for: .normal)
        leftBarButton.setTitle(text, for: .highlighted)
        leftBarButton.setTitleColor(normalColor, for: .normal)
        leftBarButton.setTitleColor(highlightColor, for: .highlighted)
        
        leftBarButton.setImage(normalImage, for: .normal)
        leftBarButton.setImage(highLightImage, for: .highlighted)
        
    }
    
    /// 配置右侧导航栏按钮
    /// - Parameters:
    ///   - text: text
    ///   - font: font
    ///   - normalColor: normalColor
    ///   - highlightColor: highlightColor
    ///   - normalImage: normalImage
    ///   - highLightImage: highLightImage
    public func configRightBarButton(text: String? = nil,
                                     font: UIFont? = Font16,
                                     normalColor: UIColor? = nil,
                                     highlightColor: UIColor? = nil,
                                     normalImage: UIImage? = nil,
                                     highLightImage: UIImage? = nil){
        
        rightBarButton.titleLabel?.font = font
        rightBarButton.setTitle(text, for: .normal)
        rightBarButton.setTitle(text, for: .highlighted)
        rightBarButton.setTitleColor(normalColor, for: .normal)
        rightBarButton.setTitleColor(highlightColor, for: .highlighted)
        
        rightBarButton.setImage(normalImage, for: .normal)
        rightBarButton.setImage(highLightImage, for: .highlighted)
        
    }
    
    /// 重新添加左侧按钮的点击事件,默认是goback
    /// - Parameter touchUp: 回调
    public func addLeftBarButtonAction(touchUp: buttonClosure?){
        
        if let ges = touchUp {
            leftBarButton.removeTarget(self, action: #selector(touchUpInSideLeftBtnAction), for: .touchUpInside)
            leftAction = ges
        }
        
        leftBarButton.addTarget(self, action: #selector(touchUpInSideLeftBtnAction), for: .touchUpInside)
    }
    
    @objc fileprivate func touchUpInSideLeftBtnAction() {
        if let action = leftAction  {
            action()
        }else{
            goBack()
        }
    }
    
    fileprivate func addRightBarButtonAction(touchUp: buttonClosure?){
        
        rightBarButton.removeTarget(self, action: #selector(touchUpInSideRightBtnAction), for: .touchUpInside)
        guard let ges = touchUp else {
            return
        }
        rightAction = ges
        rightBarButton.addTarget(self, action: #selector(touchUpInSideRightBtnAction), for: .touchUpInside)
    }
    
    @objc fileprivate func touchUpInSideRightBtnAction() {
        if let action = rightAction  {
            action()
        }
    }

    
    public func addLeftBarButton(_ button: UIButton...,
                                 fixSpace: CGFloat = 0,
                                 buttonSpace: CGFloat = 20){
        addLeftBarButtons(buttons: button, fixSpace: fixSpace)
    }
    
    fileprivate func addLeftBarButtons(buttons: [UIButton],
                                  fixSpace: CGFloat = 0,
                                  buttonSpace: CGFloat = 20){

        navigationItem.leftBarButtonItems?.removeAll()
        
        let gap = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            gap.width = buttonSpace;
        
        var items = [UIBarButtonItem]()

        let count = buttons.count
        
        for (index, button) in buttons.enumerated() {
            button.contentHorizontalAlignment = .leading
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: fixSpace, bottom: 0, right: 0)
            if index != count - 1 {
                let barButton = UIBarButtonItem(customView: button)
                items.append(barButton)
                items.append(gap)
            }else{
                let barButton = UIBarButtonItem(customView: button)
                items.append(barButton)
            }
        }
        
        navigationItem.leftBarButtonItems = items
    }
    
    public func addRightBarButton(_ button: UIButton...,
                                  fixSpace: CGFloat = 0,
                                  buttonSpace: CGFloat = 20){
        addRightBarButtons(buttons: button, fixSpace: fixSpace)
    }
    
    fileprivate func addRightBarButtons(buttons: [UIButton],
                                   fixSpace: CGFloat = 0,
                                   buttonSpace: CGFloat = 20){
        
        navigationItem.rightBarButtonItems?.removeAll()
        
        let gap = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            gap.width = buttonSpace;
        
        var items = [UIBarButtonItem]()

        let count = buttons.count
        
        for (index, button) in buttons.enumerated() {
            button.contentHorizontalAlignment = .trailing
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: fixSpace)
            if index != count - 1 {
                let barButton = UIBarButtonItem(customView: button)
                items.append(barButton)
                items.append(gap)
            }else{
                let barButton = UIBarButtonItem(customView: button)
                items.append(barButton)
            }
        }
        
        navigationItem.rightBarButtonItems = items
    }
}
