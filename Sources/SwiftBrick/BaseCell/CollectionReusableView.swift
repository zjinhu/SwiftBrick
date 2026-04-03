//
//  JHCollectionReusableView.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
// MARK: ===================================Cell Base: UICollectionReusableView=========================================
// MARK: ===================================Cell基类:UICollectionReusableView=========================================
/// Collection reusable view base class / Collection可重用视图基类
open class CollectionReusableView: UICollectionReusableView, Reusable{
    
    /// View type - header or footer / 样式，header还是footer
    public enum ReusableViewType {
        case SectionHeader//UICollectionElementKindSectionHeader
        case SectionFooter//UICollectionElementKindSectionFooter
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellViews()
        backgroundColor = .clear
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override in subclass for layout / 继承 在内部实现布局
    /// Subclass override for view layout / 子类重写，进行view布局
    open func setupCellViews() {
        
    }
    
}
