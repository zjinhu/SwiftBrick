//
//  DictionaryEx.swift
//  SwiftBrick
//
//  Created by iOS on 2021/11/4.
//  Copyright © 2021 狄烨 . All rights reserved.
//

import Foundation
// MARK: - I. Dictionary Basic Extensions / 一、基本的扩展
public extension SwiftBrickWrapper where Wrapped == Dictionary<String, Any> {

    // MARK: 1.1、Check if dictionary has key / 检查字典里面是否有某个 key
    /// Check if dictionary contains key / 检查字典里面是否有某个 key
    func has(_ key: String) -> Bool {
        return wrapped.index(forKey: key) != nil
    }

    // MARK: 1.2、Dictionary to array / 字典的key或者value组成的数组
    /// Convert dictionary to array of keys or values / 字典的key或者value组成的数组
    /// - Parameter map: Map closure / map
    /// - Returns: Array / 数组
    func toArray<V>(_ map: (String, Any) -> V) -> [V] {
        return wrapped.map(map)
    }

    // MARK: 1.4、Dictionary to JSON String / 字典 -> JSON字符串
    /// Convert dictionary to JSON string / 字典转换为JSONString
    func toJSON() -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
    
    // MARK: 1.5、All keys in dictionary / 字典里面所有的 key
    /// Get all keys in dictionary / 字典里面所有的key
    /// - Returns: Key array / key 数组
    func allKeys() -> [String] {
        /*
         shuffled: Returns a new randomized array without modifying original. Can be used with let arrays.
         shuffled：不会改变原数组，返回一个新的随机化的数组。  可以用于let 数组
         */
        return wrapped.keys.shuffled()
    }
    
    // MARK: 1.6、All values in dictionary / 字典里面所有的 value
    /// Get all values in dictionary / 字典里面所有的value
    /// - Returns: Value array / value 数组
    func allValues() -> [Any] {
        return wrapped.values.shuffled()
    }
}
