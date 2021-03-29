//
//  DispatchQueueEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/20.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
//#if canImport(Dispatch)
import Dispatch
// MARK: ===================================扩展: DispatchQueue延迟方法=========================================
public extension DispatchQueue {
    
    /// 判断主线程
    static var isMainQueue: Bool {
        enum Static {
            static var key: DispatchSpecificKey<Void> = {
                let key = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: key, value: ())
                return key
            }()
        }
        return DispatchQueue.getSpecific(key: Static.key) != nil
    }
}

public extension DispatchQueue {
    
    /// 判断是不是在主线程
    /// - Parameter queue: queue
    /// - Returns: true/false
    static func isCurrent(_ queue: DispatchQueue) -> Bool {
        let key = DispatchSpecificKey<Void>()

        queue.setSpecific(key: key, value: ())
        defer { queue.setSpecific(key: key, value: nil) }

        return DispatchQueue.getSpecific(key: key) != nil
    }
    
    /// 延迟闭包
    /// - Parameters:
    ///   - delay: 延迟时间
    ///   - qos: qos
    ///   - flags: flags
    ///   - work: 执行闭包
    func asyncAfter(delay: Double,
                    qos: DispatchQoS = .unspecified,
                    flags: DispatchWorkItemFlags = [],
                    execute work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, qos: qos, flags: flags, execute: work)
    }
    
    /// 延迟闭包
    /// - Parameters:
    ///   - delay: 延迟时间
    ///   - action: 执行闭包
    func after(delay: Double, action: @escaping () -> Void) -> () -> Void {
        var lastFireTime = DispatchTime.now()
        let deadline = { lastFireTime + delay }
        return {
            self.asyncAfter(deadline: deadline()) {
                let now = DispatchTime.now()
                if now >= deadline() {
                    lastFireTime = now
                    action()
                }
            }
        }
    }
}
//#endif
