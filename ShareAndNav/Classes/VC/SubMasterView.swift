//
//  SubMasterView.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/2.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class SubMasterView: UIView ,UITableViewDataSource,UITableViewDelegate{
    
    var tableView:UITableView!
    let section0 = ["支付":"绑定 京A B1212 在线支付 开","历史记录":""]
    let section1 = ["车辆":"京A B1212 车主未认证","车位":"车位分享 开","违章":"未处理 1"]
    let section2 = ["优惠":"3张","推荐有奖":"停车享优惠"]
    let section3 = ["设置":""]
    var tableArray : NSMutableArray = []//section0,section1,section2,section3]
    
    init() {
        super.init(frame: UIScreen.mainScreen().bounds)//CGRectMake(0, 0, XuWidth * 2 / 3, UIScreen.mainScreen().bounds.size.height))
        self.backgroundColor = UIColor(red: 24/255, green: 30/255, blue: 36/255, alpha: 1)
        self.alpha = 0.9
        self.tableArray.addObject(section0)
        self.tableArray.addObject(section1)
        self.tableArray.addObject(section2)
        self.tableArray.addObject(section3)
        self.initTableView()
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRectMake(XuWidth / 3, 0, XuWidth * 2 / 3, 464), style: UITableViewStyle.Plain)
        tableView.backgroundColor = UIColor(red: 24/255, green: 30/255, blue: 36/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.separatorColor = XuColorBlue
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.scrollEnabled = false
        //tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 64
        }
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {
            let view = UIView(frame: CGRectMake(0, 0, XuWidth, 1))
            view.backgroundColor = XuColorBlue
            return view
        }
        let view = UIView(frame: CGRectMake(0, 0, XuWidth, 64))
        let imageView = UIImageView(frame: CGRectMake(14, 18, 50, 50))
        imageView.image = UIImage(named: "logo")
        view.addSubview(imageView)
        let label = UILabel(frame: CGRectMake(70, 18, 180, 20))
        label.text = "爱车人 | 车主"
        label.font = UIFont.systemFontOfSize(XutextSizeBig)
        view.addSubview(label)
        label.textColor = UIColor.whiteColor()
        
        let label1 = UILabel(frame: CGRectMake(70, 39, 180, 20))
        label1.text = "187****1234"
        label1.textColor = UIColor.whiteColor()
        label1.font = UIFont.systemFontOfSize(XutextSizeBig)
        view.addSubview(label1)
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = self.tableArray[section] as! NSDictionary
        return dic.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "subMasterCell")
        }
        cell?.imageView?.image = UIImage(named: "fute")
        let dic = self.tableArray[indexPath.section] as! NSDictionary
        let keys:NSArray = dic.allKeys
        cell?.textLabel?.text = keys[indexPath.row] as? String
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.textLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        cell?.detailTextLabel?.text = dic.objectForKey(String(keys[indexPath.row])) as? String
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(XuTextSizeSmallest)
        cell?.backgroundColor = UIColor.clearColor()
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
