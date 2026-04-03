//
//  UIStackViewSnapEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/10/10.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
 
public extension UIStackView {

    /// Convenience initializer for stack view / StackView便捷初始化
    convenience init(axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 0.0,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill,
                     autoLayout: Bool = false) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        if !autoLayout {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.setContentCompressionResistancePriority(UILayoutPriority.required, for: axis)
        }
        
    }
}

public extension SwiftBrickWrapper where Wrapped: UIStackView {
    /// Add background view to stack view / 为StackView添加背景视图
    func addBackground(color: UIColor = .clear, cornerRadius: CGFloat = 0) {
        let subView = UIView(frame: wrapped.bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wrapped.insertSubview(subView, at: 0)
        
        subView.layer.cornerRadius = cornerRadius
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
    
    /// Add multiple arranged subviews / 添加多个排列子视图
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { (view) in
            wrapped.addArrangedSubview(view)
        }
    }
    
    /// Remove arranged subview / 移除排列子视图
    func removeArrangedView(_ view: UIView){
        wrapped.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    /// Remove all arranged subviews / 移除所有排列子视图
    func removeArrangedSubviews() {
        wrapped.arrangedSubviews.forEach { (view) in
            removeArrangedView(view)
        }
    }
}
