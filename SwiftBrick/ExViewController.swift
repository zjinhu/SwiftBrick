//
//  ExViewController.swift
//  SwiftBrick
//
//  Created by iOS on 20/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

class ExViewController: JHViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = UIView.snpView(supView: self.view, snapKitMaker: { (make) in
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }, backColor: .red)
        
        let vi = UIView.snpView(backColor: .cyan)
        self.view.addSubview(vi)
        vi.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(160)
            make.centerX.equalTo(self.view)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
//        // Do any additional setup after loading the view.
        let _ = UIView.snpView(supView: self.view,
                               snapKitMaker: { (make) in
                                make.top.equalTo(self.view).offset(260)
                                make.centerX.equalTo(self.view)
                                make.width.equalTo(80)
                                make.height.equalTo(40)
                                },
                               snpTapGesture: { (view) in
                                SLog("123")
                                },
                               backColor: .orange)
        
        let _  = UIImageView.snpImageView(supView: self.view,
                                       snapKitMaker: { (make) in
                                           make.top.equalTo(self.view).offset(360)
                                           make.centerX.equalTo(self.view)
                                           make.width.equalTo(80)
                                           make.height.equalTo(40)
        },
                                       snpTapGesture: { (imageView) in
                                        SLog("点击图片")
        },
                                       backColor: .purple)
        
        let _ = UIButton.snpButton(supView: self.view, title: "button", snapKitMaker: { (make) in
            make.top.equalTo(self.view).offset(460)
            make.centerX.equalTo(self.view)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }, touchUp: { (btn) in
            SLog("点击Button")
        }, backColor: .orange)
        
    }

    deinit{
        SLog("2释放")
    }
}
