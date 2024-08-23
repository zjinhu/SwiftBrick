//
//  ViewController.swift
//  SwiftBrick
//
//  Created by iOS on 2023/5/11.
//

import UIKit
import SwiftBrick
class DemoViewController: ViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()

        modifyNavBar()
        getDefineValue()
        customUserDefaults()
//        useDispatch()
        
        let row1 = UIButton()
        row1.titleForNormal = "跳转Tableview无导航栏"
        row1.backgroundColor = .blue
        view.addSubview(row1)
        row1.addTouchUpInSideBtnAction { [weak self](row) in
            guard let `self` = self else {return}
            let vc = DemoTableViewController.init(tableViewStyle: .styleGrouped)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let row2 = UIButton()
        row2.titleForNormal = "跳转CollectionView有导航栏"
        row2.backgroundColor = .blue
        view.addSubview(row2)
        row2.addTouchUpInSideBtnAction { [weak self](row) in
            guard let `self` = self else {return}
            let vc = DemoCollectionViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let row3 = UIButton()
        row3.titleForNormal = "跳转WebView"
        row3.backgroundColor = .blue
        view.addSubview(row3)
        row3.addTouchUpInSideBtnAction { [weak self](row) in
            guard let `self` = self else {return}
            let vc = DemoWebViewController()//.init(urlString: "https://www.baidu.com")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
 
        let row4 = UIButton()
        row4.titleForNormal = "测试小功能"
        row4.backgroundColor = .blue
        view.addSubview(row4)
        row4.addTouchUpInSideBtnAction { [weak self](row) in
            guard let `self` = self else {return}
            let vc = DemoExViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        row1.ss.makeConstraints { (make) in
            make.centerXAnchor(equalTo: view.ss.centerXAnchor)
            make.topAnchor(equalTo: view.ss.topAnchor).offset(100)
            make.widthAnchor(200)
            make.heightAnchor(greaterThanOrEqualTo: 50)
        }
        
        row2.ss.makeConstraints { (make) in
            make.centerXAnchor(equalTo: view.ss.centerXAnchor)
            make.topAnchor(equalTo: row1.ss.bottomAnchor).offset(10)
            make.widthAnchor(200)
            make.heightAnchor(greaterThanOrEqualTo: 50)
        }
        
        row3.ss.makeConstraints { (make) in
            make.centerXAnchor(equalTo: view.ss.centerXAnchor)
            make.topAnchor(equalTo: row2.ss.bottomAnchor).offset(10)
            make.widthAnchor(200)
            make.heightAnchor(greaterThanOrEqualTo: 50)
        }
        
        row4.ss.makeConstraints { (make) in
            make.centerXAnchor(equalTo: view.ss.centerXAnchor)
            make.topAnchor(equalTo: row3.ss.bottomAnchor).offset(10)
            make.widthAnchor(200)
            make.heightAnchor(greaterThanOrEqualTo: 50)
        }
    }

    
    func modifyNavBar(){
        self.title = "SwiftBrick示例"
        navigationController?.navigationBar.ss.setBackgroundColor(.init("567800"))
        navigationController?.navigationBar.ss.setLineHidden(hidden: true)
    }
    
    func getDefineValue(){
        let a = Define.bottomHomeHeight
        let b = Define.statusBarHeight()
        Define.sLog("\(b)--\(a)")
        
        if Device.isiPad{
            print("1")
        }else{
            print("2")
        }
        
        print("\(AppState.state)")
    }
    
    func useDispatch(){
        print("11111111\(Thread.current)")
        Dispatch.global().after(5) {
            print("\(Thread.current) 耗时任务1")
            print("2222222222")
            Dispatch.main().after(5){
                print("\(Thread.current) 耗时任务2")
                print("333333333333")
            }
        }
        Dispatch.background().run {
            print("\(Thread.current) 耗时任务3")
            print("4444444444444444")
        }
    }
    
    func customUserDefaults(){
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
