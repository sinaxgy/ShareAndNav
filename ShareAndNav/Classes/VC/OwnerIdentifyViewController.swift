//
//  OwnerIdentifyViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/16.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class OwnerIdentifyViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    private var tableView:UITableView!
    
    let array = ["车牌号码","车辆类型","使用性质","注册日期","发证日期","发动机号码","品牌型号","车辆识别代号","所有人","住址"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XuColorWhite
        tableView = UITableView(frame: CGRectMake(0, 0, XuWidth, XuHeight + 10),style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        XuSetup(tableView)
        tableView.sectionHeaderHeight = 20
        tableView.dataSource = self
        tableView.delegate = self
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.tableView(self.tableView, cellForRowAtIndexPath: indexPath)
        return cell.frame.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UniversalTableViewCell
        if cell == nil {
            cell = UniversalTableViewCell(universalStyle: UniversalCellStyle.TextField, reuseIdentifier: "cell")
        }
        cell?.textPlaceholder = array[indexPath.row]
        if indexPath.row == 2 || indexPath == 3 {
            cell?.textInputType = XuTextFieldInputType.Date
        }
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
