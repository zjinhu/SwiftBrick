//
//  CollectionViewDataSource.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit

open class CollectionViewDataSource<Section, Item>: NSObject, UICollectionViewDataSource  where Section : Hashable, Item : Hashable {
 
    public typealias CellProvider  = (UICollectionView, IndexPath, Item) -> UICollectionViewCell

    public let cellProvider : CellProvider 

    private weak var collectionView: UICollectionView?
    public required init(_ collectionView: UICollectionView, cellGetter: @escaping CellProvider ) {
        self.cellProvider  = cellGetter
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
    }

    private let dataSource = DataSource<Section, Item>()
 
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.sectionsCount()
    }
 
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.itemsCount(in: section)
    }
 
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            fatalError("cell nil")
        }
        let cell = cellProvider (collectionView, indexPath, item)
        return cell
    }
    
    public func apply(_ snapshot: DiffableDataSource<Section, Item>) {
        dataSource.sections = snapshot.structure.sections
        collectionView?.reloadData()
    }
}
