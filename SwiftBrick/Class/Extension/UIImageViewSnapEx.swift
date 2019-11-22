//
//  UIImageViewSnapEx.swift
//  SwiftBrick
//
//  Created by iOS on 22/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

public extension UIImageView {

    internal class func snpImageView(
        
        supView : UIView? = nil,
        image : UIImage? = nil,
        isClip : Bool = false,
        contentMode : UIView.ContentMode  = .scaleAspectFill,
        snapKitMaker : JHSnapKitTool.JHSnapMaker? = nil,
        snpTapGesture : JHSnapKitTool.JHTapGestureBlock? = nil,
        backColor: UIColor) -> UIImageView{
        
        let imageView = UIImageView.init()
        imageView.backgroundColor = backColor
        
        imageView.clipsToBounds = isClip
        imageView.contentMode = contentMode
        
        imageView.image = image
        
        if supView != nil{
            supView?.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                snapKitMaker!(make)
            }
        }
        
        if snpTapGesture != nil {
            imageView.snpAddTapGestureWithCallback(snpTapGesture: snpTapGesture)
        }
        
        return imageView
    }
    
}
