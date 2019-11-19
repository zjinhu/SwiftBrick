//
//  JHBaseTableViewCell.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

class JHTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configCellViews()
    }
    
    public func configCellViews() {
        
    }
    
    public func setCellModel(model: Any) {
        
    }
    
    public func getCellHeightWithModel(model: Any) -> CGFloat {
        self.setCellModel(model: model)
        self.layoutIfNeeded()
        self.updateConstraintsIfNeeded()
        let height = self.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return height
    }
    
    
    public class func registerCell(tableView: UITableView, reuseIdentifier: String = String.init(describing: self)) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier)
    }

    public class func dequeueReusableCell(tableView: UITableView, reuseIdentifier: String = String.init(describing: self)) ->UITableViewCell{
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
    }
}
