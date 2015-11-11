//
//  CarportTableViewCell.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/10.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class CarportTableViewCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource{
    
    var tableView:UITableView!
    var groupArray:NSArray = []
    
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
    }
    
    func initTableView() {
        print("self.frame.height:\(self.frame.height)")
        tableView = UITableView(frame: CGRectMake(0, 0, XuWidth, self.frame.height), style: UITableViewStyle.Plain)
        tableView?.backgroundColor = UIColor.clearColor()//XuColorGrayThin
        tableView?.scrollEnabled = false
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView?.dataSource = self
        tableView?.delegate = self
        self.contentView.addSubview(tableView!)
    }
    
    //MARK: --UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupArray.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //MARK: --OUTHERS
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
