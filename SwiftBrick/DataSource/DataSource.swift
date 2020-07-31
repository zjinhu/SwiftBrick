//
//  DataSource.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
public protocol SectionedDataSource: class {
    associatedtype _Section
    associatedtype _Item
    
    typealias SectionWithContent = (section: _Section, items: [_Item])
    
    var sections: [SectionWithContent] { get set }
}

public extension SectionedDataSource {
    
    func sectionsCount() -> Int{
        return sections.count
    }

    func itemsCount(in section: Int) -> Int{
        return sections[section].items.count
    }

    subscript(sectionIndex: Int) -> _Section{
        get{
            return sections[sectionIndex].section
        }
    }

    subscript(indexPath: IndexPath) -> _Item{
        get{
            return sections[indexPath.section].items[indexPath.item]
        }
    }
}
