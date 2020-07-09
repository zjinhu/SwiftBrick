//
//  EmptySwizzing.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/7.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit

private var kEmptyView = "emptyDataView"

public extension UIScrollView {
    // 空白页视图
    var emptyView: EmptyView? {
        get {
            return objc_getAssociatedObject(self, &kEmptyView) as? EmptyView
        }
        set {

            if newValue != nil {
                /// 兼容子类化情况
                if self.isKind(of: UITableView.self) {
                    EmptySwizzing.swizzingTableView
                } else if self.isKind(of: UICollectionView.self) {
                    EmptySwizzing.swizzingCollectionView
                }
                
                objc_setAssociatedObject(self, &kEmptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                self.subviews.forEach { (vi) in
                    if vi.isKind(of: EmptyView.self){
                        vi.removeFromSuperview()
                    }
                }
                
                addSubview(newValue!) 
                
                if self.isKind(of: UITableView.self) ||
                    self.isKind(of: UICollectionView.self){
                    setModeEmptyView()
                }else{
                    newValue?.isHidden = true
                }
            }

        }
    }

    fileprivate func setModeEmptyView() {
        
        guard let _ = emptyView else {
            return
        }
        
        if itemsCount == 0 {
            show()
        }else{
            hide()
        }
    }
    
    fileprivate func show(){
        showEmptyView()
    }
    
    fileprivate func hide(){
        hideEmptyView()
    }
    
    /// 手动调用显示emptyView
    func showEmptyView(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = false
        bringSubviewToFront(em)
    }
    
    /// 手动调用隐藏emptyView
    func hideEmptyView(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = true
    }
    
    /// 一般用于开始请求网络时调用，startEmptyLoading调用时会暂时隐藏emptyView 当调用endEmptyLoading方法时，endEmptyLoading方法内部会根据当前的tableView/collectionView的 DataSource来自动判断是否显示emptyView
    func startEmptyLoading(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = true
    }
    
    /// 在想要刷新emptyView状态时调用 注意:endEmptyLoading 的调用时机，有刷新UI的地方一定要等到刷新UI的方法之后调用，
    func endEmptyLoading(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = itemsCount > 0 ? true : false
    }
    
    fileprivate var itemsCount: Int {
        var items = 0
        
        // UITableView support
        if let tableView = self as? UITableView {
            var sections = 1
            
            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: tableView)
                }
                if dataSource.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.tableView(tableView, numberOfRowsInSection: i)
                    }
                }
            }
        } else if let collectionView = self as? UICollectionView {
            var sections = 1
            
            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: #selector(UICollectionViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: collectionView)
                }
                if dataSource.responds(to: #selector(UICollectionViewDataSource.collectionView(_:numberOfItemsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.collectionView(collectionView, numberOfItemsInSection: i)
                    }
                }
            }
        }
        
        return items
    }
}

struct EmptySwizzing {

    /// 替换 tableView 相关函数
    static let swizzingTableView: Void = {

        swizzing(sel: #selector(UITableView.reloadData),
                 of: #selector(UITableView.empty_reloadData),
                 in: UITableView.self)

        swizzing(sel: #selector(UITableView.insertRows(at:with:)),
                 of: #selector(UITableView.empty_insertRows(at:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.reloadRows(at:with:)),
                 of: #selector(UITableView.empty_reloadRows(at:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.deleteRows(at:with:)),
                 of: #selector(UITableView.empty_deleteRows(at:with:)),
                 in: UITableView.self)
        
        swizzing(sel: #selector(UITableView.insertSections(_:with:)),
                 of: #selector(UITableView.empty_insertSections(_:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.deleteSections(_:with:)),
                 of: #selector(UITableView.empty_deleteSections(_:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.reloadSections(_:with:)),
                 of: #selector(UITableView.empty_reloadSections(_:with:)),
                 in: UITableView.self)
    }()
    
    /// 替换 CollectionView 相关函数
    static let swizzingCollectionView: Void = {
        swizzing(sel: #selector(UICollectionView.reloadData),
                 of: #selector(UICollectionView.empty_reloadData),
                 in: UICollectionView.self)
        
        swizzing(sel: #selector(UICollectionView.insertItems(at:)),
                 of: #selector(UICollectionView.empty_insertItems(at:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.deleteItems(at:)),
                 of: #selector(UICollectionView.empty_deleteItems(at:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.reloadItems(at:)),
                 of: #selector(UICollectionView.empty_reloadItems(at:)),
                 in: UICollectionView.self)
        
        swizzing(sel: #selector(UICollectionView.insertSections(_:)),
                 of: #selector(UICollectionView.empty_insertSections(_:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.deleteSections(_:)),
                 of: #selector(UICollectionView.empty_deleteSections(_:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.reloadSections(_:)),
                 of: #selector(UICollectionView.empty_reloadSections(_:)),
                 in: UICollectionView.self)
    }()
    
    /// 交换方法
    ///
    /// - Parameters:
    ///   - selector: 被交换的方法
    ///   - replace: 用于交换的方法
    ///   - classType: 所属类型
    static func swizzing(sel: Selector,
                         of: Selector,
                         in classType: AnyClass) {
        let select1 = sel
        let select2 = of
        
        guard let select1Method = class_getInstanceMethod(classType, select1) else {
            assertionFailure("can't find method: " + select1.description)
            return
        }
        
        guard let select2Method = class_getInstanceMethod(classType, select2) else {
            assertionFailure("can't find method: " + select1.description)
            return
        }
        
        let didAddMethod = class_addMethod(classType,
                                           select1,
                                           method_getImplementation(select2Method),
                                           method_getTypeEncoding(select2Method))
        if didAddMethod {
            class_replaceMethod(classType,
                                select2,
                                method_getImplementation(select1Method),
                                method_getTypeEncoding(select1Method))
        } else {
            method_exchangeImplementations(select1Method, select2Method)
        }
    }
}

fileprivate extension UITableView {
    
    @objc func empty_reloadData() {
        self.empty_reloadData()
        setModeEmptyView()
    }
    
    
    @objc func empty_insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.empty_insertSections(sections, with: animation)
        setModeEmptyView()
    }
    
    @objc func empty_deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.empty_deleteSections(sections, with: animation)
        setModeEmptyView()
    }
    
    @objc func empty_reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.empty_reloadSections(sections, with: animation)
        setModeEmptyView()
    }
    
    
    @objc func empty_insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.empty_insertRows(at: indexPaths, with: animation)
        setModeEmptyView()
    }
    
    @objc func empty_deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.empty_deleteRows(at: indexPaths, with: animation)
        setModeEmptyView()
    }
    
    @objc func empty_reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.empty_reloadRows(at: indexPaths, with: animation)
        setModeEmptyView()
    }
    
}

fileprivate extension UICollectionView {

    @objc func empty_reloadData() {
        self.empty_reloadData()
        setModeEmptyView()
    }
    
    @objc func empty_insertSections(_ sections: IndexSet) {
        self.empty_insertSections(sections)
        setModeEmptyView()
    }
    
    @objc func empty_deleteSections(_ sections: IndexSet) {
        self.empty_deleteSections(sections)
        setModeEmptyView()
    }
    
    @objc func empty_reloadSections(_ sections: IndexSet) {
        self.empty_reloadSections(sections)
        setModeEmptyView()
    }
    
    @objc func empty_insertItems(at indexPaths: [IndexPath]) {
        self.empty_insertItems(at: indexPaths)
        setModeEmptyView()
    }
    
    @objc func empty_deleteItems(at indexPaths: [IndexPath]) {
        self.empty_deleteItems(at: indexPaths)
        setModeEmptyView()
    }
    
    @objc func empty_reloadItems(at indexPaths: [IndexPath]) {
        self.empty_reloadItems(at: indexPaths)
        setModeEmptyView()
    }
}
