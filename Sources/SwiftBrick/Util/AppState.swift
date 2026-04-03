//
//  AppState.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/18.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
// MARK: ===================================Utility: App Current State=========================================
// MARK: ===================================工具类:APP当前状态=========================================
extension SwiftBrick{
    /// App state modes / App状态模式
    public enum AppStateMode {
        case debug
        case testFlight
        case appStore
    }
    
    /// App state detection / App状态检测
    public struct AppState {
        
        fileprivate static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
        
        /// Whether running in debug mode / 是否为Debug模式
        public static var isDebug: Bool {
#if DEBUG
            return true
#else
            return false
#endif
        }
        
        /// Current app state mode / 当前App状态模式
        public static var state: AppStateMode {
            if isDebug {
                return .debug
            } else if isTestFlight {
                return .testFlight
            } else {
                return .appStore
            }
        }
    }
}
