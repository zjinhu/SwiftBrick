//
//  File.swift
//  
//
//  Created by iOS on 2020/11/20.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    private let key: String
    private let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
public struct UserDefaultSuite<T> {
    private let suiteName: String
    private let key: String
    private let defaultValue: T
    
    public init(suiteName: String, key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        self.suiteName = suiteName
    }
    
    public var wrappedValue: T {
        get {
            return UserDefaults(suiteName: suiteName)?.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults(suiteName: suiteName)?.set(newValue, forKey: key)
        }
    }
}

//MARK: 使用示例
//
/////封装一个UserDefault配置文件
//struct UserDefaultsConfig {
//    @UserDefault(key: "username", defaultValue: "123")
//    static var username: String
//}

//struct UserDefaultsSu {
//    @UserDefaultSuite(suiteName: "app", key: "test", defaultValue: "123")
//    static var test: String
//}
//

/////具体的业务代码。
//print("修改前\(UserDefaultsConfig.username)")
//UserDefaultsConfig.username = "789"
//print("修改后\(UserDefaultsConfig.username)")

//print("修改前\(UserDefaultsSu.test)")
//UserDefaultsSu.test = "789"
//print("修改后\(UserDefaultsSu.test)")
