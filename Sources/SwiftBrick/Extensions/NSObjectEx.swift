//
//  NSObjectEx.swift
//  SwiftBrick
//
//  Created by iOS on 2021/11/26.
//  Copyright © 2021 狄烨 . All rights reserved.
//

import Foundation

public extension NSObject {

    /// Swizzle method implementation / 交换方法实现
    static func swizzling(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(forClass, originalSelector),
              let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) else {
            return
        }

        let isAddSuccess = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if isAddSuccess {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}


public extension SwiftBrickWrapper where Wrapped: NSObject {
    
    /// Decode object properties from coder / 从编码器解码对象属性
    func decode(coder aDecoder:NSCoder) {
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            guard let label = child.label,
                let value = aDecoder.decodeObject(forKey: label) else {
                return
            }
            wrapped.setValue(value, forKey: label)
        }
    }
    
    // MARK: Encode object / 归档
    /// Encode object properties / 归档对象属性
    func encode(with aCoder: NSCoder) {
        // MARK: Use reflection to get all properties / 利用反射获取类的所有属性
        let mirror = Mirror(reflecting: self)
        
        for (label, value) in mirror.children {
            if let label = label {
                aCoder.encode(value, forKey: label)
            }
        }
    }
    
}
