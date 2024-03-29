//
//  DataEx.swift
//  SwiftBrick
//
//  Created by iOS on 2023/5/24.
//

import CommonCrypto
import Foundation
public extension SwiftBrickWrapper where Wrapped == Data {
    var sha256: String {
        let hash = wrapped.withUnsafeBytes{ (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_SHA256(bytes.baseAddress, CC_LONG(wrapped.count), &hash)
            return hash
        }
        return hash.reduce("") { $0 + String(format:"%02x", $1) }
    }
}
 
