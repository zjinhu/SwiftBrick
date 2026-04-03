//
//  JHSwiftUIVC.swift
//  SwiftBrick
//
//  Created by 狄烨 on 2023/5/13.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import UIKit
import SwiftUI
/// SwiftUI view controller wrapper for embedding SwiftUI views in UIKit / SwiftUI视图控制器包装器
@available(iOS 13.0, *)
open class SwiftUIVC<T: View>: ViewController {

    private var hostVC: UIHostingController<T>

    /// Initialize with SwiftUI view / 使用SwiftUI视图初始化
    public init(_ view: T) {
        self.hostVC = UIHostingController(rootView: view)
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        hostVC.view.frame = view.bounds
        addChild(hostVC)
        view.addSubview(hostVC.view)
        hostVC.didMove(toParent: self)
    }

}
