//
//  PayViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/12.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class PayViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var payWay:NSMutableArray = []
    private var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XuColorWhite
        self.navigationItem.title = "支付"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds,style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        XuSetup(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        payWay.addObject(NSMutableDictionary(dictionary: ["tag":"visa","account":"个人 *****5310","isCurrent":true]))
        payWay.addObject(NSMutableDictionary(dictionary: ["tag":"zhifubao","account":"187****1234","isCurrent":false]))
    }
    //MARK: --UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.payWay.count
        }
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCellWithIdentifier("payCell") as? UniversalTableViewCell
            if cell == nil {
                cell = UniversalTableViewCell(universalStyle: UniversalCellStyle.LeftILRightL, reuseIdentifier: "payCell")
            }
            guard let dic = payWay[indexPath.row] as? NSDictionary else {return cell!}
            cell?.setupLeft(UIImage(named: dic["tag"] as! String)!, andLabel: dic["account"] as! String)
            let isCurrent:Bool = dic["isCurrent"]!.boolValue
            cell?.rightLabelText = (isCurrent ? "√" : "")
            cell?.backgroundColor = UIColor.clearColor()
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let leftText = (section == 0 ? "支付绑定" : "钱包")
        let style = (section == 0 ? RightButtonStyle.textAndImage : RightButtonStyle.text)
        let bText = (section == 0 ? "添加支付方式" : "提 现")
        let view = HeaderView(frame: tableView.rectForHeaderInSection(section), leftText: leftText, rightButtonState: style, rightButtonText: bText)
        view.action = { (sender) in
            if section == 0 {
                self.navigationController?.pushViewController(NewPayViewController(), animated: true)
            }
        }
        return view
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 1 else {return nil}
        let view = UIView(frame: tableView.rectForFooterInSection(section))
        view.backgroundColor = XuColorGrayThin
        let leftButton = UIButton(type: UIButtonType.System)
        leftButton.setup("发 票", fontsize: XuTextSizeMiddle, fontColor: UIColor.whiteColor(), bkColor: XuColorBlue)
        leftButton.handleCOntrolEvent(UIControlEvents.TouchUpInside) { (_) -> Void in
            print("发票")
            self.navigationController?.pushViewController(ReceiptViewController(), animated: true)
        }
        leftButton.center = CGPointMake(15 + CGRectGetWidth(leftButton.frame) / 2, 20)
        view.addSubview(leftButton)
        
        let rightButton = UIButton(type: UIButtonType.System)
        rightButton.setup("支付明细", fontsize: XuTextSizeMiddle, fontColor: XuColorBlueThin, bkColor: XuColorGrayThin)
        rightButton.handleCOntrolEvent(UIControlEvents.TouchUpInside) { (_) -> Void in
            print("支付明细")
        }
        view.addSubview(rightButton)
        rightButton.center = CGPointMake(XuWidth - CGRectGetWidth(rightButton.frame) / 2 - 10, 20)
        return view
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        XutableView(tableView, willDisplayCell: cell, forRowIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.section == 0 {
            self.paywayChanged(indexPath.row)
            tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    //MARK: --ControllerAction
    func showMessageView(sender:UIBarButtonItem) {
        let messageVC = MessageViewController()
        self.navigationController?.pushViewController(messageVC, animated: true)
    }
    
    func paywayChanged(selectedIndex:Int) {
        for ele in payWay {
            let dic = ele as! NSMutableDictionary
            dic.setObject(selectedIndex == payWay.indexOfObject(ele), forKey: "isCurrent")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
