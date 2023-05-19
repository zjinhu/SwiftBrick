//
//  WebViewController.swift
//  SwiftBrick
//
//  Created by iOS on 20/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import SnapKit
import Swift_Form
import SwiftBrick
class DemoWebViewController: WebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUserAgent = "hahah"
        loadingProgressColor = "#567800"
        request = URLRequest.init(url: URL.init(string: "https://www.baidu.com")!)
//        request?.httpMethod = "POST"
//        request?.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        let body = "nickname=123&openid=234"
//        request?.httpBody = body.data(using: .utf8)
        loadRequest()

    }

}
