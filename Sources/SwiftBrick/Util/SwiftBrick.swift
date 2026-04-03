//
//  SwiftBrick.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/30.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// MARK: ===================================Core: Global Shortcuts & Protocol Definitions=========================================
// MARK: ===================================核心: 全局快捷访问 & 协议定义=========================================

/// Global shortcut to AppState / 全局快捷访问 AppState
public let AppState = SwiftBrick.AppState.self
/// Global shortcut to Application info / 全局快捷访问应用信息
public let APP = SwiftBrick.Application.self
/// Global shortcut to Define constants / 全局快捷访问定义常量
public let Define = SwiftBrick.Define.self
/// Global shortcut to Device info / 全局快捷访问设备信息
public let Device = SwiftBrick.Device.self
/// Global shortcut to DeviceKit / 全局快捷访问设备工具
public let DeviceKit = SwiftBrick.DeviceKit.self
/// Global shortcut to Font utilities / 全局快捷访问字体工具
public let Font = SwiftBrick.Font.self

/// Global shortcut to SwiftBrick namespace / 全局快捷访问 SwiftBrick 命名空间
public let SS = SwiftBrick.self

/// Main namespace for SwiftBrick utilities
/// SwiftBrick 主要命名空间
public struct SwiftBrick{
    /// Global navigation bar back button image (normal state)
    /// 统一设置返回按钮图片(默认状态)
    public static var navBarNorBackImage: UIImage?
    /// Global navigation bar back button image (highlighted state)
    /// 统一设置返回按钮图片(按下状态)
    public static var navBarHigBackImage: UIImage?
    /// Navigation bar left button spacing fix. Default is 20pt from edge. Negative = shift left, Positive = shift right
    /// 导航栏左按钮修正距离,默认按钮距离边缘为20:左移为-,右移为+
    public static var navBarLeftFixSpace: CGFloat = 0
    /// Navigation bar right button spacing fix. Default is 20pt from edge. Negative = shift left, Positive = shift right
    /// 导航栏右按钮修正距离,默认按钮距离边缘为20:左移为+,右移为-
    public static var navBarRightFixSpace: CGFloat = 0
}

/// Property wrapper pattern inspired by Kingfisher, provides `.ss` accessor
/// 参考 Kingfisher 的属性包裹模式,提供 `.ss` 访问器
public struct SwiftBrickWrapper<Wrapped> {
    public let wrapped: Wrapped
    public init(_ wrapped: Wrapped) {
        self.wrapped = wrapped
    }
}

/// Protocol for class types to enable `.ss` accessor
/// 使引用类型支持 `.ss` 访问器的协议
public protocol SwiftBrickCompatible: AnyObject { }
/// Protocol for value types to enable `.ss` accessor
/// 使值类型支持 `.ss` 访问器的协议
public protocol SwiftBrickCompatibleValue {}

extension SwiftBrickCompatible {
    public var ss: SwiftBrickWrapper<Self> {
        get { return SwiftBrickWrapper(self) }
        set { }
    }
}

extension SwiftBrickCompatibleValue {
    public var ss: SwiftBrickWrapper<Self> {
        get { return SwiftBrickWrapper(self) }
        set { }
    }
}
extension NSObject: SwiftBrickCompatible {}

extension CGSize: SwiftBrickCompatibleValue {}
extension Dictionary: SwiftBrickCompatibleValue {}
extension CGFloat: SwiftBrickCompatibleValue {}
extension Int: SwiftBrickCompatibleValue {}
extension Data: SwiftBrickCompatibleValue {}
extension String: SwiftBrickCompatibleValue {}
