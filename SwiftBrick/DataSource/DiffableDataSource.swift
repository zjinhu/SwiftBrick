//
//  DiffableDataSource.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation

public struct DiffableDataSource<SectionID: Hashable, ItemID: Hashable> {
    internal var structer = SectionStruct<SectionID, ItemID>()

    public init() {}

    public mutating func appendItems(_ identifiers: [ItemID], toSection sectionIdentifier: SectionID? = nil) {
        structer.append(itemIDs: identifiers, to: sectionIdentifier)
    }

    public mutating func insertItems(_ identifiers: [ItemID], beforeItem beforeIdentifier: ItemID) {
        structer.insert(itemIDs: identifiers, before: beforeIdentifier)
    }

    public mutating func insertItems(_ identifiers: [ItemID], afterItem afterIdentifier: ItemID) {
        structer.insert(itemIDs: identifiers, after: afterIdentifier)
    }

    public mutating func deleteItems(_ identifiers: [ItemID]) {
        structer.remove(itemIDs: identifiers)
    }

    public mutating func deleteAllItems() {
        structer.removeAllItems()
    }

    public mutating func appendSections(_ identifiers: [SectionID]) {
        structer.append(sectionIDs: identifiers)
    }

    public mutating func insertSections(_ identifiers: [SectionID], beforeSection toIdentifier: SectionID) {
        structer.insert(sectionIDs: identifiers, before: toIdentifier)
    }

    public mutating func insertSections(_ identifiers: [SectionID], afterSection toIdentifier: SectionID) {
        structer.insert(sectionIDs: identifiers, after: toIdentifier)
    }

    public mutating func deleteSections(_ identifiers: [SectionID]) {
        structer.remove(sectionIDs: identifiers)
    }

}

