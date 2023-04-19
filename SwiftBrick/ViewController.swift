//
//  ViewController.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import SnapKit
import Swift_Form
//import Combine
class ViewController: JHTableViewController {

    lazy var former = Former(tableView: self.tableView!)
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        self.title = "SwiftBrick示例"
        navigationController?.navigationBar.setBackgroundColor(.init("567800"))
        navigationController?.navigationBar.setLineHidden(hidden: true)
 
        let a = bottomHomeHeight
        let b = statusBarHeight()
        sLog("\(b)--\(a)")
        
        if isiPad{
            print("1")
        }else{
            print("2")
        }
//        
//        print("11111111\(Thread.current)")
//        Dispatch.global().after(5) {
//            print("\(Thread.current) 耗时任务1")
//            print("2222222222")
//            Dispatch.main().after(5){
//                print("\(Thread.current) 耗时任务2")
//                print("333333333333")
//            }
//        }
//        Dispatch.background().run {
//            print("\(Thread.current) 耗时任务3")
//            print("4444444444444444")
//        }

        
        print("\(AppState.state)")
        
        print("username修改前\(String(describing: UserDefaultsConfig.username))")
        UserDefaultsConfig.username = nil
        print("username修改后\(String(describing: UserDefaultsConfig.username))")
        
        print("nickname修改前\(String(describing: UserDefaultsConfig.nickname))")
        UserDefaultsConfig.nickname = nil
        print("nickname修改后\(String(describing: UserDefaultsConfig.nickname))")
        
        print("test修改前\(String(describing: UserDefaultsSu.test))")
        UserDefaultsSu.test = nil
        DispatchQueue.main.asyncAfter(delay: 2) {
            print("test修改后\(String(describing: UserDefaultsSu.test))")
        }

        let row1 = LabelRow()
        row1.title = "跳转Tableview"
        row1.subTitle = "无导航栏"
        row1.cell.accessoryType = .disclosureIndicator
        row1.cell.addDownLine()
        row1.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            let vc = TableViewController.init(tableViewStyle: .styleGrouped)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let row2 = LabelRow()
        row2.title = "跳转CollectionView"
        row2.subTitle = "有导航栏"
        row2.cell.accessoryType = .disclosureIndicator
        row2.cell.addDownLine()
        row2.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            let vc = CollectionViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let row3 = LabelRow()
        row3.title = "跳转WebView"
        row3.cell.accessoryType = .disclosureIndicator
        row3.cell.addDownLine()
        row3.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            let vc = WebViewController()//.init(urlString: "https://www.baidu.com")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let row4 = LabelRow()
        row4.title = "跳转EXView"
        row4.subTitle = "工厂方法"
        row4.cell.accessoryType = .disclosureIndicator
        row4.cell.addDownLine()
        row4.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            let vc = ExViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let row5 = LabelRow()
        row5.title = "测试小功能"
        row5.cell.accessoryType = .disclosureIndicator
        row5.cell.addDownLine()
        row5.onSelected { [weak self](row) in
            guard let `self` = self else {return}
            let vc = TestViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        let section = SectionFormer(row1, row2, row3, row4, row5)
        
        former.append(sectionFormer: section)
    }
    
}

struct UserDefaultsConfig {
    @UserDefault("username")
    static var username: String?
    
    @UserDefault("kkkk", defaultValue: "123")
    static var nickname: String!
}

struct UserDefaultsSu {
    @UserDefaultSuite("app", key: "test")
    static var test: String?
}
