//
//  UIImageViewEx.swift
//  SwiftBrick
//
//  Created by iOS on 2023/5/24.
//

import UIKit

public extension SwiftBrickWrapper where Base: UIImageView {
    /// 生成占位图
    /// - Parameters:
    ///   - image: 小图
    ///   - imageView: 图片视图
    /// - Returns: 图片
    func createPlaceHolder(image: UIImage?) -> UIImage?{
        base.layoutIfNeeded()
        guard let image = image else {
            return nil
        }
        let name = image.ss.sha256
        let imageName = "placeHolder_\(base.bounds.size.width)_\(base.bounds.size.height)_\(name).png"
        let fileManager = FileManager.default
        let path: String = NSHomeDirectory() + "/Documents/PlaceHolder/"
        let filePath = path + imageName
        if fileManager.fileExists(atPath: filePath) {
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
            else { return nil }
            let image = UIImage(data: data)
            return image
        }
        
        UIGraphicsBeginImageContext(base.bounds.size)
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.setFillColor(UIColor.clear.cgColor)
            ctx.fill(CGRect(origin: CGPoint.zero, size: base.bounds.size))
            
            let placeholderRect = CGRect(x: (base.bounds.size.width - image.size.width) / 2.0,
                                         y: (base.bounds.size.height - image.size.height) / 2.0,
                                         width: image.size.width,
                                         height: image.size.height)
            
            ctx.saveGState()
            ctx.translateBy(x: placeholderRect.origin.x, y: placeholderRect.origin.y)
            ctx.translateBy(x: 0, y: placeholderRect.size.height)
            ctx.scaleBy(x: 1.0, y: -1.0)
            ctx.translateBy(x: -placeholderRect.origin.x, y: -placeholderRect.origin.y)
            ctx.draw(image.cgImage!, in: placeholderRect, byTiling: false)
            ctx.restoreGState()
        }
        
        if let placeHolder = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            try? fileManager.createDirectory(at: URL(fileURLWithPath: path), withIntermediateDirectories: true, attributes: nil)
            fileManager.createFile(atPath: filePath, contents: placeHolder.pngData(), attributes: nil)
            return placeHolder
        }
        UIGraphicsEndImageContext()
        return nil
    }
    
}
