//
//  RefreshHeaderView.swift
//  SwiftBrick
//
//  Created by iOS on 2020/5/26.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
import SnapKit
public class RefreshHeaderView: RefreshView {
    
    public lazy var statusLabel : UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
        lab.textColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1)
        return lab
    }()
    
    public lazy var dateLabel : UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = .center
        lab.textColor = UIColor.init(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1)
        return lab
    }()
    
    lazy var arrowImageView : UIImageView = {
        let view = UIImageView.init(image: Loader.image("refresh_arrow"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let activityView = UIActivityIndicatorView.init(style: .gray)
    
    enum HeaderViewType {
        case showAll, hideData, hideStatusAndData
    }
    var headerType = HeaderViewType.showAll
    
    override public func addRefreshContentView() {
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switch headerType {
        case .hideData:
            statusLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            arrowImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(statusLabel.snp.left).offset(-5)
            }
        case .hideStatusAndData:
            arrowImageView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        default:
            statusLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(self.snp.centerY)
            }
            dateLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.snp.centerY)
            }
            arrowImageView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(dateLabel.snp.left).offset(-5)
            }
        }
        activityView.snp.makeConstraints { (make) in
            make.edges.equalTo(arrowImageView)
        }
    }
    
    public override func hideDateView() {
        dateLabel.isHidden = true
        headerType = .hideData
        setNeedsLayout()
    }
    
    public override func hideStatusAndDateView() {
        statusLabel.isHidden = true
        dateLabel.isHidden = true
        headerType = .hideStatusAndData
        setNeedsLayout()
    }

    public override func scrollViewContentOffsetDidChange(scrollView: UIScrollView) {
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
    
    public override func changeToStatusNormal() {
        statusLabel.text = normalText
        activityView.stopAnimating()
        arrowImageView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.arrowImageView.transform = .identity
            self.scrollView?.contentInset = self.scrollViewOriginalEdgeInsets
        })
    }
    
    public override func changeToStatusPulling() {
        statusLabel.text = pullingText
        UIView.animate(withDuration: 0.2, animations: {
            self.arrowImageView.transform = CGAffineTransform.init(rotationAngle: 0.000001 - .pi)
        })
    }
    
    public override func changeToStatusLoading() {
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
        
    public override func changeToRefreshDate() {
        dateLabel.text = currentDateString()
    }
    
    public override func beginRefreshing() {
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
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        // 预防view还没显示出来就调用了beginRefreshing
        if self.state == .loading {
            adjustContentOffsetShowLoading()
        }
    }
}
