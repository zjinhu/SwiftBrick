//
//  CollectionViewDataSource.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit

open class CollectionViewDataSource<Section, Item>: NSObject, SectionedDataSource, UICollectionViewDataSource  where Section : Hashable, Item : Hashable {
 
    public typealias CellProvider  = (UICollectionView, IndexPath, Item) -> UICollectionViewCell

    public let cellProvider : CellProvider 

    private weak var collectionView: UICollectionView?
    public required init(_ collectionView: UICollectionView, cellGetter: @escaping CellProvider ) {
        self.cellProvider  = cellGetter
        super.init()
        collectionView.dataSource = self
    }
 
    public typealias _Section = Section
    
    public typealias _Item = Item
    
    public var sections: [SectionWithContent] = []
 
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsCount()
    }
 
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount(in: section)
    }
 
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cellProvider (collectionView, indexPath, self[indexPath])
        return cell
    }
}
