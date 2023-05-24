//
//  UserDefaultsEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/20.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
// MARK: ===================================扩展: UserDefaults=========================================
public extension SwiftBrickWrapper where Base: UserDefaults {

    func setT<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        base.set(jsonData, forKey: forKey)
    }

    func getT<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = base.value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
    ///下标脚本
    subscript(key: String) -> Any? {
        get {
            return base.object(forKey: key)
        }
        set {
            base.set(newValue, forKey: key)
        }
    }
    
    func float(forKey key: String) -> Float? {
        return base.object(forKey: key) as? Float
    }
    
    func date(forKey key: String) -> Date? {
        return base.object(forKey: key) as? Date
    }
    
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = base.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        base.set(data, forKey: key)
    }
}
