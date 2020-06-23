//
//  EViewController.swift
//  SwiftBrick
//
//  Created by iOS on 2020/6/17.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit

class EViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton.snpButton(supView: view, backColor: .clear, title: "Login", font: font_14, titleNorColor: .white, titleHigColor: .lightGray, touchUp: { (btn) in
            
        }) { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(screen_width-60)
            make.height.equalTo(50)
            }
//        // Do any additional setup after loading the view.
//        btn.layer.setShadow(x: 0, y: 10, radius: 6)
//        btn.layer.setBorder(color: .red, width: 1, corner: 10)

        
        btn.active = true 
        btn.shadowDarkOffsetX = 6
        btn.shadowDarkOffsetY = 6
        btn.shadowLightOffsetX = -6
        btn.shadowLightOffsetY = -6
        btn.cornerRadius = 25
        btn.darkShadowColor = .black
        btn.backColor = .orange
//        btn.selectedBackColor = .red
//        btn.isToggle = true
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
