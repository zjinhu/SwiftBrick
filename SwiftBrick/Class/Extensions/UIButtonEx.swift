//
//  UIButtonEx.swift
//  SwiftBrick
//
//  Created by iOS on 2020/1/15.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
public enum ImagePosition {
    case imagePositionLeft
    case imagePositionRight
    case imagePositionTop
    case imagePositionBottom
}
public extension UIButton{
    func layoutButton(_ postion: ImagePosition, space: CGFloat) {
        
        guard let titleL = self.titleLabel, let imageV = self.imageView else {
            return
        }
        
        self.setTitle(self.currentTitle, for: .normal)
        self.setImage(self.currentImage, for: .normal)
        
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
        
        guard
        let labelWidth = titleL.text?.size(withAttributes: [NSAttributedString.Key.font : titleL.font as UIFont]).width,
        let labelHeight = titleL.text?.size(withAttributes: [NSAttributedString.Key.font : titleL.font as UIFont]).height
        else {
            return
        }
        
        let imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2//image中心移动的x距离
        let imageOffsetY = imageHeight / 2 + space / 2//image中心移动的y距离
        let labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2//label中心移动的x距离
        let labelOffsetY = labelHeight / 2 + space / 2//label中心移动的y距离
        
        let tempWidth = max(labelWidth, imageWidth)
        let changedWidth = labelWidth + imageWidth - tempWidth
        let tempHeight = max(labelHeight, imageHeight);
        let changedHeight = labelHeight + imageHeight + space - tempHeight

        switch postion {
        case .imagePositionTop:
            self.imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX, bottom: -labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: -0.5 * changedWidth, bottom: changedHeight-imageOffsetY, right: -0.5 * changedWidth)
            
        case .imagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            self.titleEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX, bottom:labelOffsetY, right: labelOffsetX)
            self.contentEdgeInsets = UIEdgeInsets(top: changedHeight-imageOffsetY, left: -0.5 * changedWidth, bottom: imageOffsetY, right: -0.5 * changedWidth)
            
        case .imagePositionRight:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + 0.5 * space, bottom: 0, right: -(labelWidth + 0.5 * space))
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWidth + 0.5 * space), bottom: 0, right: imageWidth + space * 0.5)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.5 * space, bottom: 0, right: 0.5*space)
            
        default:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -0.5 * space, bottom: 0, right: 0.5 * space)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0.5 * space, bottom: 0, right: -0.5 * space)
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.5 * space, bottom: 0, right: 0.5 * space)
        }
    }
    
    func layoutButton(_ postion: ImagePosition, margin: CGFloat) {
        
        guard
        let imageWidth = self.imageView?.image?.size.width,
            let labelWidth = self.titleLabel?.text?.size(withAttributes: [NSAttributedString.Key.font : self.titleLabel?.font ?? UIFont.systemFont(ofSize: 13)]).width
        else {
            return
        }
        let space = self.bounds.size.width - imageWidth - labelWidth - 2 * margin
        layoutButton(postion, space: space)
    }
}
