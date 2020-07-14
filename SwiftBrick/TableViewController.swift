//
//  TestViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit
//import SwiftyRefresh
class TableViewController: JHTableViewController {

    override var prefersStatusBarHidden: Bool {
        return self.setHiddenStatusBar
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return self.setStyleStatusBar
    }
    
    override func setupTableViewStyleType() {
        self.tableViewStyleType = .styleGrouped
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///是否需要展示导航栏，方便实用
        prefersNavigationBarHidden = true
        // Do any additional setup after loading the view.
//        self.configRightBarButtonWithImage(normalImage: JHImageLoader.loadToolsImage(with: "ic_arrow_gray_right")!, highLightImage: JHImageLoader.loadToolsImage(with: "ic_arrow_gray_right")!)

        
        mainDatas = [["","","","","","","","",""],["","","","","","","","",""]]
        
        tableView?.registerHeaderFooterView(JHTableViewHeaderFooterView.self)
        
//        tableView?.refresh.addRefreshHeader(handler: { (header) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                header.endRefreshing()
//            }
//        })
//        tableView?.refresh.addRefreshAutoFooter(handler: { (footer) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                footer.showNoMoreData()
//            }
//        })
    }
    

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(JHTableViewHeaderFooterView.self)
        view?.backColor = .red
        return view
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(JHTableViewHeaderFooterView.self)
        view?.backColor = .yellow
        return view
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(JHTableViewCell.self)
//        cell.addDownLine(tableView: tableView, indexPath: indexPath, leftMarign: 30)
//        cell.addMiddleLine(tableView: tableView, indexPath: indexPath, leftMarign: 30)
        cell.addAllLine(tableView: tableView, indexPath: indexPath, leftMarign: 20, rightMarign: 0, isHeadFootMarign: false, lineColor: .red)
        var str : String?
        if indexPath.row % 2 == 0 {
            str = "隐藏导航栏的VC"
        } else {
            str = "显示导航栏的VC"
        }
        cell.textLabel?.text = String.init(describing: indexPath.row) + (str ?? "")
//    cell.backgroundColor = .random
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
    @available(iOS 13.0, *)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset < 100 {
            self.changeStatusBarStyle(style: .darkContent)
        }else{
            self.changeStatusBarStyle(style: .default)
        }
    }
}
