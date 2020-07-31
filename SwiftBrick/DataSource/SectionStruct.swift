//
//  SectionStruct.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation

public struct SectionStruct<SectionID: Hashable, ItemID: Hashable> {
    
    public struct Item: Hashable {
        var differenceIdentifier: ItemID
        init(id: ItemID) {
            self.differenceIdentifier = id
        }
    }
    
    public struct Section: Hashable {
        var differenceIdentifier: SectionID
        var elements: [Item] = []

        init(id: SectionID, items: [Item]) {
            self.differenceIdentifier = id
            self.elements = items
        }
        
        init(id: SectionID) {
            self.init(id: id, items: [])
        }
    }
    
    var sections: [Section] = []
    
    mutating func append(itemIDs: [ItemID], to sectionID: SectionID? = nil, file: StaticString = #file, line: UInt = #line) {
         let index: Array<Section>.Index

         if let sectionID = sectionID {
             guard let sectionIndex = sectionIndex(of: sectionID) else {
                 specifiedSectionIsNotFound(sectionID, file: file, line: line)
             }

             index = sectionIndex
         }
         else {
             guard !sections.isEmpty else {
                 thereAreCurrentlyNoSections(file: file, line: line)
             }

             index = sections.index(before: sections.endIndex)
         }

         let items = itemIDs.lazy.map(Item.init)
         sections[index].elements.append(contentsOf: items)
     }

     mutating func insert(itemIDs: [ItemID], before beforeItemID: ItemID, file: StaticString = #file, line: UInt = #line) {
         guard let itemPosition = itemPositionMap()[beforeItemID] else {
             specifiedItemIsNotFound(beforeItemID, file: file, line: line)
         }

         let items = itemIDs.lazy.map(Item.init)
         sections[itemPosition.sectionIndex].elements.insert(contentsOf: items, at: itemPosition.itemRelativeIndex)
     }

     mutating func insert(itemIDs: [ItemID], after afterItemID: ItemID, file: StaticString = #file, line: UInt = #line) {
         guard let itemPosition = itemPositionMap()[afterItemID] else {
             specifiedItemIsNotFound(afterItemID, file: file, line: line)
         }

         let itemIndex = sections[itemPosition.sectionIndex].elements.index(after: itemPosition.itemRelativeIndex)
         let items = itemIDs.lazy.map(Item.init)
         sections[itemPosition.sectionIndex].elements.insert(contentsOf: items, at: itemIndex)
     }

     mutating func remove(itemIDs: [ItemID]) {
         let itemPositionMap = self.itemPositionMap()
         var removeIndexSetMap = [Int: IndexSet]()

         for itemID in itemIDs {
             guard let itemPosition = itemPositionMap[itemID] else {
                 continue
             }

             removeIndexSetMap[itemPosition.sectionIndex, default: []].insert(itemPosition.itemRelativeIndex)
         }

         for (sectionIndex, removeIndexSet) in removeIndexSetMap {
             for range in removeIndexSet.rangeView.reversed() {
                 sections[sectionIndex].elements.removeSubrange(range)
             }
         }
     }

     mutating func removeAllItems() {
         for sectionIndex in sections.indices {
             sections[sectionIndex].elements.removeAll()
         }
     }
    
    mutating func append(sectionIDs: [SectionID]) {
        let newSections = sectionIDs.lazy.map(Section.init)
        sections.append(contentsOf: newSections)
    }

    mutating func insert(sectionIDs: [SectionID], before beforeSectionID: SectionID, file: StaticString = #file, line: UInt = #line) {
        guard let sectionIndex = sectionIndex(of: beforeSectionID) else {
            specifiedSectionIsNotFound(beforeSectionID, file: file, line: line)
        }

        let newSections = sectionIDs.lazy.map(Section.init)
        sections.insert(contentsOf: newSections, at: sectionIndex)
    }

    mutating func insert(sectionIDs: [SectionID], after afterSectionID: SectionID, file: StaticString = #file, line: UInt = #line) {
        guard let beforeIndex = sectionIndex(of: afterSectionID) else {
            specifiedSectionIsNotFound(afterSectionID, file: file, line: line)
        }

        let sectionIndex = sections.index(after: beforeIndex)
        let newSections = sectionIDs.lazy.map(Section.init)
        sections.insert(contentsOf: newSections, at: sectionIndex)
    }

    mutating func remove(sectionIDs: [SectionID]) {
        for sectionID in sectionIDs {
            remove(sectionID: sectionID)
        }
    }
}

private extension SectionStruct {
    struct ItemPosition {
        var item: Item
        var itemRelativeIndex: Int
        var section: Section
        var sectionIndex: Int
    }

    func sectionIndex(of sectionID: SectionID) -> Array<Section>.Index? {
        return sections.firstIndex { $0.differenceIdentifier.isEqualHash(to: sectionID) }
    }

    @discardableResult
    mutating func remove(itemID: ItemID) -> Item? {
        guard let itemPosition = itemPositionMap()[itemID] else {
            return nil
        }

        return sections[itemPosition.sectionIndex].elements.remove(at: itemPosition.itemRelativeIndex)
    }

    @discardableResult
    mutating func remove(sectionID: SectionID) -> Section? {
        guard let sectionIndex = sectionIndex(of: sectionID) else {
            return nil
        }

        return sections.remove(at: sectionIndex)
    }

    func itemPositionMap() -> [ItemID: ItemPosition] {
        return sections.enumerated().reduce(into: [:]) { result, section in
            for (itemRelativeIndex, item) in section.element.elements.enumerated() {
                result[item.differenceIdentifier] = ItemPosition(
                    item: item,
                    itemRelativeIndex: itemRelativeIndex,
                    section: section.element,
                    sectionIndex: section.offset
                )
            }
        }
    }

    func specifiedItemIsNotFound(_ id: ItemID, file: StaticString, line: UInt) -> Never {
        universalError("Specified item\(id) is not found.", file: file, line: line)
    }

    func specifiedSectionIsNotFound(_ id: SectionID, file: StaticString, line: UInt) -> Never {
        universalError("Specified section\(id) is not found.", file: file, line: line)
    }

    func thereAreCurrentlyNoSections(file: StaticString, line: UInt) -> Never {
        universalError("There are currently no sections.", file: file, line: line)
    }
}

extension Hashable {
    func isEqualHash(to other: Self) -> Bool {
        return hashValue == other.hashValue && self == other
    }
}


func universalError(_ message: String, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError("[DiffableDataSources] \(message)", file: file, line: line)
}
