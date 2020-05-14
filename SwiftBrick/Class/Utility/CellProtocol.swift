//
//  CellProtocol.swift
//  SwiftBrick
//
//  Created by iOS on 2020/5/14.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation

public protocol CellProtocol {
    
    // MARK: - 继承 在内部实现布局
    func configCellViews()
    
    // MARK: - cell赋值
    func setCellModel(model: Any)
}

public extension CellProtocol{
    
    // MARK: - 继承 在内部实现布局
    func configCellViews() {
        
    }
    
    // MARK: - cell赋值
    func setCellModel(model: Any) {
        
    }
}
