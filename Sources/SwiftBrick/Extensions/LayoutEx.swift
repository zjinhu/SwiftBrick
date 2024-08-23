//
//  LayoutEx.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2022/6/13.
//  Copyright © 2022 狄烨 . All rights reserved.
//

import UIKit
///方便自适应布局进行等比例宽高 等同于 FitWidth FitHight
public extension SwiftBrickWrapper where Wrapped == CGFloat {
    /// 比例缩放 width
    ///
    /// - Parameter size: origin width
    /// - Returns: 比例缩放后的 width 没有除以2.0
    func scaleWidth() -> CGFloat {
        return Define.screenWidth / 375 * wrapped
    }
    /// 比例缩放 height
    ///
    /// - Parameter size: origin height
    /// - Returns: 比例缩放后的 height 没有除以2.0
    func scaleHeight() -> CGFloat {
        return Define.screenHeight / 667 * wrapped
    }
}
///方便自适应布局进行等比例宽高 等同于 FitWidth FitHight

public extension SwiftBrickWrapper where Wrapped == Int {
    /// 比例缩放 width
    ///
    /// - Parameter size: origin width
    /// - Returns: 比例缩放后的 width 没有除以2.0
    func scaleWidth() -> CGFloat {
        return Define.screenWidth / 375 * CGFloat(wrapped)
    }
    /// 比例缩放 height
    ///
    /// - Parameter size: origin height
    /// - Returns: 比例缩放后的 height 没有除以2.0
    func scaleHeight() -> CGFloat {
        return Define.screenHeight / 667 * CGFloat(wrapped)
    }
}

public extension SwiftBrickWrapper where Wrapped: UIView {
    
    @discardableResult
    func makeConstraints(_ constraints: (ConstraintMaker) -> Void) -> [NSLayoutConstraint] {
        let maker = ConstraintMaker(view: wrapped)
        constraints(maker)
        let activatedConstraints = maker.constraints
        NSLayoutConstraint.activate(activatedConstraints)
        return activatedConstraints
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

public class Offset {
    private let closure: (CGFloat) -> Void
    
    init(closure: @escaping (CGFloat) -> Void) {
        self.closure = closure
    }
    
    public func offset(_ value: CGFloat) {
        closure(value)
    }
}
