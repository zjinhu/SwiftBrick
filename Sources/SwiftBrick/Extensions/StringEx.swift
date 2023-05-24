//
//  StringEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/10/10.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import CommonCrypto

// MARK: ===================================扩展: 字符串sha256=========================================
public extension SwiftBrickWrapper where Base == String {
    
    var sha256: String {
        let utf8 = base.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02x", $1) }
    }

    /// Json字符串转Dic
    /// - Returns: 字典
    func toDictionary() -> [String : Any] {
        var result = [String : Any]()
        guard !base.isEmpty else { return result }
        guard let dataSelf = base.data(using: .utf8) else {
            return result
        }
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                           options: .mutableContainers) as? [String : Any] {
            result = dic
        }
        return result
    
    }
    
    // MARK: 1.3、JSON字符串 -> 字典
    /// JsonString转为字典
    /// - Parameter json: JSON字符串
    /// - Returns: 字典
    func jsonToDictionary() -> Dictionary<String, Any>? {
        if let data = (try? JSONSerialization.jsonObject(
            with: base.data(using: String.Encoding.utf8,
                            allowLossyConversion: true)!,
            options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary<String, Any> {
            return data
        } else {
            return nil
        }
    }
 
    var localizedString: String {
        Bundle.current.localizedString(forKey: base)
    }
}
