//
//  File.swift
//  
//
//  Created by iOS on 2020/11/20.
//

import Foundation
/// https://www.jianshu.com/p/6e963d82b129
// MARK: ===================================Utility: UserDefault Property Wrapper=========================================
// MARK: ===================================工具类:UserDefault属性包裹器=========================================
/// UserDefault property wrapper for easy UserDefaults access / UserDefault属性包裹器
@propertyWrapper
public struct UserDefault<T> {
    private let key: String
    private let defaultValue: T?
    
    public init(_ key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

/// UserDefault property wrapper with suite name support / 支持suiteName的UserDefault属性包裹器
@propertyWrapper
public struct UserDefaultSuite<T> {
    private let suiteName: String
    private let key: String
    private let defaultValue: T?
    
    public init(_ suiteName: String, key: String, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        self.suiteName = suiteName
    }
    
    public var wrappedValue: T? {
        get {
            return UserDefaults(suiteName: suiteName)?.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if newValue == nil {
                UserDefaults(suiteName: suiteName)?.removeObject(forKey: key)
            } else {
                UserDefaults(suiteName: suiteName)?.set(newValue, forKey: key)
            }
        }
    }
}

//MARK: Usage Example / 使用示例
//
///// Encapsulate a UserDefaults configuration file / 封装一个UserDefault配置文件
//struct UserDefaultsConfig {
//    @UserDefault(key: "username", defaultValue: "123")
//    static var username: String
//}

//struct UserDefaultsSu {
//    @UserDefaultSuite(suiteName: "app", key: "test", defaultValue: "123")
//    static var test: String
//}
//
//

///// Specific business code / 具体的业务代码。
//print("Before modification\(UserDefaultsConfig.username)")
//UserDefaultsConfig.username = "789"
//print("After modification\(UserDefaultsConfig.username)")

//print("Before modification\(UserDefaultsSu.test)")
//UserDefaultsSu.test = "789"
//print("After modification\(UserDefaultsSu.test)")
