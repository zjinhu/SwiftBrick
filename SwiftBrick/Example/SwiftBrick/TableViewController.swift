//
//  TestViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit
import SnapKit
import Swift_Form
import SwiftBrick
class TableViewController: JHTableViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return setStyleStatusBar
    }
    
    override var prefersStatusBarHidden: Bool {
        return setHiddenStatusBar
    }
    
    override func setupTableViewStyleType() {
        tableViewStyleType = .styleGrouped
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///是否需要展示导航栏，方便实用,用于解决有无导航栏页面滑动切换导航栏显示问题
        prefersNavigationBarHidden = true

        mainDatas = [["","","","","","","","",""],["","","","","","","","",""]]
        
        tableView?.registerHeaderFooterView(JHTableViewHeaderFooterView.self)

    }
    

//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 100
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(JHTableViewHeaderFooterView.self)
//        view?.backColor = .red
//        return view
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(JHTableViewHeaderFooterView.self)
//        view?.backColor = .yellow
//        return view
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(JHTableViewCell.self)

        cell.addAllLine(tableView: tableView, indexPath: indexPath, leftMarign: 20, rightMarign: 0, isHeadFootMarign: false, lineColor: .red)
        
        var str: String?
        
        if indexPath.row % 2 == 0 {
            str = "隐藏导航栏的VC"
        } else {
            str = "显示导航栏的VC"
        }
        cell.textLabel?.text = String.init(describing: indexPath.row) + (str ?? "")

       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row % 2 == 0 {
            let vc = TableViewController.init(tableViewStyle: .styleGrouped)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = CollectionViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < 100 {
            changeStatusBarStyle(style: .lightContent)
        }else{
            changeStatusBarStyle(style: .default)
        }
        
        if offset < 200 {
            hideOrShowStatusBar(hidden: false)
        }else{
            hideOrShowStatusBar(hidden: true)
        }
    }
}
