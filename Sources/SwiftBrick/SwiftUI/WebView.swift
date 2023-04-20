//
//  WebView.swift
//  SwiftBrick
//
//  Created by iOS on 2023/4/20.
//  Copyright © 2023 狄烨 . All rights reserved.
//

import SwiftUI

struct WebView: UIViewControllerRepresentable {
    let urlString: String

    func makeUIViewController(context: Context) -> JHWebViewController {
        let webviewController = JHWebViewController()
        return webviewController
    }

    func updateUIViewController(_ webviewController: JHWebViewController, context: Context){
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        DispatchQueue.main.async {
            webviewController.webView.load(request)
        }
    }
}
