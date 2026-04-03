//
//  JHBaseViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit
// MARK: ===================================VC Base: UIViewController=========================================
// MARK: ===================================VC基类:UIViewController=========================================
/// View controller base class / ViewController基类
open class ViewController: UIViewController{
    
    // MARK: - Layout / 布局
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = L.color("bgColor")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        } else {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "      ", style: .plain, target: self, action: #selector(goBack))
        }
        //        if let viewControllers: [UIViewController] = navigationController?.viewControllers , viewControllers.count > 1{
        //            addDefaultBackBarButton()
        //        }
    }
    
    // MARK: - Navigation: Disable gesture back / 关闭手势返回
    /// Disable interactive pop gesture / 关闭手势返回
    public func closePopGestureRecognizer() {
        let target = navigationController?.interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: nil)
        view.addGestureRecognizer(pan)
    }
    
    // MARK: - Back method / 返回方法
    /// Go back - pop or dismiss / 返回方法
    @objc
    open func goBack() {
        if let viewControllers: [UIViewController] = navigationController?.viewControllers {
            guard viewControllers.count <= 1 else {
                navigationController?.popViewController(animated: true)
                return
            }
        }
        
        if let _ = presentingViewController{
            dismiss(animated: true, completion: nil)
        }
    }
    
    /// Set default navigation back button / 设置导航默认返回按钮
    public func addDefaultBackBarButton() {
        ss.addLeftBarButton(normalImage: SwiftBrick.navBarNorBackImage ?? .icon_back,
                                 highLightImage: SwiftBrick.navBarHigBackImage ?? .icon_back) { [weak self] _ in
            guard let `self` = self else{return}
            self.goBack()
        }
    }
    
    /// Add left bar buttons / 添加左侧按钮组
    public func addLeftBarButton(_ button: UIButton...,
                                 fixSpace: CGFloat = 0,
                                 buttonSpace: CGFloat = 20){
        addLeftBarButtons(buttons: button, fixSpace: fixSpace)
    }
    
    /// Add multiple left bar buttons / 添加多个左侧按钮
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
    
    /// Add right bar buttons / 添加右侧按钮组
    public func addRightBarButton(_ button: UIButton...,
                                  fixSpace: CGFloat = 0,
                                  buttonSpace: CGFloat = 20){
        addRightBarButtons(buttons: button, fixSpace: fixSpace)
    }
    
    /// Add multiple right bar buttons / 添加多个右侧按钮
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
