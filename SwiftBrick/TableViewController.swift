//
//  TestViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

class TableViewController: JHTableViewController {

    override func configTableViewStyleType() {
        self.tableViewStyleType = .StyleGrouped
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///是否需要展示导航栏，方便实用
        self.prefersNavigationBarHidden = true
        // Do any additional setup after loading the view.
//        self.configRightBarButtonWithImage(normalImage: JHImageLoader.loadToolsImage(with: "ic_arrow_gray_right")!, highLightImage: JHImageLoader.loadToolsImage(with: "ic_arrow_gray_right")!)
        self.configRightBarButtonWithText(text: "123", normalColor: .darkGray, highlightColor: .lightGray)
        
        self.mainDatas = [["","","","","","","","",""],["","","","","","","","",""]]
        
        JHTableViewHeaderFooterView.registerHeaderFooterView(tableView: self.tableView!)
    }
    

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = JHTableViewHeaderFooterView.dequeueReusableHeaderFooterView(tableView: tableView) as! JHTableViewHeaderFooterView
        view.backColor = .red
        return view
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = JHTableViewHeaderFooterView.dequeueReusableHeaderFooterView(tableView: tableView) as! JHTableViewHeaderFooterView
        view.backColor = .yellow
        return view
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = JHTableViewCell.dequeueReusableCell(tableView: tableView)
        var str : String?
        if indexPath.row % 2 == 0 {
            str = "隐藏导航栏的VC"
        } else {
            str = "显示导航栏的VC"
        }
        cell.textLabel?.text = String.init(describing: indexPath.row) + (str ?? "")
    cell.backgroundColor = .random
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row % 2 == 0 {
            let vc = TableViewController.init(tableViewStyle: .StyleGrouped)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = CollectionViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        }


    }
}
