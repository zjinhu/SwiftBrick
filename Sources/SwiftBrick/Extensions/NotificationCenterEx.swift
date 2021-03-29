//
//  NotificationCenterEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/20.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
// MARK: ===================================扩展: NotificationCenter闭包监听=========================================
public extension NotificationCenter {
    
    /// NotificationCenter通知监听闭包
    /// - Parameters:
    ///   - name: 通知名
    ///   - obj: 对象
    ///   - queue: 线程
    ///   - block: 执行闭包
    func add(name: String,
             obj: Any? = nil,
             queue: OperationQueue? = .main,
             block: @escaping (_ notification: Notification) -> Void) {
        
        var handler: NSObjectProtocol!
        handler = addObserver(forName: NSNotification.Name(rawValue: name), object: obj, queue: queue) { [unowned self] in
            self.removeObserver(handler!)
            block($0)
        }
    }
}
