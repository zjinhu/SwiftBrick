//
//  Version.swift
//  SwiftBrick
//
//  Created by iOS on 2021/3/25.
//  Copyright © 2021 狄烨 . All rights reserved.
//

import Foundation
public struct Version {
    
    public let major: Int

    public let minor: Int

    public let patch: Int

    public init() {
        major = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
        minor = ProcessInfo.processInfo.operatingSystemVersion.minorVersion
        patch = ProcessInfo.processInfo.operatingSystemVersion.patchVersion
    }

    public init(_ major: Int, _ minor: Int, _ patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}

extension Version: Comparable {
    
    fileprivate static func compare<T: Comparable>(lhs: T, rhs: T) -> ComparisonResult {
        if lhs < rhs {
            return .orderedAscending
        } else if lhs > rhs {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    public static func == (lhs: Version, rhs: Version) -> Bool {
        return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch == rhs.patch
    }
    
    public static func < (lhs: Version, rhs: Version) -> Bool {
        let majorComparison = Version.compare(lhs: lhs.major, rhs: rhs.major)
        if majorComparison != .orderedSame {
            return majorComparison == .orderedAscending
        }

        let minorComparison = Version.compare(lhs: lhs.minor, rhs: rhs.minor)
        if minorComparison != .orderedSame {
            return minorComparison == .orderedAscending
        }

        let patchComparison = Version.compare(lhs: lhs.patch, rhs: rhs.patch)
        if patchComparison != .orderedSame {
            return patchComparison == .orderedAscending
        }

        return false
    }
}
