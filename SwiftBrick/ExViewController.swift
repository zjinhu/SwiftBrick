//
//  ExViewController.swift
//  SwiftBrick
//
//  Created by iOS on 20/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit

class ExViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.init().hand.adhere(toSuperView: self.view)
            .hand.layout { (make) in
                make.top.equalTo(self.view).offset(100)
                make.centerX.equalTo(self.view)
                make.width.equalTo(80)
                make.height.equalTo(40)
        }.hand.config { (view) in
            view.backgroundColor = .orange
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
