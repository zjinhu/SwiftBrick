//
//  TableViewDataSource.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit

open class TableViewDataSource<Section, Item>: NSObject, UITableViewDataSource where Section: Hashable, Item: Hashable {

    public typealias CellProvider = (UITableView, IndexPath, Item) -> UITableViewCell
    
    public let cellProvider: CellProvider

    private weak var tableView: UITableView?
    
    public required init(_ tableView: UITableView, cellGetter: @escaping CellProvider) {
        self.cellProvider  = cellGetter
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
    }
    
    private let dataSource = DataSource<Section, Item>()
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sectionsCount()
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.itemsCount(in: section)
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            fatalError("cell nil")
        }
        let cell = cellProvider (tableView, indexPath, item)
        return cell
    }
    
    public func apply(_ snapshot: DiffableDataSource<Section, Item>) {
        dataSource.sections = snapshot.structer.sections
        tableView?.reloadData()
    }
}
