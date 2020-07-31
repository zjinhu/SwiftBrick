//
//  DataSourceViewController.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/31.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit

struct Section: Hashable {
    var title : String
}

struct Item: Hashable {
    var name : String
}

class DataSourceViewController: JHTableViewController {

    lazy var dataSource = TableViewDataSource<Section, Item>(tableView!, cellGetter: { (tableView, indexPath, model) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(JHTableViewCell.self)
        cell.textLabel?.text = model.name
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addRightBarButton(text: "123", normalColor: .darkGray, highlightColor: .lightGray)
        rightBarButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        dataSource.sections = [(section: Section(title: "1"), items: [Item(name: "1"),
                                                                      Item(name: "2"),
                                                                      Item(name: "3"),
                                                                      Item(name: "4")]),
                               (section: Section(title: "2"), items: [Item(name: "5"),
                                                                      Item(name: "6"),
                                                                      Item(name: "7"),
                                                                      Item(name: "8")]),
                               (section: Section(title: "3"), items: [Item(name: "9"),
                                                                      Item(name: "10"),
                                                                      Item(name: "11"),
                                                                      Item(name: "12")])]
        // Do any additional setup after loading the view.

    }
    
    @objc func add(){
        dataSource.sections.append((section: Section(title: "4"), items: [Item(name: "13"),
                                                                          Item(name: "14"),
                                                                          Item(name: "15"),
                                                                          Item(name: "16")]))
        tableView?.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
