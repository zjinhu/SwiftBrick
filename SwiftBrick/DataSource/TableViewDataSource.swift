//
//  TableViewDataSource.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit

open class TableViewDataSource<Section, Item>: NSObject, SectionedDataSource, UITableViewDataSource where Section : Hashable, Item : Hashable {

    public typealias CellProvider = (UITableView, IndexPath, Item) -> UITableViewCell
    
    public let cellProvider : CellProvider

    private weak var tableView: UITableView?
    
    public required init(_ tableView: UITableView, cellGetter: @escaping CellProvider) {
        self.cellProvider  = cellGetter
        super.init()
        tableView.dataSource = self
    }
    
    public typealias _Section = Section
    
    public typealias _Item = Item
    
    public var sections: [SectionWithContent] = []
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount()
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount(in: section)
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellProvider (tableView, indexPath, self[indexPath])
        return cell
    }
}
