//
//  UIViewSnapExtension.swift
//  SwiftBrick
//
//  Created by iOS on 20/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import SnapKit
//struct AssociatedKeys {
//    static var TapGestureKey: String = "TapGestureKey"
//    static var LongGestureKey: String = "LongGestureKey"
//}

  
//    public var snpTapGesture: UITapGestureRecognizer? {
//            get {
//                return objc_getAssociatedObject(self, &AssociatedKeys.TapGestureKey) as? UITapGestureRecognizer
//            }
//            set {
//                objc_setAssociatedObject(self, &AssociatedKeys.TapGestureKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }
//
//    public var snpLongGesure: UILongPressGestureRecognizer? {
//            get {
//                return objc_getAssociatedObject(self, &AssociatedKeys.LongGestureKey) as? UILongPressGestureRecognizer
//            }
//            set {
//                objc_setAssociatedObject(self, &AssociatedKeys.LongGestureKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }

extension UIView: ViewMaker { }
extension Maker where T: UIView {
    public func adhere(toSuperView: UIView) -> T {
        toSuperView.addSubview(makerValue)
        return makerValue
    }

    @discardableResult
    public func layout(snapKitMaker: (ConstraintMaker) -> Void) -> T {
        makerValue.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return makerValue
    }

    @discardableResult
    public func config(_ config: (T) -> Void) -> T {
        config(makerValue)
        return makerValue
    }
}
