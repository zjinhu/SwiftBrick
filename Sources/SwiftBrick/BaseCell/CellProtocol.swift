//
//  CellProtocol.swift
//  SwiftBrick
//
//  Created by iOS on 2020/5/15.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
// MARK: ===================================Cell Protocol=========================================
// MARK: ===================================Cell协议=========================================
/// Protocol for reusable cell definition / 协议定义Cell
public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    /// Default reuse identifier from class name / 默认复用标识为类名
    static var reuseIdentifier: String { return String(describing: self) }
}


public extension SwiftBrickWrapper where Wrapped: UITableView {
    /// Register UITableViewCell / 注册UITableViewCell
    /// - Parameter cellType: UITableViewCell class / UITableViewCell类
    func registerCell<T: UITableViewCell>(_ cellType: T.Type)
        where T: Reusable {
            wrapped.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /// Dequeue registered UITableViewCell / 复用已注册的UITableViewCell
    /// - Parameter cellType: UITableViewCell / UITableViewCell
    /// - Returns: UITableViewCell / UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = wrapped.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                )
            }
            return cell
    }
    
    /// Register UITableViewHeaderFooterView / 注册UITableViewHeaderFooterView
    /// - Parameter headerFooterViewType: UITableViewHeaderFooterView class / UITableViewHeaderFooterView类
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerFooterViewType: T.Type)
        where T: Reusable {
            wrapped.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    /// Dequeue registered UITableViewHeaderFooterView / 复用已注册的UITableViewHeaderFooterView
    /// - Parameter headerFooterViewType: UITableViewHeaderFooterView / UITableViewHeaderFooterView
    /// - Returns: UITableViewHeaderFooterView / UITableViewHeaderFooterView
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerFooterViewType: T.Type = T.self) -> T?
        where T: Reusable {
            guard let view = wrapped.dequeueReusableHeaderFooterView(withIdentifier: headerFooterViewType.reuseIdentifier) as? T? else {
                fatalError(
                    "Failed to dequeue a header/footer with identifier \(headerFooterViewType.reuseIdentifier) "
                )
            }
            return view
    }
}
    
/// View kind type - header or footer / 样式，header还是footer
public enum ReusableViewKindType {
    case sectionHeader//UICollectionElementKindSectionHeader
    case sectionFooter//UICollectionElementKindSectionFooter
}

public extension SwiftBrickWrapper where Wrapped: UICollectionView {
    /// Register UICollectionViewCell / 注册UICollectionViewCell
    /// - Parameter cellType: UICollectionViewCell / UICollectionViewCell
    func registerCell<T: UICollectionViewCell>(_ cellType: T.Type)
        where T: Reusable {
            wrapped.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /// Dequeue registered UICollectionViewCell / 复用已经注册的UICollectionViewCell
    /// - Parameters:
    ///   - cellType: UICollectionViewCell / UICollectionViewCell
    ///   - indexPath: indexPath / indexPath
    /// - Returns: UICollectionViewCell / UICollectionViewCell
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type = T.self, indexPath: IndexPath) -> T
        where T: Reusable {
            let bareCell = wrapped.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
            guard let cell = bareCell as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                )
            }
            return cell
    }
    
    /// Register UICollectionReusableView for header/footer / 注册UICollectionReusableView，用于header、footer
    /// - Parameters:
    ///   - headerFooterViewType: UICollectionReusableView / UICollectionReusableView
    ///   - kindType: ReusableViewKindType / ReusableViewKindType
    func registerHeaderFooterView<T: UICollectionReusableView>(_ headerFooterViewType: T.Type, kindType: ReusableViewKindType)
        where T: Reusable {
            
            var kind: String
            switch kindType {
            case .sectionHeader:
                kind = UICollectionView.elementKindSectionHeader
            case .sectionFooter:
                kind = UICollectionView.elementKindSectionFooter
            }
            wrapped.register(
                headerFooterViewType.self,
                forSupplementaryViewOfKind: kind,
                withReuseIdentifier: headerFooterViewType.reuseIdentifier
            )
    }
    
    /// Dequeue registered UICollectionReusableView / 复用已经注册的UICollectionReusableView
    /// - Parameters:
    ///   - headerFooterViewType: UICollectionReusableView / UICollectionReusableView
    ///   - kindType: ReusableViewKindType / ReusableViewKindType
    ///   - indexPath: indexPath / indexPath
    /// - Returns: UICollectionReusableView / UICollectionReusableView
    func dequeueReusableHeaderFooterView<T: UICollectionReusableView>
        (_ headerFooterViewType: T.Type = T.self, kindType: ReusableViewKindType, indexPath: IndexPath) -> T
        where T: Reusable {
            
            var kind: String
            switch kindType {
            case .sectionHeader:
                kind = UICollectionView.elementKindSectionHeader
            case .sectionFooter:
                kind = UICollectionView.elementKindSectionFooter
            }
            
            let view = wrapped.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: headerFooterViewType.reuseIdentifier,
                for: indexPath
            )
            guard let typedView = view as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(headerFooterViewType.reuseIdentifier) "
                )
            }
            return typedView
    }
    
}
