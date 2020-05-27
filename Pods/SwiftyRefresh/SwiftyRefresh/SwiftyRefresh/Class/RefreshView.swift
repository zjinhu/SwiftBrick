//
//  RefreshProtocol.swift
//  SwiftBrick
//
//  Created by iOS on 2020/5/26.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit

/// 刷新的类型
/// - header: 头部下拉刷新
/// - footer: 底部收到加载更多
/// - autoFooter: 底部自动加载更多
public enum RefreshViewType {
    case header, footer, autoFooter
}

/// 当前的状态
/// - noraml: 正常状态
/// - pulling: 正在下拉或上拉
/// - loading: 正在加载数据
/// - noMoreData: 没有更多数据
public enum RefreshViewState {
    case noraml, pulling, willLoading, loading, noMoreData
}

open class RefreshView : UIView {

    public var normalText: String?
    public var pullingText: String?
    public var loadingText: String?
    ///加载数据时悬挂的高度
    public var hangingOffsetHeight: CGFloat = 55
    public var arrowOffsetX: CGFloat = 0
    public var refreshType = RefreshViewType.header
    ///刷新偏移量百分比
    public var pullingPercentHandler: ((_ percent: CGFloat) -> Void)?
    public var refreshHandler: ((RefreshView) -> Void)?
    
    public var pullingPercent: CGFloat = 0 {
        didSet {
            if pullingPercent != oldValue {
                pullingPercentHandler?(pullingPercent)
            }
        }
    }
    public var state = RefreshViewState.noraml {
        didSet {
            if state != oldValue {
                switch state {
                case .noraml:
                    changeToStatusNormal()
                    if oldValue == .loading {//之前是在刷新,更新时间
                        changeToRefreshDate()
                    }
                case .pulling:
                    changeToStatusPulling()
                case .willLoading:
                    changeToStatusWillLoading()
                    break
                case .loading:
                    changeToStatusLoading()
                case .noMoreData:
                    changeToStatusNoMoreData()
                }
            }
        }
    }
    
    public weak var scrollView: UIScrollView?

    ///scrollView刚开始的inset
    public var scrollViewOriginalEdgeInsets = UIEdgeInsets.zero
    
    var contentOffsetObs: NSKeyValueObservation?
    var contentSizeObs: NSKeyValueObservation?
    var contentInsetObs: NSKeyValueObservation?

    public var scrollViewEdgeInsets: UIEdgeInsets {
        guard let scrollView = scrollView else {
            return UIEdgeInsets.zero
        }
        if #available(iOS 11.0, *) {
            return scrollView.adjustedContentInset
        } else {
            return scrollView.contentInset
        }
    }

    //MARK:初始化
    required public init(frame: CGRect, hangingOffsetHeight hangingH: CGFloat = 55, refreshType type: RefreshViewType = .header, refreshHandler handler: @escaping (RefreshView) -> Void) {
        refreshType = type
        refreshHandler = handler
        hangingOffsetHeight = hangingH
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        //添加刷新的界面
        addRefreshContentView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addRefreshContentView()
    }

    //MARK:添加观察者
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        removeScrollViewObservers()
        guard let newSuperview = newSuperview as? UIScrollView else {
            return
        }
        scrollView = newSuperview
        scrollViewOriginalEdgeInsets = newSuperview.contentInset
        addScrollViewObservers()
    }
     
    // MARK: 刷新界面、状态方法
    /// 添加刷新的界面
    ///
    /// * 注：如果想自定义刷新加载界面，可在子类中重写该方法进行布局子界面
    open func addRefreshContentView() {}
    
    ///自动刷新
    open func beginRefreshing() {}
    
    ///结束刷新
    open func endRefreshing() {
        state = .noraml
    }
    
    ///显示没有更多数据
    open func showNoMoreData() {}
    
    ///重置没有更多的数据（消除没有更多数据的状态）
    open func resetNoMoreData() {}

    /// 下面是状态改变时，可以对动画等做出自定义处理
    open func changeToStatusNormal() {}
    open func changeToStatusPulling() {}
    open func changeToStatusWillLoading() {}
    open func changeToStatusLoading() {}
    open func changeToStatusNoMoreData() {}
    open func changeToRefreshDate() {}

    /// 隐藏时间
    open func hideDateView() {}
    
    /// 隐藏状态和时间
    open func hideStatusAndDateView() {}
    
    /// 当scrollView的contentOffset发生改变的时候调用
    ///
    /// - Parameter scrollView: scrollView
    open func scrollViewContentOffsetDidChange(scrollView: UIScrollView) {}
    
    /// 当scrollView的contentSize发生改变的时候调用
    ///
    /// - Parameter scrollView: scrollView
    open func scrollViewContentSizeDidChange(scrollView: UIScrollView) {}
    
    @discardableResult
    public func pullingPercentHandler(handler: @escaping (CGFloat) -> Void) -> Self {
        pullingPercentHandler = handler
        return self
    }
}

extension RefreshView {
    func addScrollViewObservers() {
        
        guard let scrollView = scrollView else {
            return
        }

        contentOffsetObs = scrollView.observe(\UIScrollView.contentOffset, options: .new, changeHandler: {  [weak self] (scrollView, _) in
            //正在刷新
            if self?.state == .loading {
                return
            }
            // contentInset可能会变
            self?.scrollViewOriginalEdgeInsets = scrollView.contentInset
            self?.scrollViewContentOffsetDidChange(scrollView: scrollView)
        })
        
        if refreshType != .header {
            contentSizeObs = scrollView.observe(\UIScrollView.contentOffset, options: .new, changeHandler: { [weak self] (scrollView, _) in
                if self?.refreshType == .header {
                    return
                }
                self?.scrollViewContentSizeDidChange(scrollView: scrollView)
            })
        }
        
        contentInsetObs = scrollView.observe(\UIScrollView.contentOffset, options: .new, changeHandler: { [weak self] (scrollView, _) in
            if self?.state != .loading {//不是正在加载的状态
                self?.scrollViewOriginalEdgeInsets = scrollView.contentInset
            }
        })
    }
    
    func removeScrollViewObservers() {
        contentOffsetObs = nil
        contentSizeObs = nil
        contentInsetObs = nil
    }
}

public class ImageLoader{

    static var bundle: Bundle? = {
        let path = Bundle.init(for: ImageLoader.self).path(forResource: "SwiftyRefresh", ofType: "bundle", inDirectory: nil)
        let bundle = Bundle.init(path: path ?? "")
        return bundle
    }()
    
    public static func loadImage(with name: String) -> UIImage? {
        var image = UIImage.init(named: name, in: bundle, compatibleWith: nil)
        if image == nil {
            image = UIImage(named: name)
        }
        return image
    }
}
