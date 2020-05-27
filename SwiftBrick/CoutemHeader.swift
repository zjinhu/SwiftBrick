//
//  CoutemHeader.swift
//  SwiftBrick
//
//  Created by iOS on 2020/5/27.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
import SwiftyRefresh
private let createLabel = { () -> UILabel in
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .center
    label.textColor = UIColor.red
    return label
}
open class CoutemHeader: RefreshView {
    public let statusLabel = createLabel()
    public let dateLabel = createLabel()
    public let arrowImageView = UIImageView.init(image: UIImage.init(named: "fcx_arrow", in: Bundle.init(for: RefreshView.self), compatibleWith: nil))
    let activityView = UIActivityIndicatorView.init(style: .gray)
    
    override open func addRefreshContentView() {
        addSubview(statusLabel)
        addSubview(dateLabel)
        addSubview(arrowImageView)
        addSubview(activityView)
        normalText = "下拉即可刷新"
        pullingText = "松开即可刷新"
        loadingText = "正在刷新..."
        statusLabel.text = normalText
        dateLabel.text = currentDateString()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if dateLabel.isHidden && statusLabel.isHidden {
            arrowImageView.frame = CGRect.init(x: self.frame.size.width/2 - 7.5 + arrowOffsetX, y: self.frame.size.height - hangingOffsetHeight + (hangingOffsetHeight - 40)/2.0, width: 15, height: 40)
        } else if (dateLabel.isHidden) {
            statusLabel.frame = CGRect.init(x: 0, y: self.frame.size.height - hangingOffsetHeight, width: self.frame.size.width, height: hangingOffsetHeight)
            arrowImageView.frame = CGRect.init(x: self.frame.size.width/2 - 100 + arrowOffsetX, y: self.frame.size.height - hangingOffsetHeight + (hangingOffsetHeight - 40)/2.0, width: 15, height: 40)
        } else {
            statusLabel.frame = CGRect.init(x: 0, y: self.frame.size.height - 45, width: self.frame.size.width, height: 20)
            dateLabel.frame = CGRect.init(x: 0, y: self.frame.size.height - 25, width: self.frame.size.width, height: 20)
            arrowImageView.frame = CGRect.init(x: self.frame.size.width/2 - 100 + arrowOffsetX, y: self.frame.size.height - hangingOffsetHeight + (hangingOffsetHeight - 40)/2.0, width: 15, height: 40)
        }
        activityView.frame = arrowImageView.frame
    }
    
    open override func hideDateView() {
        dateLabel.isHidden = true
        setNeedsLayout()
    }
    
    open override func hideStatusAndDateView() {
        statusLabel.isHidden = true
        dateLabel.isHidden = true
        setNeedsLayout()
    }

    open override func scrollViewContentOffsetDidChange(scrollView: UIScrollView) {
        let edgeTop = self.scrollViewEdgeInsets.top
        if scrollView.contentOffset.y > -edgeTop {
            //向上滚动到看不见头部控件，直接返回
            return
        }

        if scrollView.isDragging {//正在拖拽
            if scrollView.contentOffset.y + edgeTop < -hangingOffsetHeight {//大于偏移量，转为pulling
                state = .pulling
            } else {//小于偏移量，转为正常normal
                state = .noraml
            }
            
        } else {
            if state == .pulling {
                state = .loading
            } else if (state == .willLoading) {
                state = .noraml
            }
        }
        
        guard pullingPercentHandler != nil  else {
            return
        }
        let offsetHeight = -scrollView.contentOffset.y - edgeTop
        if offsetHeight >= 0 {
            pullingPercent = min(offsetHeight, hangingOffsetHeight)/hangingOffsetHeight
        }
    }
    
    open override func changeToStatusNormal() {
        statusLabel.text = normalText
        activityView.stopAnimating()
        arrowImageView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.arrowImageView.transform = .identity
            self.scrollView?.contentInset = self.scrollViewOriginalEdgeInsets
        })
    }
    
    open override func changeToStatusPulling() {
        statusLabel.text = pullingText
        UIView.animate(withDuration: 0.2, animations: {
            self.arrowImageView.transform = CGAffineTransform.init(rotationAngle: 0.000001 - .pi)
        })
    }
    
    open override func changeToStatusLoading() {
        statusLabel.text = loadingText
        activityView.startAnimating()
        arrowImageView.isHidden = true
        arrowImageView.transform = .identity
        UIView.animate(withDuration: 0.2, animations: {
            var edgeInset = self.scrollViewOriginalEdgeInsets
            edgeInset.top += self.hangingOffsetHeight
            self.scrollView?.contentInset = edgeInset
        })
        
        refreshHandler?(self)
    }
        
    open override func changeToRefreshDate() {
        dateLabel.text = currentDateString()
    }
    
    open override func beginRefreshing() {
        if state == .loading {
            return
        }
        // 已经显示在window
        if let _ = self.window {
            adjustContentOffsetShowLoading()
            return
        }
        state = .willLoading
        self.setNeedsDisplay()
    }
    
    func adjustContentOffsetShowLoading() {
        UIView.animate(withDuration: 0.2, animations: {
            let contentOffset = CGPoint.init(x: self.scrollView?.contentOffset.x ?? 0, y: -self.hangingOffsetHeight - self.scrollViewEdgeInsets.top)
            self.scrollView?.contentOffset = contentOffset
        }) { (finished) in
            self.state = .loading
        }
    }
    
    public func currentDateString() -> String {
        let threadDict = Thread.current.threadDictionary
        guard let dateFormatter = threadDict.object(forKey: "FCXRefeshDateFormatterKey") as? DateFormatter else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "最后更新：今天 HH:mm"
            threadDict.setObject(dateFormatter, forKey: "FCXRefeshDateFormatterKey" as NSCopying)
            return dateFormatter .string(from: Date())
        }
        return dateFormatter .string(from: Date())
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        // 预防view还没显示出来就调用了beginRefreshing
        if self.state == .loading {
            adjustContentOffsetShowLoading()
        }
    }
}
