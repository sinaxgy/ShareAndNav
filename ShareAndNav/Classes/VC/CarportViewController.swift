//
//  CarportViewController.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/5.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class CarportViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,CarportSharesCellDelegate{
    
    private var tableView:UITableView!
    private var carportArray:NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initTableView()
    }
    
    func initTableView() {
        self.view.backgroundColor = XuColorGrayThin
        
        self.navigationItem.title = "车位"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds,style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        tableView.sectionFooterHeight = 0
        
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layer.borderWidth = 10
        tableView.layer.cornerRadius = 15
        tableView.layer.borderColor = XuColorGrayThin.CGColor
        tableView.backgroundColor = XuColorGrayThin
        tableView.separatorColor = XuColorGrayThin
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let path = NSBundle.mainBundle().pathForResource("Carport", ofType: ".plist")
        for ele in NSArray(contentsOfFile: path!)! {
            self.carportArray.addObject(Carport(dict: ele as! NSDictionary))
        }
    }
    
    //MARK: --UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.carportArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: tableView.rectForHeaderInSection(section))
        view.backgroundColor = XuColorGrayThin
        let label = UILabel(frame: CGRectMake(15, 10, 200, 15))
        label.text = "车位\(section + 1)"
        label.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        view.addSubview(label)
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.carportArray.count - 1 {
            return 30
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == self.carportArray.count - 1 else {return nil}
        let view = UIView(frame: tableView.rectForFooterInSection(section))
        view.backgroundColor = XuColorGrayThin
        let ruleButton = UIButton(type: UIButtonType.System);let str:NSString = "《车位分享规则》"
        ruleButton.setTitle(str as String, forState: UIControlState.Normal)
        ruleButton.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        ruleButton.setTitleColor(XuColorBlueThin, forState: UIControlState.Normal)
        ruleButton.addTarget(self, action: "showAcProtocol:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(ruleButton)
        ruleButton.frame = CGRectMake(5, 10, XuTextSizeMiddle * CGFloat(str.length), 20)
        
        let button = UIButton(type: UIButtonType.System)
        button.frame = CGRectMake(XuWidth - 70, 10, 60, 20)
        button.setTitle("添加车位", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        button.setTitleColor(XuColorBlueThin, forState: UIControlState.Normal)
        button.addTarget(self, action: "addCarlincense:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        let addBtn = UIButton(type: UIButtonType.System)
        addBtn.frame = CGRectMake(CGRectGetMinX(button.frame) - 25, 13, 25, 15)
        addBtn.setImage(UIImage(named: "add"), forState: UIControlState.Normal)
        addBtn.addTarget(self, action: "addCarlincense:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(addBtn)
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 2 {
            guard let carport = self.carportArray[indexPath.section] as? Carport else {return 0}
            return (CGFloat(carport.shares!.count) + 1) * XuCellHeight
        }
        return XuCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let carport = self.carportArray[indexPath.section] as? Carport else {return UITableViewCell()}
        
        switch indexPath.row {
        case 0:
            var cell = tableView.dequeueReusableCellWithIdentifier("cell0") as? UniversalTableViewCell
            if cell == nil {
                cell = UniversalTableViewCell(universalStyle: UniversalCellStyle.RightButton, reuseIdentifier: "cell0")
            }
            let title:NSMutableString = NSMutableString(string: carport.title!)
            if carport.isrent {
                title.appendString("（租赁\(carport.payway!)）")
                cell?.rightButtonTitle = "续费"
            }
            cell?.leftLabelText = title as String
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell?.backgroundColor = XuColorGrayThin
            return cell!
        case 1:
            var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as? UniversalTableViewCell
            if cell == nil {
                cell = UniversalTableViewCell(universalStyle: UniversalCellStyle.RightLabel, reuseIdentifier: "cell1")
            }
            cell?.leftLabelText = "车位收益"
            cell?.rightLabelText = carport.revenue
            cell?.backgroundColor = XuColorGrayThin
            return cell!
        case 2:
            var cell = tableView.dequeueReusableCellWithIdentifier("cell2") as? CarportTableViewCell
            if cell == nil {
                cell = CarportTableViewCell(reuseIdentifier: "cell2")
                cell?.delegate = self
            }
            cell?.shares = carport.shares!
            cell?.backgroundColor = XuColorGrayThin
            return cell!
        default:return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let layer = CAShapeLayer();let cornerRadius:CGFloat = 5
        let pathRef = CGPathCreateMutable()
        let bounds = CGRectInset(cell.bounds, 10, 0)
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1 {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius)
        }else if indexPath.row == 0 {   //起点1--2--3，--3--4，终点4
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds))
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius)
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius)
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds))
        }else if indexPath.row == tableView.numberOfRowsInSection(indexPath.section) - 1 {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds))
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius)
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius)
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds))
        }else {
            CGPathAddRect(pathRef, nil, bounds)
        }
        layer.path = pathRef
        layer.fillColor = XuColorWhite.CGColor
        let lineLayer = CALayer()
        let lineHeight = 1 / UIScreen.mainScreen().scale
        lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height - lineHeight, bounds.size.width, lineHeight)
        lineLayer.backgroundColor = tableView.separatorColor?.CGColor
        layer.addSublayer(lineLayer)
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, atIndex: 0)
        testView.backgroundColor = UIColor.clearColor()
        cell.backgroundView = testView
    }
    
    //MARK:--CarportSharesCellDelegate
    func CarportButtonClicked(cell: UITableViewCell) {
        let indexPath = tableView.indexPathForCell(cell)
        print(indexPath?.row)
    }
    
    func CarportSwitchChanged(cell: UITableViewCell, boolValue: Bool,index:Int) {
        let indexPath = tableView.indexPathForCell(cell)
        print("switch>>>>>>>>index:\(index)")
        print(indexPath?.section)
        print(boolValue)
        
    }
    
    //MARK: --ControllerAction
    func showMessageView(sender:UIBarButtonItem) {
        let messageVC = MessageViewController()
        self.navigationController?.pushViewController(messageVC, animated: true)
        
    }
    
    func showAcProtocol(sender:UIButton) {
        self.navigationController?.pushViewController(AcProtocolViewController(), animated: true)
    }
    
    func addCarlincense(sender:UIButton) {
        let newLincenseVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewLicensePlateViewController")
        self.navigationController?.pushViewController(newLincenseVC, animated: true)
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
