//
//  EViewController.swift
//  SwiftBrick
//
//  Created by iOS on 2020/6/17.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
import SwiftBrick
class DemoExViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ss.addRightBarButton(text: "Button",
                          normalColor: .darkGray,
                          highlightColor: .lightGray,
                          fixSpace: 0 ) {_ in
            
        }
        
        print("\(rightBarButton)") 
        
        view.backgroundColor = .white

        let line = UILineView()
        line.lineColor = .red
        line.isDash = true
        line.dashPointWidth = 2
        line.isHorizontal = false
        view.addSubview(line)
 
        line.ss.makeConstraints { (make) in
            make.leftAnchor(equalTo: view.ss.leftAnchor).offset(10)
            make.topAnchor(equalTo: view.ss.topAnchor)
            make.widthAnchor(10)
            make.heightAnchor(550)
        }
        
        
        let lineView = UILineView(horizontal: true, width: 1, color: .orange)
        view.addSubview(lineView)
 
        lineView.ss.makeConstraints { (make) in
            make.leftAnchor(equalTo: view.ss.leftAnchor)
            make.topAnchor(equalTo: view.ss.topAnchor).offset(470)
            make.heightAnchor(50)
            make.widthAnchor(350)
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
        test1Button.backgroundColor = .green
        test1Button.isSelected = true
        view.addSubview(test1Button)
        test1Button.ss.makeConstraints { (make) in
            make.rightAnchor(equalTo: view.ss.rightAnchor).offset(-10)
            make.topAnchor(equalTo: view.ss.topAnchor).offset(100)
            make.widthAnchor(lessThanOrEqualTo: 200)
            make.heightAnchor(greaterThanOrEqualTo: 100)
        }
        test1Button.addTouchUpInSideBtnAction { sender in
            print("\(sender.isSelected)")
        }
        
    }
    
}
