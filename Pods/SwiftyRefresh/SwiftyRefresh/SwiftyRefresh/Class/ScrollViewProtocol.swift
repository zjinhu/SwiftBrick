//
//  RefreshViewProtocol.swift
//  SwiftBrick
//
//  Created by iOS on 2020/5/27.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
public typealias ScrollView = UIScrollView
public protocol ScrollViewProtocol {
    
    var scroll: ScrollView {set get}
    /// 头部控件
    var header: RefreshView? {set get}
    /// 头部控件
    var footer: RefreshView? {set get}
}

private var kRefreshHeaderKey = "kRefreshHeaderKey"
private var kRefreshFooterKey = "kRefreshFooterKey"

extension ScrollViewProtocol {
    
    public var header:RefreshView? {
        get {
            return (objc_getAssociatedObject(scroll, &kRefreshHeaderKey) as? RefreshView)
        }
        set {
            objc_setAssociatedObject(scroll, &kRefreshHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var footer: RefreshView? {
        get {
            return (objc_getAssociatedObject(scroll, &kRefreshFooterKey) as? RefreshView)
        }
        set {
            objc_setAssociatedObject(scroll, &kRefreshFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension ScrollView {
    public var refresh: ScrollViewDSL {
        return ScrollViewDSL(scroll: self)
    }
}

public struct ScrollViewDSL: ScrollViewProtocol {
    
    public var scroll: ScrollView
    
    internal init(scroll: ScrollView) {
        self.scroll = scroll
    }
    /// 添加上拉刷新控件
    @discardableResult
    public func addRefreshHeader(handler: @escaping (RefreshView) -> Void) -> RefreshView {
        scroll.layoutIfNeeded()
        return RefreshMake.addHeadRefresh(scroll: scroll, handler: handler)
    }
    
    @discardableResult
    public func addCustomRefreshHeader<T>(header: T.Type, headerHeight: CGFloat = 55, handler: @escaping (RefreshView) -> Void) -> T where T: RefreshView {
        scroll.layoutIfNeeded()
        return RefreshMake.addCustomHeadRefresh(header: T.self, headerHeight: headerHeight, scroll: scroll, handler: handler)
    }
    
    public func beginHeaderRefresh() {
        header?.beginRefreshing()
    }
    
    public func endHeaderRefresh() {
        header?.endRefreshing()
    }
    
    public func removeHeader() {
        var headRefresh = RefreshMake(scroll: scroll)
        headRefresh.removeHeader()
    }
    
    /// 添加下拉加载控件
    @discardableResult
    public func addRefreshFooter(handler: @escaping (RefreshView) -> Void) -> RefreshView {
        scroll.layoutIfNeeded()
        return RefreshMake.addFootRefresh(scroll: scroll, handler: handler)
    }
    
    @discardableResult
    public func addRefreshAutoFooter(handler: @escaping (RefreshView) -> Void) -> RefreshView {
        scroll.layoutIfNeeded()
        return RefreshMake.addAutoFootRefresh(scroll: scroll, handler: handler)
    }
    
    @discardableResult
    public func addCustomRefreshFooter<T>(footer: T.Type, footerHeight: CGFloat = 55, handler: @escaping (RefreshView) -> Void) -> T where T: RefreshView {
        scroll.layoutIfNeeded()
        return RefreshMake.addCustomFootRefresh(footer: T.self, footerHeight: footerHeight, scroll: scroll, handler: handler)
    }
    
    @discardableResult
    public func addCustomRefreshAutoFooter<T>(footer: T.Type, footerHeight: CGFloat = 55, handler: @escaping (RefreshView) -> Void) -> T where T: RefreshView {
        scroll.layoutIfNeeded()
        return RefreshMake.addCustomAutoFootRefresh(footer: T.self, footerHeight: footerHeight, scroll: scroll, handler: handler)
    }
    
    public func noticeNoMoreData() {
        footer?.endRefreshing()
        footer?.showNoMoreData()
    }
    
    public func resetNoMore() {
        footer?.resetNoMoreData()
    }
    
    public func endLoadingMore() {
        footer?.endRefreshing()
    }
    
    public func removeFooter() {
        var footRefresh = RefreshMake(scroll: scroll)
        footRefresh.removeFooter()
    }
}

public struct RefreshMake: ScrollViewProtocol {
    
    public var scroll: ScrollView
    
    internal init(scroll: ScrollView) {
        self.scroll = scroll
    }
    
    /// 添加上拉刷新
    @discardableResult
    internal static func addHeadRefresh(scroll: ScrollView, handler: @escaping (RefreshView) -> Void) -> RefreshView {
        var make = RefreshMake(scroll: scroll)
        make.removeHeader()
        let header = RefreshHeaderView.init(frame: CGRect.init(x: 0, y: -55, width: scroll.bounds.width, height: 55), hangingOffsetHeight: 55, refreshType: .header, refreshHandler: handler)
        scroll.addSubview(header)
        make.header = header
        return header
    }
    
    @discardableResult
    internal static func addCustomHeadRefresh<T>(header: T.Type, headerHeight: CGFloat = 55, scroll: ScrollView, handler: @escaping (RefreshView) -> Void) -> T where T: RefreshView {
         var make = RefreshMake(scroll: scroll)
         make.removeHeader()
         let header = T.init(frame: CGRect.init(x: 0, y: -headerHeight, width: scroll.bounds.width, height: headerHeight), hangingOffsetHeight: headerHeight, refreshType: .header, refreshHandler: handler)
         scroll.addSubview(header)
         make.header = header
         return header
     }
    
    public mutating func removeHeader() {
        header?.endRefreshing()
        header?.removeFromSuperview()
        header = nil
    }
    
    /// 添加下拉加载
    @discardableResult
    internal static func addFootRefresh(scroll: ScrollView, handler: @escaping (RefreshView) -> Void) -> RefreshView {
        var make = RefreshMake(scroll: scroll)
        make.removeFooter()
        let footer = RefreshFooterView.init(frame: CGRect.init(x: 0, y: 0, width: scroll.bounds.width, height: 55), hangingOffsetHeight: 55, refreshType: .footer, refreshHandler: handler)
        scroll.addSubview(footer)
        make.footer = footer
        return footer
    }
    
    @discardableResult
    internal static func addAutoFootRefresh(scroll: ScrollView, handler: @escaping (RefreshView) -> Void) -> RefreshView {
        var make = RefreshMake(scroll: scroll)
        make.removeFooter()
        let footer = RefreshFooterView.init(frame: CGRect.init(x: 0, y: 0, width: scroll.bounds.width, height: 55), hangingOffsetHeight: 55, refreshType: .autoFooter, refreshHandler: handler)
        scroll.addSubview(footer)
        make.footer = footer
        return footer
    }
    
    @discardableResult
    internal static func addCustomFootRefresh<T>(footer: T.Type, footerHeight: CGFloat = 55, scroll: ScrollView, handler: @escaping (RefreshView) -> Void) -> T where T: RefreshView {
         var make = RefreshMake(scroll: scroll)
         make.removeFooter()
         let footer = T.init(frame: CGRect.init(x: 0, y: 0, width: scroll.bounds.width, height: footerHeight), hangingOffsetHeight: footerHeight, refreshType: .footer, refreshHandler: handler)
         scroll.addSubview(footer)
         make.footer = footer
         return footer
     }
    
    @discardableResult
    internal static func addCustomAutoFootRefresh<T>(footer: T.Type, footerHeight: CGFloat = 55, scroll: ScrollView, handler: @escaping (RefreshView) -> Void) -> T where T: RefreshView {
         var make = RefreshMake(scroll: scroll)
         make.removeFooter()
         let footer = T.init(frame: CGRect.init(x: 0, y: 0, width: scroll.bounds.width, height: footerHeight), hangingOffsetHeight: footerHeight, refreshType: .autoFooter, refreshHandler: handler)
         scroll.addSubview(footer)
         make.footer = footer
         return footer
     }
    public mutating func removeFooter() {
        footer?.endRefreshing()
        footer?.removeFromSuperview()
        footer = nil
    }
}
