//
//  ExViewController.swift
//  SwiftBrick
//
//  Created by iOS on 20/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
class ExViewController: JHViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var mainArray = ["示例UIView1","示例UIView2","示例UIView3-可点击","示例UIImageView-可点击","示例UIImageView","示例Button"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "示例UITableView"
        
        let tableView = UITableView.snpTableView(supView: self.view,
                                                 snapKitMaker: { (make) in
                                                    make.edges.equalToSuperview()
        },
                                                 style: .plain,
                                                 delegate: self,
                                                 dataSource: self,
                                                 backColor: .white)
        
        JHTableViewCell.registerCell(tableView: tableView)
        
    }
    // MARK:-示例快速创建UIView 使用部分默认参数 --初始化使用SnapKit
    func demoView1(supView: UIView){
        UIView.snpView(supView: supView,
                       snapKitMaker: { (make) in
                        make.top.equalTo(supView).offset(10)
                        make.centerX.equalTo(supView)
                        make.width.equalTo(80)
                        make.height.equalTo(40)
        },
                       backColor: .red)
        
    }
    // MARK:-示例快速创建UIView 使用部分默认参数--初始化不使用SnapKit
    func demoView2(supView: UIView){
        let vi = UIView.snpView(backColor: .cyan)
        supView.addSubview(vi)
        vi.snp.makeConstraints { (make) in
            make.top.equalTo(supView).offset(10)
            make.centerX.equalTo(supView)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
    }
    // MARK:-示例快速创建UIView 使用全部参数--有单击操作
    func demoView3(supView: UIView){
        UIView.snpView(supView: supView,
                       snapKitMaker: { (make) in
                        make.top.equalTo(supView).offset(20)
                        make.centerX.equalTo(supView)
                        make.width.equalTo(80)
                        make.height.equalTo(40)
        },
                       snpTapGesture: { (view) in
                        SLog("点击UIView")
        },
                       backColor: .orange)
    }
    // MARK:-示例快速创建UIimageView
    func demoImageView1(supView: UIView){
        UIImageView.snpImageView(supView: supView,
                                 snapKitMaker: { (make) in
                                    make.top.equalTo(supView).offset(30)
                                    make.centerX.equalTo(supView)
                                    make.width.equalTo(80)
                                    make.height.equalTo(40)
        },
                                 snpTapGesture: { (imageView) in
                                    SLog("点击图片")
        },
                                 backColor: .purple)
    }
    
    func demoImageView2(supView: UIView){
        UIImageView.snpImageView(supView: supView,
                                 image: UIImage.init(named: "share_haoyou_btn"),
                                 isClip: true,
                                 snapKitMaker: { (make) in
                                    make.top.equalTo(supView).offset(30)
                                    make.centerX.equalTo(supView)
                                    make.width.equalTo(80)
                                    make.height.equalTo(40)
        },
                                 backColor: .clear)
    }
    // MARK:-示例快速创建按钮
    func demoButton(supView: UIView){
        let btn = UIButton.snpButton(supView: supView, title: "buttonbuttonbuttonbuttonbutton", snapKitMaker: { (make) in
            make.top.equalTo(supView).offset(40)
            make.centerX.equalTo(supView)
        }, touchUp: { (btn) in
            SLog("点击Button")
        }, backColor: .orange)
        btn.setImage(UIImage.init(named: "share_haoyou_btn"), for: .normal)
        btn.layoutButton(.imagePositionRight, space: 10)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JHTableViewCell.dequeueReusableCell(tableView: tableView)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        cell.textLabel?.text = mainArray[indexPath.row]
        switch indexPath.row {
        case 0:
            self.demoView1(supView: cell.contentView)
        case 1:
            self.demoView2(supView: cell.contentView)
        case 2:
            self.demoView3(supView: cell.contentView)
        case 3:
            self.demoImageView1(supView: cell.contentView)
        case 4:
            self.demoImageView2(supView: cell.contentView)
        case 5:
            self.demoButton(supView: cell.contentView)
            
        default:
            print("")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    deinit{
        SLog("释放")
    }
}
