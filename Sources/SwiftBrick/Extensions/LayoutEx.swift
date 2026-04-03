//
//  LayoutEx.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2022/6/13.
//  Copyright © 2022 狄烨 . All rights reserved.
//

import UIKit
/// Adaptive layout proportional width/height scaling, equivalent to FitWidth FitHeight / 方便自适应布局进行等比例宽高 等同于 FitWidth FitHight
public extension SwiftBrickWrapper where Wrapped == CGFloat {
    /// Proportional width scaling / 比例缩放 width
    ///
    /// - Parameter size: Origin width / 原始宽度
    /// - Returns: Scaled width / 比例缩放后的 width 没有除以2.0
    func scaleWidth() -> CGFloat {
        return Define.screenWidth / 375 * wrapped
    }
    /// Proportional height scaling / 比例缩放 height
    ///
    /// - Parameter size: Origin height / 原始高度
    /// - Returns: Scaled height / 比例缩放后的 height 没有除以2.0
    func scaleHeight() -> CGFloat {
        return Define.screenHeight / 667 * wrapped
    }
}
/// Adaptive layout proportional width/height scaling, equivalent to FitWidth FitHeight / 方便自适应布局进行等比例宽高 等同于 FitWidth FitHight

public extension SwiftBrickWrapper where Wrapped == Int {
    /// Proportional width scaling / 比例缩放 width
    ///
    /// - Parameter size: Origin width / 原始宽度
    /// - Returns: Scaled width / 比例缩放后的 width 没有除以2.0
    func scaleWidth() -> CGFloat {
        return Define.screenWidth / 375 * CGFloat(wrapped)
    }
    /// Proportional height scaling / 比例缩放 height
    ///
    /// - Parameter size: Origin height / 原始高度
    /// - Returns: Scaled height / 比例缩放后的 height 没有除以2.0
    func scaleHeight() -> CGFloat {
        return Define.screenHeight / 667 * CGFloat(wrapped)
    }
}

public extension SwiftBrickWrapper where Wrapped: UIView {
    
    /// Make constraints for the view / 为视图创建约束
    @discardableResult
    func makeConstraints(_ constraints: (ConstraintMaker) -> Void) -> [NSLayoutConstraint] {
        let maker = ConstraintMaker(view: wrapped)
        constraints(maker)
        let activatedConstraints = maker.constraints
        NSLayoutConstraint.activate(activatedConstraints)
        return activatedConstraints
    }

    /// Remake all constraints for the view / 重新为视图创建所有约束
    @discardableResult
    func remakeConstraints(_ constraints: (ConstraintMaker) -> Void) -> [NSLayoutConstraint] {
        let allConstraints = (wrapped.superview?.constraints ?? []) + wrapped.constraints
        let relatedConstraints = allConstraints.filter { constraint in
            (constraint.firstItem as? UIView == wrapped || constraint.secondItem as? UIView == wrapped)
        }
        
        NSLayoutConstraint.deactivate(relatedConstraints)
        
        relatedConstraints.forEach { constraint in
            if let superview = wrapped.superview, superview.constraints.contains(constraint) {
                superview.removeConstraint(constraint)
            } else if wrapped.constraints.contains(constraint) {
                wrapped.removeConstraint(constraint)
            }
        }
        
        let maker = ConstraintMaker(view: wrapped)
        constraints(maker)
        let activatedConstraints = maker.constraints
        NSLayoutConstraint.activate(activatedConstraints)
        return activatedConstraints
    }

    /// Update existing constraints / 更新现有约束
    @discardableResult
    func updateConstraints(_ constraints: (ConstraintMaker) -> Void) -> [NSLayoutConstraint] {
        let maker = ConstraintMaker(view: wrapped)
        constraints(maker)
        let updatedConstraints = replaceAndActivateConstraints(maker.constraints)
        return updatedConstraints
    }
    
    /// Replace and activate constraints / 替换并激活约束
    private func replaceAndActivateConstraints(_ newConstraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        var updatedConstraints: [NSLayoutConstraint] = []
        
        let oldConstraints = wrapped.superview?.constraints.filter { constraint in
            guard let firstItem = constraint.firstItem as? UIView, firstItem == wrapped else { return false }
            return constraint.isActive
        } ?? []
        
        for newConstraint in newConstraints {
            if let oldConstraint = findMatchingConstraint(newConstraint, in: oldConstraints) {
                oldConstraint.constant = newConstraint.constant
                oldConstraint.priority = newConstraint.priority
                updatedConstraints.append(oldConstraint)
            } else {
                newConstraint.isActive = true
                updatedConstraints.append(newConstraint)
            }
        }
        
        wrapped.layoutIfNeeded()
        return updatedConstraints
    }
    
    /// Find matching constraint from existing constraints / 从现有约束中查找匹配的约束
    private func findMatchingConstraint(_ newConstraint: NSLayoutConstraint, in oldConstraints: [NSLayoutConstraint]) -> NSLayoutConstraint? {
        return oldConstraints.first { old in
            let oldFirstAnchor = old.firstAnchor
            let oldSecondAnchor = old.secondAnchor
            let newFirstAnchor = newConstraint.firstAnchor
            let newSecondAnchor = newConstraint.secondAnchor
            
            return compareAnchors(oldFirstAnchor, newFirstAnchor) && compareAnchors(oldSecondAnchor, newSecondAnchor)
        }
    }
    
    /// Compare two layout anchors / 比较两个布局锚点
    private func compareAnchors(_ anchor1: NSLayoutAnchor<AnyObject>?, _ anchor2: NSLayoutAnchor<AnyObject>?) -> Bool {
        guard let a1 = anchor1, let a2 = anchor2 else { return false }
        return a1 === a2
    }

    var topAnchor: NSLayoutYAxisAnchor {
        wrapped.topAnchor
    }
    
    var bottomAnchor: NSLayoutYAxisAnchor {
        wrapped.bottomAnchor
    }
    
    var leftAnchor: NSLayoutXAxisAnchor {
        wrapped.leftAnchor
    }
    
    var rightAnchor: NSLayoutXAxisAnchor {
        wrapped.rightAnchor
    }
    
    var leadingAnchor: NSLayoutXAxisAnchor {
        wrapped.leadingAnchor
    }
    
    var trailingAnchor: NSLayoutXAxisAnchor {
        wrapped.trailingAnchor
    }
    
    var centerXAnchor: NSLayoutXAxisAnchor {
        wrapped.centerXAnchor
    }
    
    var centerYAnchor: NSLayoutYAxisAnchor {
        wrapped.centerYAnchor
    }
    
    var widthAnchor: NSLayoutDimension {
        wrapped.widthAnchor
    }
    
    var heightAnchor: NSLayoutDimension {
        wrapped.heightAnchor
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        wrapped.safeAreaLayoutGuide.topAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        wrapped.safeAreaLayoutGuide.bottomAnchor
    }
    
    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        wrapped.safeAreaLayoutGuide.leadingAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        wrapped.safeAreaLayoutGuide.leftAnchor
    }
    
    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        wrapped.safeAreaLayoutGuide.trailingAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        wrapped.safeAreaLayoutGuide.rightAnchor
    }
    
    var safeCenterXAnchor: NSLayoutXAxisAnchor {
        wrapped.safeAreaLayoutGuide.centerXAnchor
    }
    
    var safeCenterYAnchor: NSLayoutYAxisAnchor {
        wrapped.safeAreaLayoutGuide.centerYAnchor
    }
    
    var safeWidthAnchor: NSLayoutDimension {
        wrapped.safeAreaLayoutGuide.widthAnchor
    }
    
    var safeHeightAnchor: NSLayoutDimension {
        wrapped.safeAreaLayoutGuide.heightAnchor
    }
}

/// Constraint maker for building layout constraints / 约束构建器
public class ConstraintMaker {
    var constraints: [NSLayoutConstraint] = []
    private weak var view: UIView?
    
    init(view: UIView) {
        self.view = view
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @discardableResult
    public func topAnchor(equalTo: NSLayoutYAxisAnchor) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.topAnchor.constraint(equalTo: equalTo, constant: constant)
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func topAnchor(greaterThanOrEqualTo: NSLayoutYAxisAnchor,
             priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.topAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func topAnchor(lessThanOrEqualTo: NSLayoutYAxisAnchor,
             priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.topAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func bottomAnchor(equalTo: NSLayoutYAxisAnchor) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.bottomAnchor.constraint(equalTo: equalTo, constant: constant)
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func bottomAnchor(greaterThanOrEqualTo: NSLayoutYAxisAnchor,
                priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.bottomAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func bottomAnchor(lessThanOrEqualTo: NSLayoutYAxisAnchor,
                      priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.bottomAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func leadingAnchor(equalTo: NSLayoutXAxisAnchor) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.leadingAnchor.constraint(equalTo: equalTo, constant: constant)
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func leadingAnchor(greaterThanOrEqualTo: NSLayoutXAxisAnchor,
                 priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.leadingAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func leadingAnchor(lessThanOrEqualTo: NSLayoutXAxisAnchor,
                 priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.leadingAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func leftAnchor(equalTo: NSLayoutXAxisAnchor) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.leftAnchor.constraint(equalTo: equalTo, constant: constant)
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func leftAnchor(greaterThanOrEqualTo: NSLayoutXAxisAnchor,
              priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.leftAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func leftAnchor(lessThanOrEqualTo: NSLayoutXAxisAnchor,
              priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.leftAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func trailingAnchor(equalTo: NSLayoutXAxisAnchor) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.trailingAnchor.constraint(equalTo: equalTo, constant: constant)
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func trailingAnchor(greaterThanOrEqualTo: NSLayoutXAxisAnchor,
                  priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.trailingAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func trailingAnchor(lessThanOrEqualTo: NSLayoutXAxisAnchor,
                  priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.trailingAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func rightAnchor(equalTo: NSLayoutXAxisAnchor) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.rightAnchor.constraint(equalTo: equalTo, constant: constant)
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func rightAnchor(greaterThanOrEqualTo: NSLayoutXAxisAnchor,
               priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.rightAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func rightAnchor(lessThanOrEqualTo: NSLayoutXAxisAnchor,
               priority: UILayoutPriority = .required) -> Offset {
        Offset { constant in
            guard let view = self.view else { return }
            let constraint = view.ss.rightAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, constant: constant)
            constraint.priority = priority
            self.constraints.append(constraint)
        }
    }
    
    @discardableResult
    public func centerXAnchor(equalTo: NSLayoutXAxisAnchor) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.centerXAnchor.constraint(equalTo: equalTo)
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func centerYAnchor(equalTo: NSLayoutYAxisAnchor) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.centerYAnchor.constraint(equalTo: equalTo)
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func widthAnchor(_ constant: CGFloat) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.widthAnchor.constraint(equalToConstant: constant)
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func widthAnchor(greaterThanOrEqualTo: CGFloat,
               priority: UILayoutPriority = .required) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.widthAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualTo)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func widthAnchor(lessThanOrEqualTo: CGFloat,
                     priority: UILayoutPriority = .required) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.widthAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualTo)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func heightAnchor(_ constant: CGFloat) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.heightAnchor.constraint(equalToConstant: constant)
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func heightAnchor(greaterThanOrEqualTo: CGFloat,
                      priority: UILayoutPriority = .required) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.heightAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualTo)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func heightAnchor(lessThanOrEqualTo: CGFloat,
                      priority: UILayoutPriority = .required) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.heightAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualTo)
        constraint.priority = priority
        constraints.append(constraint)
        return self
    }
    
    @discardableResult
    public func aspectRatio(_ ratio: CGFloat) -> Self {
        guard let view = self.view else { return self }
        let constraint = view.ss.widthAnchor.constraint(equalTo: view.ss.heightAnchor, multiplier: ratio)
        constraints.append(constraint)
        return self
    }
}

/// Offset helper for constraint constants / 约束偏移量助手
public class Offset {
    private let closure: (CGFloat) -> Void
    
    init(closure: @escaping (CGFloat) -> Void) {
        self.closure = closure
    }
    
    public func offset(_ value: CGFloat) {
        closure(value)
    }
}

/// Update offset helper for constraint updates / 约束更新偏移量助手
public class UpdateOffset {
    private let constraint: NSLayoutConstraint?
    
    init(constraint: NSLayoutConstraint?) {
        self.constraint = constraint
    }
    
    public func offset(_ value: CGFloat) {
        constraint?.update(constant: value)
    }
}

public extension NSLayoutConstraint {
    
    /// Update constraint constant / 更新约束常量
    func update(constant: CGFloat) {
        self.constant = constant
        if self.isActive, let view = self.firstItem as? UIView {
            view.layoutIfNeeded()
        }
    }
    
    /// Update constraint priority / 更新约束优先级
    func update(priority: UILayoutPriority) {
        self.priority = priority
    }
}
