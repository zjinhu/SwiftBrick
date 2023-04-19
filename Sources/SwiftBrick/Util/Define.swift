//
//  JHToolsDefine.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 15/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit
import Foundation

// MARK: ===================================工具类:变量宏定义=========================================

// MARK:- 屏幕
/// 当前屏幕状态 宽度
public let screenHeight = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
/// 当前屏幕状态 高度
public let screenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)

/// 当前屏幕状态 宽度按照4.7寸 375 屏幕比例 例如 30*FitWidth即可
public let fitWidth = screenWidth / 375
/// 当前屏幕状态 高度按照4.7寸 667 屏幕比例 例如 30*FitHeight即可
public let fitHeight = screenHeight / 667
/// 当前屏幕比例
public let screenScale = UIScreen.main.scale
/// 画线宽度 不同分辨率都是一像素
public let lineHeight = CGFloat(screenScale >= 1 ? 1/screenScale: 1)

/// 信号栏高度
/// - Returns: 高度
public func statusBarHeight() ->CGFloat {
    return getWindow()?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
}
///获取当前设备window用于判断尺寸
public func getWindow() -> UIWindow?{
    let winScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    return winScene?.windows.first
}

/// 导航栏高度 实时获取,可获取不同分辨率手机横竖屏切换后的实时高度变化
/// - Returns: 高度
public func navBarHeight() ->CGFloat {
    return UINavigationController().navigationBar.frame.size.height
}

/// 获取屏幕导航栏+信号栏总高度
public let navAndStatusHeight = statusBarHeight() + navBarHeight()
/// 获取刘海屏底部home键高度,普通屏为0
public let bottomHomeHeight = getWindow()?.safeAreaInsets.bottom ?? 0

/// TabBar高度 实时获取,可获取不同分辨率手机横竖屏切换后的实时高度变化
/// - Returns: 高度
public func tabbarHeight() ->CGFloat {
    return UITabBarController().tabBar.frame.size.height
}
//刘海屏=TabBar高度+Home键高度, 普通屏幕为TabBar高度
public let tabBarHeight = tabbarHeight() + bottomHomeHeight



// MARK:- 字体

///根据屏幕自适应字体参数 16*FontFit
public let fontFit = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 375

/// 系统默认字体
public func systemFont(_ size: CGFloat) -> UIFont {
    return .systemFont(ofSize: size)
}
/// 系统默认字体
public func systemFontBold(_ size: CGFloat) -> UIFont {
    return .boldSystemFont(ofSize: size)
}
/// 系统默认字体
public func systemFont(_ size: CGFloat, weight: UIFont.Weight) -> UIFont {
    return .systemFont(ofSize: size, weight: weight)
}

public enum Weight {
    case ultralight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
}
/// pingfang-sc 字体
public func font(_ size: CGFloat) -> UIFont {
    return fontWeight(size, weight: .regular)
}
/// pingfang-sc 字体
public func fontMedium(_ size: CGFloat) -> UIFont {
    return fontWeight(size, weight: .medium)
}
/// pingfang-sc 字体
public func fontBold(_ size: CGFloat) -> UIFont {
    return fontWeight(size, weight: .semibold)
}
/// pingfang-sc 字体
public func fontWeight(_ size: CGFloat, weight: Weight) -> UIFont {
    var name = ""
    switch weight {
    case .ultralight:
        name = "PingFangSC-Ultralight"
    case .thin:
        name = "PingFangSC-Thin"
    case .light:
        name = "PingFangSC-Light"
    case .regular:
        name = "PingFangSC-Regular"
    case .medium:
        name = "PingFangSC-Medium"
    case .semibold:
        name = "PingFangSC-Semibold"
    case .bold:
        name = "PingFangSC-Bold"
    case .heavy:
        name = "PingFangSC-Heavy"
    }
    return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
}

// MARK:- App信息

/// App 显示名称
public var appDisplayName: String? {
    return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
}

public var appName: String? {
    return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
}

/// app 的bundleid
public var appBundleID: String? {
    return Bundle.main.bundleIdentifier
}

/// build号
public var appBuildNumber: String? {
    return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
}

/// app版本号
public var appVersion: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

// MARK:- 打印输出
public func sLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\n\n<><><><><>-「LOG」-<><><><><>\n\n>>>>>>>>>>>>>>>所在类:>>>>>>>>>>>>>>>\n\n\(fileName)\n\n>>>>>>>>>>>>>>>所在行:>>>>>>>>>>>>>>>\n\n\(lineNum)\n\n>>>>>>>>>>>>>>>信 息:>>>>>>>>>>>>>>>\n\n\(message)\n\n<><><><><>-「END」-<><><><><>\n\n")
#endif
}
