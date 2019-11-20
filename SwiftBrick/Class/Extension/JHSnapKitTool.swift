//
//  JHSnapKitTool.swift
//  SwiftBrick
//
//  Created by iOS on 20/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
public protocol ViewMaker {
    associatedtype HandType
    var hand: HandType { get }
    static var hand: HandType.Type { get }
}

public extension ViewMaker {
    var hand: Maker<Self> {
        return Maker(value: self)
    }

    static var hand: Maker<Self>.Type {
        return Maker.self
    }
}

public struct Maker<T> {
    public let makerValue: T
    public init(value: T) {
        self.makerValue = value
    }
}
