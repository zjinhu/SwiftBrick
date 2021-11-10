//
//  WebViewController.swift
//  SwiftBrick
//
//  Created by iOS on 20/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

class WebViewController: JHWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUserAgent = "hahah"
        loadingProgressColor = "#567800"
        request = URLRequest.init(url: URL.init(string: "https://support.qq.com/product/190629")!)
        request?.httpMethod = "POST"
        request?.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "nickname=123&openid=234"
        request?.httpBody = body.data(using: .utf8)
        loadRequest()

    }

}
