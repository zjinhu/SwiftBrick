//
//  ViewController.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .cyan
        SLog(SCREEN_HEIGHT)
        // Do any additional setup after loading the view.
        SLog(StatusBarHeight())

        let imageView = UIImageView.init(image: JHImageLoader.loadToolsImage(with: "nav_ic_back"))
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        let btn = UIButton.init()
        btn.setTitle("123", for: .normal)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        btn.addTarget(self, action: #selector(jupm), for: .touchUpInside)
    }

    @objc func jupm(){
        if #available(iOS 13.0, *) {
            let vc = TestViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }
        
    }
}

