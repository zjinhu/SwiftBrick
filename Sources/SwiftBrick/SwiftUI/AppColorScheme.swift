//
//  AppColorScheme.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2023/6/6.
//

import SwiftUI
import Foundation

public enum ColorSchemeType: Int {
    // 跟随系统
    case system
    // 浅色模式
    case light
    // 暗黑模式
    case dark
}

@available(iOS 14.0, *)
public class AppColorScheme: ObservableObject {

    public init() { }
    
    @Published public var darkModeSetting: ColorSchemeType = ColorSchemeType(rawValue: UserDefaults.standard.integer(forKey: "colorSchemeType")) ?? .system {
        didSet {
            UserDefaults.standard.set(darkModeSetting.rawValue, forKey: "colorSchemeType")
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            switch darkModeSetting {
            case .light:
                window?.overrideUserInterfaceStyle = .light
            case .dark:
                window?.overrideUserInterfaceStyle = .dark
            default:
                window?.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}




