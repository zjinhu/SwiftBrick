//
//  SwiftBrick.swift
//  SwiftBrick
//
//  Created by iOS on 2020/11/30.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit

public struct SwiftBrick{
    ///如果使用导航栏的功能可以全局设置下
    ///统一设置返回按钮图片(默认)
    public static var navBarNorBackImage: UIImage?
    ///统一设置返回按钮图片(按下)
    public static var navBarHigBackImage: UIImage?
    ///导航栏左右按钮修正距离,默认按钮距离边为20,宽高为导航栏高44,默认图片居中,根据图片大小:左移为-,右移为+
    public static var navBarFixSpace: CGFloat = -7
    
    ///当导航栏从隐藏的页面滑动到有导航栏的页面或者从有到无的页面滑动,使过度更加平滑,vc需要隐藏导航栏设置下prefersNavigationBarHidden = true
    public static func smoothNavBar() {
        SwizzleNavBar.swizzle
    }
}
