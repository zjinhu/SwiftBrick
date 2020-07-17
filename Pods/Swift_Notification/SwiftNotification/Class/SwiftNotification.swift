//
//  SwiftNotification.swift
//  SwiftNotification
//
//  Created by iOS on 2020/4/23.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation

public extension NSObject {
    
    private struct Associated {
        static var NotificationCenterKey: String = "NotificationCenterKey"
    }
    
    /// 通知中心
    var notifiCenter: NotificationTool {
        get {
            if let center =  objc_getAssociatedObject(self, &Associated.NotificationCenterKey) as? NotificationTool{
                return center
            }else{
                let de = NotificationTool()
                self.notifiCenter = de
                return de
            }
        }
        set (newValue){
            objc_setAssociatedObject(self, &Associated.NotificationCenterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
 
}
 
public class NotificationTool: NSObject {
    
    var observers = [NSNotification.Name : Any]()
    
    deinit {
        removeAllNotification()
    }
    
    /// 移除所有通知
    public func removeAllNotification(){
        observers.keys.forEach { (name) in
            removeNotification(name: name.rawValue)
        }
    }
    
    /// 移除单个通知
    /// - Parameter name: 通知名称String
    public func removeNotification(name : String){
        guard let ob = observers[NSNotification.Name.init(rawValue: name)] else { return }
        NotificationCenter.default.removeObserver(ob)
        observers.removeValue(forKey: NSNotification.Name.init(rawValue: name))
    }
    
    /// 移除单个系统通知
    /// - Parameter forName: NSNotification.Name通知名称
    public func removeNotification(notiName : NSNotification.Name){
        removeNotification(name: notiName.rawValue)
    }
    
    /// 移除多个通知
    /// - Parameter names: 通知名称String数组
    public func removeNotifications(names : [String]){
        names.forEach { (name) in
            removeNotification(name: name)
        }
    }
    
    /// 移除多个系统通知
    /// - Parameter notiNames: 通知名称NSNotification.Name数组
    public func removeNotifications(notiNames : [NSNotification.Name]){
        notiNames.forEach { (name) in
            removeNotification(notiName: name)
        }
    }
    
    /// 注册添加通知
    /// - Parameters:
    ///   - name: 通知名称String
    ///   - callBack: 通知执行的回调
    public func addNotification(_ name : String, callBack : @escaping (Notification) -> Void){
        removeNotification(name: name)
        let ob = NotificationCenter.default.addObserver(forName: NSNotification.Name.init(rawValue: name), object: nil, queue: OperationQueue.main, using: callBack)
        observers.updateValue(ob, forKey: NSNotification.Name.init(rawValue: name))
    }
    
    /// 注册添加系统通知
    /// - Parameters:
    ///   - notiName: NSNotification.Name通知名称
    ///   - callBack: 通知执行的回调
    public func addNotification(_ notiName : NSNotification.Name, callBack : @escaping (Notification) -> Void){
        removeNotification(notiName: notiName)
        let ob = NotificationCenter.default.addObserver(forName: notiName, object: nil, queue: OperationQueue.main, using: callBack)
        observers.updateValue(ob, forKey: notiName)
    }
    
    /// 发送通知
    /// - Parameters:
    ///   - name: 通知名称
    ///   - object: 发送对象
    ///   - userInfo: 发送字典
    public func postNotification(_ name : String, object: Any? = nil, userInfo : [String : Any]? = nil){
        NotificationQueue.default.enqueue(Notification.init(name: Notification.Name.init(rawValue: name), object: object, userInfo: userInfo), postingStyle: .whenIdle, coalesceMask: .onName, forModes: nil)
    }
}
