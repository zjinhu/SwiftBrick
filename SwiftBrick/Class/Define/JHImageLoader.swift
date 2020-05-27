//
//  JHImageLoader.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

public class JHImageLoader{
    static var bundle: Bundle? = {
        let path = Bundle.init(for: JHImageLoader.self).path(forResource: "SwiftBrick", ofType: "bundle", inDirectory: nil)
        let bundle = Bundle.init(path: path ?? "")
        return bundle
    }()
    
    public static func loadToolsImage(with name: String) -> UIImage? {
        var image = UIImage.init(named: name, in: bundle, compatibleWith: nil)
        if image == nil {
            image = UIImage(named: name)
        }
        return image
    }
}
