//
//  HistoryViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/12.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var records:NSArray!
    private var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XuColorWhite
        self.navigationItem.title = "历史记录"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
        
        //
        let path = NSBundle.mainBundle().pathForResource("ParkingRecord", ofType: ".plist")
        for ele in NSArray(contentsOfFile: path!)! {
            print(ele)
        }
        self.records = NSArray(contentsOfFile: path!)
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds,style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        XuSetup(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: --UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.records.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? RecordTableViewCell
        if cell == nil {
            cell = RecordTableViewCell(reuseIdentifier: "cell")
        }
        cell?.setupData(records[indexPath.section] as! NSDictionary)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        XutableView(tableView, willDisplayCell: cell, forRowIndexPath: indexPath)
    }
    
    //MARK: --ControllerAction
    func showMessageView(sender:UIBarButtonItem) {
        let messageVC = MessageViewController()
        self.navigationController?.pushViewController(messageVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}