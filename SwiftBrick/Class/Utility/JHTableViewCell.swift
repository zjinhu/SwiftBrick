//
//  JHBaseTableViewCell.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

open class JHTableViewCell: UITableViewCell{

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = String.init(describing: self)) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        self.configCellViews()
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
    /// 注册cell
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - reuseIdentifier: reuseIdentifier description
    public class func registerCell(tableView: UITableView, reuseIdentifier: String = String.init(describing: self)) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - 复用取值
    /// cell重用
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - reuseIdentifier: reuseIdentifier description
    /// - Returns: UITableViewCell
    public class func dequeueReusableCell(tableView: UITableView, reuseIdentifier: String = String.init(describing: self)) ->UITableViewCell?{
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
    }
}
