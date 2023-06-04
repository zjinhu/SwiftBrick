//
//  UITableViewCellEX.swift
//  SwiftBrick
//
//  Created by iOS on 2020/5/20.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import Foundation
import UIKit
// MARK: ===================================扩展: UITableViewCell添加分割线=========================================
let TopLineTag         = 19003
let BottomLineTag      = 19004
///UITableView 自定义下划线

public extension SwiftBrickWrapper where Wrapped: UITableViewCell {
    /// 添加分割线，系统原生样式
    /// - Parameters:
    ///   - tableView: tableView
    ///   - indexPath: indexPath
    ///   - leftMarign: 左间距
    ///   - rightMarign: 右间距
    ///   - isHeadFootMarign: 是否首尾分割线也需要间距
    ///   - lineColor: 选中颜色
    func addAllLine(tableView: UITableView,
                     indexPath: IndexPath,
                     leftMarign: CGFloat = 0,
                     rightMarign: CGFloat = 0,
                     isHeadFootMarign: Bool = false,
                     lineColor: UIColor = .clear){
        var headFootLeftMarign: CGFloat = 0
        var headFootRightMarign: CGFloat = 0
        
        if isHeadFootMarign {
            headFootLeftMarign = leftMarign
            headFootRightMarign = rightMarign
        }
        
        var color: UIColor = .baseLine
        if lineColor != .clear{
            color = lineColor
        }
        
        guard let count = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: indexPath.section), count > 0 else {
            return
        }
        
        var topLineView  = wrapped.viewWithTag(TopLineTag)
        
        if topLineView == nil {
            topLineView = UIView()
            topLineView?.backgroundColor = color
            topLineView?.tag = TopLineTag
            topLineView?.translatesAutoresizingMaskIntoConstraints = false

            if let topLineView = topLineView{
                wrapped.addSubview(topLineView)
                wrapped.bringSubviewToFront(topLineView)
                let constraints = [
                    topLineView.topAnchor.constraint(equalTo: wrapped.topAnchor),
                    topLineView.leftAnchor.constraint(equalTo: wrapped.leftAnchor, constant: headFootLeftMarign),
                    topLineView.heightAnchor.constraint(equalToConstant: Define.lineHeight),
                    topLineView.rightAnchor.constraint(equalTo: wrapped.rightAnchor, constant: -headFootRightMarign)
                ]
                NSLayoutConstraint.activate(constraints)
            }
        }
        
        if indexPath.row == 0 {
            topLineView?.isHidden = false
        }else{
            topLineView?.isHidden = true
        }
        
        var bottomLineView  = wrapped.viewWithTag(BottomLineTag)
 
        if bottomLineView == nil {
            bottomLineView = UIView()
            bottomLineView?.backgroundColor = color
            bottomLineView?.tag = BottomLineTag
            bottomLineView?.translatesAutoresizingMaskIntoConstraints = false

            if let bottomLineView = bottomLineView{
                wrapped.addSubview(bottomLineView)
                wrapped.bringSubviewToFront(bottomLineView)
 
                bottomLineView.bottomAnchor.constraint(equalTo: wrapped.bottomAnchor).isActive = true
                bottomLineView.heightAnchor.constraint(equalToConstant: Define.lineHeight).isActive = true
                bottomLineView.leftAnchor.constraint(equalTo: wrapped.leftAnchor, constant: leftMarign).isActive = true
                bottomLineView.rightAnchor.constraint(equalTo: wrapped.rightAnchor, constant: -leftMarign).isActive = true
            }
        }

        if indexPath.row == count - 1{
            bottomLineView?.leftAnchor.constraint(equalTo: wrapped.leftAnchor, constant: headFootLeftMarign).isActive = true
            bottomLineView?.rightAnchor.constraint(equalTo: wrapped.rightAnchor, constant: -headFootRightMarign).isActive = true
        }else{
            bottomLineView?.leftAnchor.constraint(equalTo: wrapped.leftAnchor, constant: leftMarign).isActive = true
            bottomLineView?.rightAnchor.constraint(equalTo: wrapped.rightAnchor, constant: -leftMarign).isActive = true
        }
    }

    /// 添加中间分割线，首位没有线
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - leftMarign: 左间距
    ///   - rightMarign: 右间距
    func addMiddleLine(indexPath: IndexPath,
                     leftMarign: CGFloat = 0,
                     rightMarign: CGFloat = 0,
                     lineColor: UIColor = .clear){
        
        var color: UIColor = .baseLine
        if lineColor != .clear{
            color = lineColor
        }
        
        var lineView  = wrapped.viewWithTag(TopLineTag)
        
        if lineView == nil {
            lineView = UIView()
            lineView?.backgroundColor = color
            lineView?.tag = TopLineTag
            wrapped.addSubview(lineView!)
            wrapped.bringSubviewToFront(lineView!)
 
            if let lineView = lineView{
                wrapped.addSubview(lineView)
                wrapped.bringSubviewToFront(lineView)
                let constraints = [
                    lineView.topAnchor.constraint(equalTo: wrapped.topAnchor),
                    lineView.leftAnchor.constraint(equalTo: wrapped.leftAnchor, constant: leftMarign),
                    lineView.heightAnchor.constraint(equalToConstant: Define.lineHeight),
                    lineView.rightAnchor.constraint(equalTo: wrapped.rightAnchor, constant: -rightMarign)
                ]
                NSLayoutConstraint.activate(constraints)
            }
        }
        
        if indexPath.row == 0 {
            lineView?.isHidden = true
        }else{
            lineView?.isHidden = false
        }
    }
    
    /// 添加底部分割线
    /// - Parameters:
    ///   - leftMarign: 左侧间距
    ///   - rightMarign: 右间距
    ///   - lineColor: 选中颜色，默认为灰色线
    func addDownLine(leftMarign: CGFloat = 0,
                     rightMarign: CGFloat = 0,
                     lineColor: UIColor = .clear){
        
        var color: UIColor = .baseLine
        if lineColor != .clear{
            color = lineColor
        }
        
        var lineView  = wrapped.viewWithTag(BottomLineTag)
        
        if lineView == nil {
            lineView = UIView()
            lineView?.backgroundColor = color
            lineView?.tag = BottomLineTag
 
            if let lineView = lineView{
                wrapped.addSubview(lineView)
                wrapped.bringSubviewToFront(lineView)
                let constraints = [
                    lineView.bottomAnchor.constraint(equalTo: wrapped.bottomAnchor),
                    lineView.leftAnchor.constraint(equalTo: wrapped.leftAnchor, constant: leftMarign),
                    lineView.heightAnchor.constraint(equalToConstant: Define.lineHeight),
                    lineView.rightAnchor.constraint(equalTo: wrapped.rightAnchor, constant: -rightMarign)
                ]
                NSLayoutConstraint.activate(constraints)
            }

        }

    }

}
