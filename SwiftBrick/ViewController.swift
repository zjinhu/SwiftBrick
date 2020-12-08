//
//  ViewController.swift
//  SwiftBrick
//
//  Created by iOS on 19/11/2019.
//  Copyright © 2019 狄烨 . All rights reserved.
//

import UIKit
import SnapKit

class ViewController: JHTableViewController {


    override func viewDidLoad() {
 
        super.viewDidLoad()
//        self.title = "SwiftBrick示例"
        self.mainDatas = ["跳转Tableview","跳转CollectionView","跳转WebView","跳转EXView","跳转DataSource"]
        
        navigationController?.navigationBar.setBackgroundColor(.baseTeal)
        navigationController?.navigationBar.setLineHidden(hidden: true)
        
        if IsIPAD{
            print("1")
        }else{
            print("2")
        }
        
        print("\(AppState.state)")
        
        print("username修改前\(UserDefaultsConfig.username)")
        UserDefaultsConfig.username = nil
        print("username修改后\(UserDefaultsConfig.username)")
        
        print("nickname修改前\(UserDefaultsConfig.nickname)")
        UserDefaultsConfig.nickname = nil
        print("nickname修改后\(UserDefaultsConfig.nickname)")
        
        print("test修改前\(UserDefaultsSu.test)")
        UserDefaultsSu.test = nil
        DispatchQueue.main.asyncAfter(delay: 2) {
            print("test修改后\(UserDefaultsSu.test)")
        }
        NotificationCenter.default.add(name: "123") { (noti) in
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(JHTableViewCell.self)
        cell.textLabel?.text = self.mainDatas[indexPath.row] as? String
        cell.addDownLine()
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = TableViewController.init(tableViewStyle: .styleGrouped)
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = CollectionViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = WebViewController()//.init(urlString: "https://www.baidu.com")
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = ExViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            self.navigationController?.pushViewController(DataSourceViewController(), animated: true)
        default:
            print("")
        }
        
    }
    deinit{
        print("1释放")
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
