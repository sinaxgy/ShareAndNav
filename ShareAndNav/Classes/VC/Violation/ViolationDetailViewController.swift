//
//  ViolationDetailViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/20.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class ViolationDetailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    private var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initTableView()
    }
    
    func initTableView() {
        self.view.backgroundColor = XuColorGrayThin
        
        self.navigationItem.title = "违章"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
        
        tableView = UITableView(frame: CGRectMake(0, 0, XuWidth, XuHeight + 10),style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        XuSetup(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: --UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        XutableView(tableView, willDisplayCell: cell, forRowIndexPath: indexPath)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
