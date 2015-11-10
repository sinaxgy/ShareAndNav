//
//  CarViewController.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/4.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class CarViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,CarTableViewCellDelegate{
    
    private var tableView:UITableView!
    var carOwnershipArray:NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initTableView()
    }
    
    func initTableView() {
        self.view.backgroundColor = XuColorGrayThin
        
        self.navigationItem.title = "车辆"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
        
        tableView = UITableView(frame: CGRectMake(0, 0, XuWidth, XuHeight),style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        
        tableView.layer.borderWidth = 10
        tableView.layer.cornerRadius = 15
        tableView.layer.borderColor = XuColorGrayThin.CGColor
        tableView.backgroundColor = XuColorGrayThin
        tableView.separatorColor = XuColorGrayThin
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        //解析car数据
        let path = NSBundle.mainBundle().pathForResource("CarInfomation", ofType: ".plist")
        for ar in NSArray(contentsOfFile: path!)! {
            let array:NSMutableArray = []
            if let element = ar as? NSArray {
                for value in element {
                    if let dic = value as? NSDictionary {
                        array.addObject(CarOwnership(dic: dic))
                    }
                }
            }
            self.carOwnershipArray.addObject(array)
        }
    }
    
    //MARK: --UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return carOwnershipArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = carOwnershipArray[section] as? NSArray else {return 0}
        return array.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = self.tableView(self.tableView, cellForRowAtIndexPath: indexPath)
        return cell.frame.height
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == 1 else {return 0}
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeaderInSection(section))
        view.backgroundColor = XuColorGrayThin
        let label = UILabel(frame: CGRectMake(15, 10, 200, 15))
        label.text = (section == 0 ? "车主车辆" : "其他车辆")
        label.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        view.addSubview(label)
        return view
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForFooterInSection(section))
        let button = UIButton(type: UIButtonType.System)
        button.frame = CGRectMake(XuWidth - 85, 15, 60, 20)
        button.setTitle("添加车辆", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        button.setTitleColor(XuColorBlueThin, forState: UIControlState.Normal)
        view.addSubview(button)
        
        let addBtn = UIButton(type: UIButtonType.System)
        addBtn.frame = CGRectMake(CGRectGetMinX(button.frame) - 35, 18, 25, 15)
        addBtn.setImage(UIImage(named: "add"), forState: UIControlState.Normal)
        view.addSubview(addBtn)
        
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("carCell") as? CarTableViewCell
        if cell == nil {
            cell = CarTableViewCell(reuseIdentifier: "carCell")
        }
        cell!.backgroundColor = XuColorGrayThin
        let array = carOwnershipArray[indexPath.section] as! NSArray
        if let xco = array[indexPath.row] as? CarOwnership {
            cell?.setupWithCarOwnership(xco)
        }
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.delegate = self
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let layer = CAShapeLayer();var addLine = true;let cornerRadius:CGFloat = 8
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
        layer.fillColor = XuColorWhite.CGColor
        if addLine {
            let lineLayer = CALayer()
            let lineHeight = 1 / UIScreen.mainScreen().scale
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height - lineHeight, bounds.size.width - 10, lineHeight)
            lineLayer.backgroundColor = tableView.separatorColor?.CGColor
            layer.addSublayer(lineLayer)
        }
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, atIndex: 0)
        testView.backgroundColor = UIColor.clearColor()
        cell.backgroundView = testView
    }
    
    //MARK: --CarTableViewCellDelegate
    func payAuthorizeSwitch(cell: UITableViewCell, bool: Bool) {
        let indexPath = self.tableView.indexPathForCell(cell)
        let array = self.carOwnershipArray[(indexPath?.section)!] as! NSArray
        if let xc = array.objectAtIndex(indexPath!.row) as? CarOwnership {
            xc.isAuthorize = bool
        }
        
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
