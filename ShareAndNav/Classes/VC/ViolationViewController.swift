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
    var violationArray:NSMutableArray = []
    
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
        tableView.rowHeight = 50
        
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layer.borderWidth = 10
        tableView.layer.cornerRadius = 15
        tableView.layer.borderColor = XuColorGrayThin.CGColor
        tableView.backgroundColor = XuColorGrayThin
        tableView.separatorColor = XuColorGrayThin
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let path = NSBundle.mainBundle().pathForResource("Violations", ofType: ".plist")
        for elem in NSArray(contentsOfFile: path!)! {
            if let dic = elem as? NSDictionary {
                self.violationArray.addObject(ViolationObject(dic: dic))
            }
        }
    }
    
    //MARK: --UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.violationArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let violation = violationArray[section] as? ViolationObject {
            guard violation.info != nil else {return 2}
            return 3
        }
        return 0
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
        guard let vio = self.violationArray[indexPath.section] as? ViolationObject else {return UITableViewCell()}
        var cell = tableView.dequeueReusableCellWithIdentifier("rbCell") as? UniversalTableViewCell
        if cell == nil {
            cell = UniversalTableViewCell(universalStyle: UniversalCellStyle.RightButton, reuseIdentifier: "rbCell")
        }
        switch indexPath.row {
        case 0:
            cell?.leftLabelText = vio.plate
            if vio.info != nil {
                cell?.rightButtonTitle = "违章处理"
            }
        case 1:
            cell?.leftLabelText = "未处理 \(vio.times!) 扣分 \(vio.points!) 罚款 \(vio.forfeit!)"
        case 2:
            break
        default:break
        }
        cell!.backgroundColor = XuColorGrayThin
        return cell!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
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
        layer.fillColor = XuColorWhite.CGColor
        if addLine {
            let lineLayer = CALayer()
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height - 1, bounds.size.width , 1)
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
