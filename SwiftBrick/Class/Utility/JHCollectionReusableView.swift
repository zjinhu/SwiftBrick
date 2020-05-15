//
//  JHCollectionReusableView.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

open class JHCollectionReusableView: UICollectionReusableView{
    
    /// 样式，header还是footer
    public enum ReusableViewType {
        case SectionHeader//UICollectionElementKindSectionHeader
        case SectionFooter//UICollectionElementKindSectionFooter
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configCellViews()
        self.backgroundColor = .clear
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 继承 在内部实现布局
    /// 子类重写，进行view布局
    open func configCellViews() {
        
    }
    
    // MARK: - cell赋值
    /// cell的model赋值，也是需要子类重写
    /// - Parameter model: 赋值
    open func setCellModel<T>(model: T) {
        
    }

    // MARK: - 获取高度
    /// 获取cell高度
    /// - Parameter model: model
    /// - Returns: 高度
    public func getCellHeightWithModel<T>(model: T) -> CGFloat {
        self.setCellModel(model: model)
        self.layoutIfNeeded()
        self.updateConstraintsIfNeeded()
        let height = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return height
    }
    
    // MARK: - 注册
    /// 注册HeaderFooter
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - reuseIdentifier: reuseIdentifier
    ///   - viewType: viewType
    public class func registerHeaderFooterView(collectionView: UICollectionView, reuseIdentifier: String = String.init(describing: self), viewType: ReusableViewType) {
        
        var kind : String
        switch viewType {
        case .SectionHeader:
            kind = UICollectionView.elementKindSectionHeader
        case .SectionFooter:
            kind = UICollectionView.elementKindSectionFooter
        }
        
        collectionView.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - 复用取值
    /// 重用HeaderFooter
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - reuseIdentifier: reuseIdentifier
    ///   - viewType: viewType
    ///   - indexPath: indexPath
    /// - Returns: UICollectionReusableView
    public class func dequeueReusableHeaderFooterView(collectionView: UICollectionView, reuseIdentifier: String = String.init(describing: self), viewType: ReusableViewType, indexPath: IndexPath) ->UICollectionReusableView{
        
        var kind : String
        switch viewType {
        case .SectionHeader:
            kind = UICollectionView.elementKindSectionHeader
        case .SectionFooter:
            kind = UICollectionView.elementKindSectionFooter
        }
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
}
