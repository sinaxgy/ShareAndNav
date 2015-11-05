//
//  ViolationViewController.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/5.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class ViolationViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
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
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds,style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        tableView.sectionFooterHeight = 0
        
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layer.borderWidth = 10
        tableView.layer.cornerRadius = 15
        tableView.layer.borderColor = XuColorGrayThin.CGColor
        tableView.backgroundColor = XuColorGrayThin
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    //MARK: --UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 4
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = XuColorGrayThin
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "京A B1212"
        cell.backgroundColor = XuColorGrayThin
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        let layer = CAShapeLayer();var addLine = false;let cornerRadius:CGFloat = 5
        let pathRef = CGPathCreateMutable()
        let bounds = CGRectInset(cell.bounds, 10, 0)
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1 {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius)
        }else if indexPath.row == 0 {   //起点1--2--3，--3--4，终点4
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds))
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius)
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius)
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))
            //addLine = true
        }else if indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1 {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds))
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius)
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius)
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds))
        }else {
            CGPathAddRect(pathRef, nil, bounds);addLine = true
        }
        layer.path = pathRef
        layer.fillColor = UIColor.whiteColor().CGColor
        if addLine {
            let lineLayer = CALayer()
            let lineHeight = 1 / UIScreen.mainScreen().scale
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds) + 10, bounds.size.height - lineHeight, bounds.size.width - 10, lineHeight)
            lineLayer.backgroundColor = tableView.separatorColor?.CGColor
            layer.addSublayer(lineLayer)
        }
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, atIndex: 0)
        testView.backgroundColor = UIColor.clearColor()
        cell.backgroundView = testView
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
