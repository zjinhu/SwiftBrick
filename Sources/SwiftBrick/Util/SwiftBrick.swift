//
//  SwiftBrick.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/30.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
// MARK: ===================================VC基类:协议=========================================
public let SS = SwiftBrick.self
public let AppState = SwiftBrick.AppState.self
public let APP = SwiftBrick.Application.self
public let Define = SwiftBrick.Define.self
public let Device = SwiftBrick.Device.self
public let DeviceKit = SwiftBrick.DeviceKit.self
public let Font = SwiftBrick.Font.self

public struct SwiftBrick{
    ///如果使用导航栏的功能可以全局设置下
    ///统一设置返回按钮图片(默认)
    public static var navBarNorBackImage: UIImage?
    ///统一设置返回按钮图片(按下)
    public static var navBarHigBackImage: UIImage?
    ///导航栏左按钮修正距离,默认按钮距离边缘为20:左移为-,右移为+
    public static var navBarLeftFixSpace: CGFloat = 0
    ///导航栏右按钮修正距离,默认按钮距离边缘为20:左移为+,右移为-
    public static var navBarRightFixSpace: CGFloat = 0

}

/// 参考属性包裹 Kingfisher.
public struct SwiftBrickWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SwiftBrickCompatible: AnyObject { }
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
//extension UIViewController: SwiftBrickCompatible {}
//extension UITableView: SwiftBrickCompatible {}
//extension UITableViewCell: SwiftBrickCompatible {}
//extension UIImageView: SwiftBrickCompatible {}
//extension UICollectionView: SwiftBrickCompatible {}
//extension CALayer: SwiftBrickCompatible {}

extension CGSize: SwiftBrickCompatibleValue {}
extension Dictionary: SwiftBrickCompatibleValue {}
extension CGFloat: SwiftBrickCompatibleValue {}
extension Int: SwiftBrickCompatibleValue {}
extension Data: SwiftBrickCompatibleValue {}
extension String: SwiftBrickCompatibleValue {}
