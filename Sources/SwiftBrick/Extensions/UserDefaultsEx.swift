//
//  UserDefaultsEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/20.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
// MARK: ===================================扩展: UserDefaults=========================================
public extension SwiftBrickWrapper where Wrapped: UserDefaults {

    func setT<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        wrapped.set(jsonData, forKey: forKey)
    }

    func getT<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = wrapped.value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
    ///下标脚本
    subscript(key: String) -> Any? {
        get {
            return wrapped.object(forKey: key)
        }
        set {
            wrapped.set(newValue, forKey: key)
        }
    }
    
    func float(forKey key: String) -> Float? {
        return wrapped.object(forKey: key) as? Float
    }
    
    func date(forKey key: String) -> Date? {
        return wrapped.object(forKey: key) as? Date
    }
    
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = wrapped.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        wrapped.set(data, forKey: key)
    }
}
