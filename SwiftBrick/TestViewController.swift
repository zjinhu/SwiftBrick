//
//  EViewController.swift
//  SwiftBrick
//
//  Created by iOS on 2020/6/17.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    let then = UIView().then { (v) in
        v.backgroundColor = .red
        v.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let bb = ShadowsButton()
        bb.setTitle("123", for: .normal)
        bb.shadowActive = true
        bb.shadowNormalOffsetX = 6
        bb.shadowNormalOffsetY = 6
        bb.cornerRadius = 25
        bb.backColor = .orange
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
        ive.clipsToBounds = true
        ive.layer.setCorners(15, corners: .bothTop)


        
        let line = UILineView()
        line.lineColor = .red
        line.isDash = true
        line.dashPointWidth = 2
        line.isHorizontal = false
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(10)
        }
        
        
        let lineView = UILineView(horizontal: true, width: 1, color: .orange)
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(300)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(then)
        then.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(350)
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        
        let test1Button = UIButton()
        test1Button.titleForNormal = "背景色Normal"
        test1Button.titleForDisabled = "背景色Disabled"
        test1Button.titleForSelected = "背景色Selected"
        test1Button.titleForHighlighted = "背景色Highlighted"
        test1Button.titleColorForNormal = .black
        test1Button.titleColorForSelected = .red
        test1Button.titleColorForDisabled = .yellow
        test1Button.titleColorForHighlighted = .purple
        test1Button.layer.cornerRadius = 5
        test1Button.backgroundColor = .gray
        test1Button.isSelected = true
        view.addSubview(test1Button)
        test1Button.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(650)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        test1Button.addTouchUpInSideBtnAction { sender in
            print("\(sender.isSelected)")
        }
        
        
        let bView = RectTextView(frame: .init(x: 40, y: 650, width: 100, height: 100))
        view.addSubview(bView)


        
    }
 
}
