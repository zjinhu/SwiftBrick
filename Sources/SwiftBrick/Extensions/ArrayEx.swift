//
//  ArrayEx.swift
//  SwiftBrick
//
//  Created by iOS on 2021/11/4.
//  Copyright © 2021 狄烨 . All rights reserved.
//

import Foundation
// MARK: - I. Array Basic Extensions / 一、数组 的基本扩展
public extension Array {
    
    // MARK: 1.1、Safe access to index value / 安全的取某个索引的值
    /// Safely get value at index / 安全的取某个索引的值
    /// - Parameter index: Index / 索引
    /// - Returns: Value at index / 对应 index 的 value
    func indexValue(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    // MARK: 1.3、Array to JSON String / 数组 -> JSON字符串
    /// Convert array to JSON string / 字典转换为JSONString
    func toJSON() -> String? {
        let array = self
        guard JSONSerialization.isValidJSONObject(array) else {
            return ""
        }
        if let jsonData = try? JSONSerialization.data(withJSONObject: array, options: JSONSerialization.WritingOptions()) {
            let jsonStr = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            return String(jsonStr ?? "")
        }
        return nil
    }
}

// MARK: - II. Array Index Extensions / 二、数组 有关索引 的扩展方法
public extension Array where Element : Equatable {
    
    // MARK: 2.1、Get indexes of element / 获取数组中的指定元素的索引值
    /// Get all indexes of specified element / 获取数组中的指定元素的索引值
    /// - Parameter item: Element / 元素
    /// - Returns: Array of indexes / 索引值数组
    func indexes(_ item: Element) -> [Int] {
        var indexes = [Int]()
        for index in 0..<count where self[index] == item {
            indexes.append(index)
        }
        return indexes
    }
    
    // MARK: 2.2、Get first index of element / 获取元素首次出现的位置
    /// Get first occurrence index of element / 获取元素首次出现的位置
    /// - Parameter item: Element / 元素
    /// - Returns: Index / 索引值
    func firstIndex(_ item: Element) -> Int? {
        for (index, value) in self.enumerated() where value == item {
            return index
        }
        return nil
    }
    
    // MARK: 2.3、Get last index of element / 获取元素最后出现的位置
    /// Get last occurrence index of element / 获取元素最后出现的位置
    /// - Parameter item: Element / 元素
    /// - Returns: Index / 索引值
    func lastIndex(_ item: Element) -> Int? {
        let indexs = indexes(item)
        return indexs.last
    }
}

// MARK: - III. Array Add/Remove/Modify Extensions / 三、遵守 Equatable 协议的数组 (增删改查) 扩展
public extension Array where Element : Equatable {
    
    // MARK: 3.1、Remove element from array / 删除数组的中的元素(可删除第一个出现的或者删除全部出现的)
    /// Remove element(s) from array / 删除数组的中的元素(可删除第一个出现的或者删除全部出现的)
    /// - Parameters:
    ///   - element: Element to remove / 要删除的元素
    ///   - isRepeat: Whether to remove all occurrences / 是否删除重复的元素
    @discardableResult
    mutating func remove(_ element: Element, isRepeat: Bool = true) -> Array {
        var removeIndexs: [Int] = []
        
        for i in 0 ..< count {
            if self[i] == element {
                removeIndexs.append(i)
                if !isRepeat { break }
            }
        }
        // Remove in reverse order / 倒序删除
        for index in removeIndexs.reversed() {
            self.remove(at: index)
        }
        return self
    }
    
    // MARK: 3.2、Remove elements from another array / 从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素
    /// Remove elements that appear in another array / 从删除数组中删除一个数组中出现的元素，支持是否重复删除, 否则只删除第一次出现的元素
    /// - Parameters:
    ///   - elements: Elements to remove / 被删除的数组元素
    ///   - isRepeat: Whether to remove all occurrences / 是否删除重复的元素
    @discardableResult
    mutating func removeArray(_ elements: [Element], isRepeat: Bool = true) -> Array {
        for element in elements {
            if self.contains(element) {
                self.remove(element, isRepeat: isRepeat)
            }
        }
        return self
    }
}

// MARK: - IV. NSObjectProtocol Array Extensions / 四、遵守 NSObjectProtocol 协议对应数组的扩展方法
public extension Array where Element : NSObjectProtocol {
    
    // MARK: 4.1、Remove NSObjectProtocol element / 删除数组中遵守NSObjectProtocol协议的元素，是否删除重复的元素
    /// Remove NSObjectProtocol element from array / 删除数组中遵守NSObjectProtocol协议的元素
    /// - Parameters:
    ///   - object: Element to remove / 元素
    ///   - isRepeat: Whether to remove all occurrences / 是否删除重复的元素
    @discardableResult
    mutating func remove(object: NSObjectProtocol, isRepeat: Bool = true) -> Array {
        var removeIndexs: [Int] = []
        for i in 0..<count {
            if self[i].isEqual(object) {
                removeIndexs.append(i)
                if !isRepeat {
                    break
                }
            }
        }
        for index in removeIndexs.reversed() {
            self.remove(at: index)
        }
        return self
    }
    
    // MARK: 4.2、Remove NSObjectProtocol array elements / 删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    /// Remove NSObjectProtocol array elements / 删除一个遵守NSObjectProtocol的数组中的元素，支持重复删除
    /// - Parameters:
    ///   - objects: NSObjectProtocol elements array / 遵守NSObjectProtocol的数组
    ///   - isRepeat: Whether to remove all occurrences / 是否删除重复的元素
    @discardableResult
    mutating func removeArray(objects: [NSObjectProtocol], isRepeat: Bool = true) -> Array {
        for object in objects {
            if self.contains(where: {$0.isEqual(object)} ){
                self.remove(object: object, isRepeat: isRepeat)
            }
        }
        return self
    }
}

// MARK: - V. String Array Extensions / 五、针对数组元素是 String 的扩展
public extension Array where Self.Element == String {
    
    // MARK: 5.1、Array to string with separator / 数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    /// Convert string array to single string with separator / 数组转字符转（数组的元素是 字符串），如：["1", "2", "3"] 连接器为 - ，那么转化后为 "1-2-3"
    /// - Parameter separator: Separator / 连接器
    /// - Returns: Resulting string / 转化后的字符串
    func toStrinig(separator: String = "") -> String {
        return self.joined(separator: separator)
    }
}
