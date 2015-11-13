//
//  SettingViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/13.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    private var tableView:UITableView!
    
    let tbArray = [["修改密码","清理缓存"],["交易消息提醒","活动推送提醒"],["帮助","意见反馈","好评打赏","法律条款","关于我们"],["退出登录"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XuColorWhite
        self.navigationItem.title = "设置"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds,style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        XuSetup(tableView)
        tableView.sectionHeaderHeight = 20
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: --UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tbArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = tbArray[section] as NSArray
        return array.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0,2:
            var cell = tableView.dequeueReusableCellWithIdentifier("tCell") as? UniversalTableViewCell
            if cell == nil {
                cell = UniversalTableViewCell(universalStyle: UniversalCellStyle.RightLabel, reuseIdentifier: "tCell")
                cell?.backgroundColor = UIColor.clearColor()
                cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
            cell?.leftLabelText = tbArray[indexPath.section][indexPath.row]
            return cell!
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("sCell") as? UniversalTableViewCell
            if cell == nil {
                cell = UniversalTableViewCell(universalStyle: UniversalCellStyle.RightSwitch, reuseIdentifier: "sCell")
                cell?.backgroundColor = UIColor.clearColor()
            }
            cell?.leftLabelText = tbArray[indexPath.section][indexPath.row]
            cell?.rSwitchState = false
            return cell!
        case 3:
            let cell = UITableViewCell(frame: tableView.rectForRowAtIndexPath(indexPath))
            let label = UILabel(frame: tableView.rectForRowAtIndexPath(indexPath))
            let text = tbArray[indexPath.section][indexPath.row]
            label.text = text as String
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
            cell.addSubview(label)
            cell.backgroundColor = UIColor.clearColor()
            return cell
        default:return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        XutableView(tableView, willDisplayCell: cell, forRowIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
