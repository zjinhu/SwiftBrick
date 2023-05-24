//
//  DictionaryEx.swift
//  SwiftBrick
//
//  Created by iOS on 2021/11/4.
//  Copyright © 2021 狄烨 . All rights reserved.
//

import Foundation
// MARK: - 一、基本的扩展
public extension SwiftBrickWrapper where Base == Dictionary<String, Any> {

    // MARK: 1.1、检查字典里面是否有某个 key
    /// 检查字典里面是否有某个 key
    func has(_ key: String) -> Bool {
        return base.index(forKey: key) != nil
    }

    // MARK: 1.2、字典的key或者value组成的数组
    /// 字典的key或者value组成的数组
    /// - Parameter map: map
    /// - Returns: 数组
    func toArray<V>(_ map: (String, Any) -> V) -> [V] {
        return base.map(map)
    }

    // MARK: 1.4、字典 -> JSON字符串
    /// 字典转换为JSONString
    func toJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
    
    // MARK: 1.5、字典里面所有的 key
    /// 字典里面所有的key
    /// - Returns: key 数组
    func allKeys() -> [String] {
        /*
         shuffled：不会改变原数组，返回一个新的随机化的数组。  可以用于let 数组
         */
        return base.keys.shuffled()
    }
    
    // MARK: 1.6、字典里面所有的 value
    /// 字典里面所有的value
    /// - Returns: value 数组
    func allValues() -> [Any] {
        return base.values.shuffled()
    }
}
