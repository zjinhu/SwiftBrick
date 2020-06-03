//
//  JHImageLoader.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

public class L{
    static var bundle: Bundle? = {
        let path = Bundle(for: L.self).path(forResource: "SwiftBrick", ofType: "bundle", inDirectory: nil)
        let bundle = Bundle(path: path ?? "")
        return bundle
    }()
    
    public static func image(_ named: String) -> UIImage? {
        var image = UIImage(named: named, in: bundle, compatibleWith: nil)
        if image == nil {
            image = UIImage(named: named)
        }
        return image
    }
    
    public static func color(_ named: String) -> UIColor? {
        var color = UIColor(named: named, in: bundle, compatibleWith: nil)
        if color == nil {
            color = UIColor.init(named: named)
        }
        return color
    }
}
