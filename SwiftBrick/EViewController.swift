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
        let btn = UIButton.snpButton(supView: view, backColor: .red, title: "Login", font: font_14, titleNorColor: .white, titleHigColor: .lightGray, touchUp: { (btn) in
            
        }) { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
            }
//        // Do any additional setup after loading the view.
//        btn.layer.setShadow(x: 0, y: 10, radius: 6)
//        btn.layer.setBorder(color: .red, width: 1, corner: 10)
        btn.layer.cornerRadius = 15
        
        
        let bb = ShadowsButton()
        bb.setTitle("123", for: .normal)
        bb.shadowActive = true
        bb.shadowNormalOffsetX = 6
        bb.shadowNormalOffsetY = 6
        //        btn.shadowHighlightedOffsetX = -6
        //        btn.shadowHighlightedOffsetY = -6
        bb.cornerRadius = 25
        //        btn.shadowNormalColor = .black
        //        btn.shadowHighlightedShadowColor = .red
        bb.backColor = .orange
        //        btn.selectedBackColor = .red
        //        btn.isToggle = true
        view.addSubview(bb)
        bb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
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
