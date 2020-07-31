//
//  DataSource.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation

class DataSource <Section: Hashable, Item: Hashable>{
    
    typealias SectionWithContent = SectionStruct<Section, Item>.Section
    
    var sections: [SectionWithContent] = []
    
    func sectionsCount() -> Int{
        return sections.count
    }

    func itemsCount(in section: Int) -> Int{
        return sections[section].elements.count
    }

    func itemIdentifier(for indexPath: IndexPath) -> Item? {
        guard 0..<sections.endIndex ~= indexPath.section else {
            return nil
        }

        let items = sections[indexPath.section].elements

        guard 0..<items.endIndex ~= indexPath.item else {
            return nil
        }

        return items[indexPath.item].differenceIdentifier
    }
}

