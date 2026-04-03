//
//  Application.swift
//  SwiftBrick
//
//  Created by iOS on 2023/4/20.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import Foundation
// MARK:- App Info / App信息
extension SwiftBrick{
    public struct Application {
        
        /// App display name from bundle / App显示名称
        public static var appDisplayName: String {
            return Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
        }
        
        /// App name from bundle / App名称
        public static var appName: String {
            return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String
        }
        
        /// App bundle identifier / App Bundle ID
        public static var appBundleID: String {
            return Bundle.main.bundleIdentifier!
        }
        
        /// App version string / App版本号
        public static var version: String {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        }
        
        /// App build string / App构建号
        public static var build: String {
            return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        }
        
        /// Complete app version string (version + build) / 完整App版本号(版本号+构建号)
        public static var completeAppVersion: String {
            return "\(Application.version) (\(Application.build))"
        }
    }
}
