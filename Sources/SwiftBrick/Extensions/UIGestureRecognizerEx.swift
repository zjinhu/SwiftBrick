//
//  UIGestureRecognizerExtension.swift
//  SwiftBrick
//
//  Created by iOS on 21/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import Foundation
// MARK: ===================================Extension: UIGestureRecognizer with Closure=========================================
// MARK: ===================================扩展: UIGestureRecognizer 点击手势闭包=========================================
public extension UIGestureRecognizer {
    private class GestureAction {
        var action: (UIGestureRecognizer) -> Void
        
        init(action closure: @escaping (UIGestureRecognizer) -> Void) {
            action = closure
        }
    }
    
    private struct AssociatedKeys {
        static var ActionName: UInt8 = 0
    }
    
    private var gestureAction: GestureAction? {
        set { objc_setAssociatedObject(self, &AssociatedKeys.ActionName, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &AssociatedKeys.ActionName) as? GestureAction }
    }

    /// Initialize gesture with action closure / 使用动作闭包初始化手势
    convenience init(action: @escaping (UIGestureRecognizer) -> Void) {
        self.init()
        gestureAction = GestureAction(action: action)
        addTarget(self, action: #selector(handleAction(_:)))
    }
    
    /// Handle gesture action / 处理手势动作
    @objc dynamic private func handleAction(_ recognizer: UIGestureRecognizer) {
        gestureAction?.action(recognizer)
    }
}
