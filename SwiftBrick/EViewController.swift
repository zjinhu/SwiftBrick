//
//  EViewController.swift
//  SwiftBrick
//
//  Created by iOS on 2020/6/17.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
import Swift_Notification
class EViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton.snpButton(supView: view, backColor: .red, title: "Login", font: Font(12), titleNorColor: .white, titleHigColor: .lightGray, touchUp: { (btn) in
            
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

        
        let ive = UIImageView.snpImageView(supView: view, backColor: L.color("baseYellow"), contentMode: .scaleAspectFill, snapKitMaker:  { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
            make.width.equalTo(150)
            make.height.equalTo(150)
        })

        ive.image = L.image("ic_arrow_gray_right")
//            UIImage.createPlaceHolderImage(image: UIImage.init(named: "dongman"), imageView: ive)
        ive.clipsToBounds = true
        ive.layer.setCorners(15, corners: .bothTop)

        
        notifiCenter.addNotification(UIApplication.didChangeStatusBarFrameNotification) { (_) in
            print("\(BottomHomeHeight)---\(TabBarHeight)")
        }
        
        
        let la = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 30))
        la.backgroundColor = .black
        
        
        let av = UIView.snpView(supView: view, backColor: .orange, snapKitMaker:  { (make) in
            make.centerX.equalToSuperview().offset(-150)
            make.top.equalToSuperview().offset(260)
            make.width.equalTo(150)
            make.height.equalTo(150)
        })
        
        av.addSubview(la)
        
        let bv = UIView.snpView(supView: view, backColor: .orange, snapKitMaker:  { (make) in
            make.centerX.equalToSuperview().offset(150)
            make.top.equalToSuperview().offset(260)
            make.width.equalTo(150)
            make.height.equalTo(150)
        })
        
         bv.addSubview(la)
        
        let line = UILineView()
        line.lineColor = .baseLine
        line.isDash = true
        line.dashPointWidth = 2
        line.isHorizontal = false
        view.addSubview(line)
        line.snp.makeConstraints { (make) in

            make.top.equalToSuperview().offset(500)
            make.left.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        let lineView = UILineView(horizontal: true, width: 10, color: .orange)
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in

            make.top.equalToSuperview().offset(500)
            make.right.equalToSuperview()
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
