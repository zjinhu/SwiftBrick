//
//  JHToolsDefine.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 15/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit
import Foundation
extension SwiftBrick{
    // MARK: ===================================Utility: Variable Macro Definitions=========================================
    // MARK: ===================================工具类:变量宏定义=========================================
    public struct Define {
        // MARK:- Screen / 屏幕
        /// Current screen state - width / 当前屏幕状态 宽度
        public static let screenHeight = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        /// Current screen state - height / 当前屏幕状态 高度
        public static let screenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        
        /// Screen width scale based on 4.7 inch 375 screen, e.g. 30*FitWidth / 当前屏幕状态 宽度按照4.7寸 375 屏幕比例 例如 30*FitWidth即可
        public static let fitWidth = screenWidth / 375
        /// Screen height scale based on 4.7 inch 667 screen, e.g. 30*FitHeight / 当前屏幕状态 高度按照4.7寸 667 屏幕比例 例如 30*FitHeight即可
        public static let fitHeight = screenHeight / 667
        /// Current screen scale ratio / 当前屏幕比例
        public static let scale = UIScreen.main.scale
        /// Line width - one pixel for all resolutions / 画线宽度 不同分辨率都是一像素
        public static let lineHeight = CGFloat(scale >= 1 ? 1/scale: 1)
        
        /// Status bar height / 信号栏高度
        /// - Returns: Height / 高度
        public static func statusBarHeight() ->CGFloat {
            if #available(iOS 13.0, *){
                return getWindow()?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            }else{
                return UIApplication.shared.statusBarFrame.height
            }
        }
        
        /// Get current device window for size detection / 获取当前设备window用于判断尺寸
        public static func getWindow() -> UIWindow?{
            if #available(iOS 13.0, *) {
                return UIApplication.shared.connectedScenes
                    .sorted { $0.activationState.sortPriority < $1.activationState.sortPriority }
                    .compactMap { $0 as? UIWindowScene }
                    .compactMap { $0.windows.first { $0.isKeyWindow } }
                    .first
            } else {
                return UIApplication.shared.keyWindow
            }
        }
        
        /// Navigation bar height - real-time detection for landscape/portrait orientation changes / 导航栏高度 实时获取,可获取不同分辨率手机横竖屏切换后的实时高度变化
        /// - Returns: Height / 高度
        public static func navBarHeight() ->CGFloat {
            return UINavigationController().navigationBar.frame.size.height
        }
        
        /// Total height of navigation bar + status bar / 获取屏幕导航栏+信号栏总高度
        public static let navAndStatusHeight = statusBarHeight() + navBarHeight()
        /// Bottom home indicator height for notch screens, 0 for regular screens / 获取刘海屏底部home键高度,普通屏为0
        public static let bottomHomeHeight = getWindow()?.safeAreaInsets.bottom ?? 0
        
        /// TabBar height - real-time detection for landscape/portrait orientation changes / TabBar高度 实时获取,可获取不同分辨率手机横竖屏切换后的实时高度变化
        /// - Returns: Height / 高度
        public static func tabbarHeight() ->CGFloat {
            return UITabBarController().tabBar.frame.size.height
        }
        /// Notch screen: TabBar height + Home indicator height, regular screen: TabBar height / 刘海屏=TabBar高度+Home键高度, 普通屏幕为TabBar高度
        public static let tabBarHeight = tabbarHeight() + bottomHomeHeight
        
        // MARK:- Print Output / 打印输出
        public static func sLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
#if DEBUG
            let fileName = (file as NSString).lastPathComponent
            print("\n\n<><><><><>-「LOG」-<><><><><>\n\n>>>>>>>>>>>>>>>所在类:>>>>>>>>>>>>>>>\n\n\(fileName)\n\n>>>>>>>>>>>>>>>所在行:>>>>>>>>>>>>>>>\n\n\(lineNum)\n\n>>>>>>>>>>>>>>>信 息:>>>>>>>>>>>>>>>\n\n\(message)\n\n<><><><><>-「END」-<><><><><>\n\n")
#endif
        }
    }
}

@available(iOS 13.0, *)
private extension UIScene.ActivationState {
    var sortPriority: Int {
        switch self {
        case .foregroundActive: return 1
        case .foregroundInactive: return 2
        case .background: return 3
        case .unattached: return 4
        @unknown default: return 5
        }
    }
}
