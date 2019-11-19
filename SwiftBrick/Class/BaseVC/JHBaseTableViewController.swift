//
//  JHBaseTableViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 18/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit
import SnapKit
import SwifterSwift
class JHBaseTableViewController: JHBaseViewController ,UITableViewDelegate,UITableViewDataSource{

    public enum TableViewType {
        case TableViewStylePlain
        case TableViewStyleGrouped
        @available(iOS 13.0, *)
        case TableViewStyleInsetGrouped
    }
    
    var tableView : UITableView?
    var mainDatas : Array<Any> = []
    var tableViewType : TableViewType = .TableViewStylePlain
    /**
     *  不延时响应按钮的点击事件  默认延时
     */
    var delaysContentTouches : Bool = true
    
    /**
     *  初始化UITableView前设置Style,默认Plain
     */
    func configTableViewStyle() {
        //        self.tableViewType = .TableViewStyleGrouped
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableViewStyle()
        
        switch self.tableViewType {
        case .TableViewStyleInsetGrouped:
            if #available(iOS 13.0, *) {
                self.tableView = UITableView.init(frame: .zero, style: .insetGrouped)
            }else{
                self.tableView = UITableView.init(frame: .zero, style: .grouped)
            }
            break
            
        case .TableViewStyleGrouped:
            self.tableView = UITableView.init(frame: .zero, style: .grouped)
            break
            
        default:
            self.tableView = UITableView.init(frame: .zero, style: .plain)
            break
            
        }

        self.tableView?.backgroundColor = .clear
        self.tableView?.delegate = self
        self.tableView?.dataSource = self

        self.tableView?.separatorStyle = .none
//        self.tableView?.separatorColor = .lightGray
        self.tableView?.showsVerticalScrollIndicator = false
        self.tableView?.showsHorizontalScrollIndicator = false
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        self.tableView?.estimatedSectionFooterHeight = CGFloat.leastNormalMagnitude
            //头角需要自适应高度的话请设置
        //    self.tableView.estimatedSectionHeaderHeight = 200;
        //    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        //    self.tableView.estimatedSectionFooterHeight = 200;
        //    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
        self.tableView?.delaysContentTouches = self.delaysContentTouches
        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableView!)

        self.tableView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.safeAreaInsets.top );
            make.left.equalTo(self.view.safeAreaInsets.left);
            make.right.equalTo(self.view.safeAreaInsets.right);
            make.bottom.equalTo(self.view.safeAreaInsets.bottom);
        })
        
        self.tableView?.contentInsetAdjustmentBehavior = .automatic

        let gestureArray : [UIGestureRecognizer] = (self.navigationController?.view.gestureRecognizers)!
        for gesture in gestureArray {
            if gesture.isEqual(UIScreenEdgePanGestureRecognizer.self) {
                self.tableView?.panGestureRecognizer.require(toFail: gesture)
            }
        }
        
        JHBaseTableViewCell.registerCell(tableView: self.tableView!)
        
    }
     // MARK: - tableView代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainDatas.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JHBaseTableViewCell.dequeueReusableCell(tableView: tableView)
        cell.backgroundColor = Color.random
        return cell
     }
}
