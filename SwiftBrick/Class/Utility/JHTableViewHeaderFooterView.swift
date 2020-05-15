//
//  JHTableViewHeaderFooterView.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

open class JHTableViewHeaderFooterView: UITableViewHeaderFooterView{

    public var backColor : UIColor? {
        didSet{
            self.backgroundView?.backgroundColor = backColor
        }
    }
    
    public override init(reuseIdentifier: String? = String.init(describing: self)) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = .clear
        self.configCellViews()
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
        let height = self.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return height
    }
    
    // MARK: - 注册
    /// 注册HeaderFooter
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - reuseIdentifier: reuseIdentifier description
    public class func registerHeaderFooterView(tableView: UITableView, reuseIdentifier: String = String.init(describing: self)) {
        tableView.register(self, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - 复用取值
    /// HeaderFooter重用
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - reuseIdentifier: reuseIdentifier description
    /// - Returns: UITableViewHeaderFooterView
    public class func dequeueReusableHeaderFooterView(tableView: UITableView, reuseIdentifier: String = String.init(describing: self)) ->UITableViewHeaderFooterView?{
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier)
    }
}
