//
//  AppStorageEx.swift
//  SwiftBrick
//
//  Created by iOS on 2023/4/23.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import Foundation
///增加@AppStorage 支持
extension Date: RawRepresentable{
    public typealias RawValue = String
    public init?(rawValue: RawValue) {
        guard let data = rawValue.data(using: .utf8),
              let date = try? JSONDecoder().decode(Date.self, from: data) else {
            return nil
        }
        self = date
    }

    public var rawValue: RawValue{
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data:data, encoding: .utf8) else {
            return ""
        }
       return result
    }
}

extension Dictionary: RawRepresentable where Key == String, Value == String {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),  // convert from String to Data
            let result = try? JSONDecoder().decode([String:String].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),   // data is  Data type
              let result = String(data: data, encoding: .utf8) // coerce NSData to String
        else {
            return "{}"  // empty Dictionary resprenseted as String
        }
        return result
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
