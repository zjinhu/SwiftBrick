//
//  TapBuzz.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/20.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
// MARK: ===================================Utility: Haptic Feedback=========================================
// MARK: ===================================工具类:震动反馈=========================================
/// Haptic feedback utilities / 震动反馈工具类
public class TapBuzz{
    /// Light impact feedback / 轻度震动反馈
    public static func light() {
        TapticEngine.impact.feedback(.light)
    }
    
    /// Medium impact feedback / 中度震动反馈
    public static func medium() {
        TapticEngine.impact.feedback(.medium)
    }
    
    /// Heavy impact feedback / 重度震动反馈
    public static func heavy() {
        TapticEngine.impact.feedback(.heavy)
    }
    
    /// Selection feedback / 选择震动反馈
    public static func selection() {
        TapticEngine.selection.feedback()
    }
    
    /// Success notification feedback / 成功通知震动反馈
    public static func success() {
        TapticEngine.notification.feedback(.success)
    }
    
    /// Warning notification feedback / 警告通知震动反馈
    public static func warning() {
        TapticEngine.notification.feedback(.warning)
    }
    
    /// Error notification feedback / 错误通知震动反馈
    public static func error() {
        TapticEngine.notification.feedback(.error)
    }
}

/// Taptic engine wrapper for system haptic feedback / 系统震动反馈封装
public class TapticEngine {
    public static let impact: Impact = .init()
    public static let selection: Selection = .init()
    public static let notification: Notification = .init()
    
    /// Wrapper of `UIImpactFeedbackGenerator` / UIImpactFeedbackGenerator封装
    public class Impact {
        /// Impact feedback styles / 震动反馈样式
        ///
        /// - light: A impact feedback between small, light user interface elements. / 轻量级元素间的震动反馈
        /// - medium: A impact feedback between moderately sized user interface elements. / 中等大小元素间的震动反馈
        /// - heavy: A impact feedback between large, heavy user interface elements. / 大型元素间的震动反馈
        public enum ImpactStyle {
            case light, medium, heavy
        }
        
        private var style: ImpactStyle = .light
        private var generator: Any? = Impact.makeGenerator(.light)
        
        private static func makeGenerator(_ style: ImpactStyle) -> Any? {
            let feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
            switch style {
            case .light:
                feedbackStyle = .light
            case .medium:
                feedbackStyle = .medium
            case .heavy:
                feedbackStyle = .heavy
            }
            let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: feedbackStyle)
            generator.prepare()
            return generator
        }
        
        private func updateGeneratorIfNeeded(_ style: ImpactStyle) {
            guard self.style != style else { return }
            generator = Impact.makeGenerator(style)
            self.style = style
        }
        
        public func feedback(_ style: ImpactStyle) {
            updateGeneratorIfNeeded(style)
            guard let generator = generator as? UIImpactFeedbackGenerator else { return }
            generator.impactOccurred()
            generator.prepare()
        }
        
        public func prepare(_ style: ImpactStyle) {
            updateGeneratorIfNeeded(style)
            guard let generator = generator as? UIImpactFeedbackGenerator else { return }
            generator.prepare()
        }
    }
    
    
    /// Wrapper of `UISelectionFeedbackGenerator` / UISelectionFeedbackGenerator封装
    public class Selection {
        private var generator: Any? = {
            let generator: UISelectionFeedbackGenerator = UISelectionFeedbackGenerator()
            generator.prepare()
            return generator
        }()
        
        public func feedback() {
            guard let generator = generator as? UISelectionFeedbackGenerator else { return }
            generator.selectionChanged()
            generator.prepare()
        }
        
        public func prepare() {
            guard let generator = generator as? UISelectionFeedbackGenerator else { return }
            generator.prepare()
        }
    }
    
    
    /// Wrapper of `UINotificationFeedbackGenerator` / UINotificationFeedbackGenerator封装
    public class Notification {
        /// Notification feedback types / 通知反馈类型
        ///
        /// - success: A notification feedback, indicating that a task has completed successfully. / 任务成功完成的通知反馈
        /// - warning: A notification feedback, indicating that a task has produced a warning. / 任务产生警告的通知反馈
        /// - error: A notification feedback, indicating that a task has failed. / 任务失败的通知反馈
        public enum NotificationType {
            case success, warning, error
        }
        
        private var generator: Any? = {
            let generator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
            generator.prepare()
            return generator
        }()
        
        public func feedback(_ type: NotificationType) {
            guard let generator = generator as? UINotificationFeedbackGenerator else { return }
            let feedbackType: UINotificationFeedbackGenerator.FeedbackType
            switch type {
            case .success:
                feedbackType = .success
            case .warning:
                feedbackType = .warning
            case .error:
                feedbackType = .error
            }
            generator.notificationOccurred(feedbackType)
            generator.prepare()
        }
        
        public func prepare() {
            guard let generator = generator as? UINotificationFeedbackGenerator else { return }
            generator.prepare()
        }
    }
}
