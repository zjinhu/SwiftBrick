//
//  UserDefaultsEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/20.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
// MARK: ===================================Extension: UserDefaults=========================================
// MARK: ===================================扩展: UserDefaults=========================================
public extension SwiftBrickWrapper where Wrapped: UserDefaults {

    /// Set Codable object to UserDefaults / 存储Codable对象到UserDefaults
    func setT<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        wrapped.set(jsonData, forKey: forKey)
    }

    /// Get Codable object from UserDefaults / 从UserDefaults获取Codable对象
    func getT<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = wrapped.value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
    /// Subscript script access / 下标脚本
    subscript(key: String) -> Any? {
        get {
            return wrapped.object(forKey: key)
        }
        set {
            wrapped.set(newValue, forKey: key)
        }
    }
    
    /// Get float value for key / 根据key获取Float值
    func float(forKey key: String) -> Float? {
        return wrapped.object(forKey: key) as? Float
    }
    
    /// Get date value for key / 根据key获取Date值
    func date(forKey key: String) -> Date? {
        return wrapped.object(forKey: key) as? Date
    }
    
    /// Get Codable object with custom decoder / 获取Codable对象(支持自定义解码器)
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = wrapped.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    /// Set Codable object with custom encoder / 存储Codable对象(支持自定义编码器)
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        wrapped.set(data, forKey: key)
    }
}
