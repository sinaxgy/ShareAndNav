//
//  ArrayTableViewCell.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/20.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

@objc protocol ArrayTableViewCellDelegate {
    optional func arrayTableViewCellLocation(row:Int)
    optional func arrayTableViewCellSelected(row:Int)
}

class ArrayTableViewCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource{
    
    private var tableView:UITableView!
    var delegate:ArrayTableViewCellDelegate?
    var dataArray:NSArray? {
        didSet{
            guard dataArray != nil else {return}
            tableView.frame.size.height = 50 * CGFloat(dataArray!.count)
            tableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        tableView = UITableView(frame: CGRectMake(0, 0, XuWidth, 0))
        tableView.separatorColor = XuColorGrayThin
        self.addSubview(tableView)
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.delegate = self
        tableView.rowHeight = 50
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataArray != nil else {return 0}
        return dataArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? ViolationTableViewCell
        if cell == nil {
            cell = ViolationTableViewCell(reuseIdentifier: "cell")
            cell?.backgroundColor = UIColor.clearColor()
        }
        cell?.separatorInset = UIEdgeInsetsMake(0, 100, 0, 0)
        cell?.xviolation = dataArray![indexPath.row] as? Violation
        cell?.locationClosure = { () in
            self.delegate?.arrayTableViewCellLocation?(indexPath.row)
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.delegate?.arrayTableViewCellSelected?(indexPath.row)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
