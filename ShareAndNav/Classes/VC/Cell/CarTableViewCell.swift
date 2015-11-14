
//
//  CarTableViewCell.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/6.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

@objc protocol CarTableViewCellDelegate {
    func payAuthorizeSwitch(cell:UITableViewCell,bool:Bool)
}

class CarTableViewCell: UITableViewCell ,UITableViewDataSource,UITableViewDelegate,CarTableViewCellDelegate{
    
    var delegate:CarTableViewCellDelegate?
    var leftImageV:UIImageView?
    var leftLabel:UILabel?
    var certificateBtn:UIButton?
    var rightLabel:UILabel?
    var rSwtch:UISwitch?
    var subTableView:UITableView?
    var xCarOwnership:CarOwnership?
    
    private var centerY:CGFloat = 0
    
    
    //MARK:--function
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
    }
    
    func setupWithCarOwnership(xcarO:CarOwnership) {
        if xcarO.assistPhones == nil {
            self.frame.size.height = XuCellHeight
            self.centerY = XuCellHeight / 2
            self.initBaseView()
            self.setupViewData(xcarO)
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }else {
            self.frame.size.height = XuCellHeight * (1 + CGFloat(xcarO.assistPhones!.count))
            self.xCarOwnership = xcarO
            self.initTableView()
        }
    }
    
    func initTableView() {
        subTableView = UITableView(frame: CGRectMake(0, 0, XuWidth, self.frame.height), style: UITableViewStyle.Plain)
        subTableView?.backgroundColor = UIColor.clearColor()//XuColorGrayThin
        subTableView?.scrollEnabled = false
        subTableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        subTableView?.dataSource = self
        subTableView?.delegate = self
        self.contentView.addSubview(subTableView!)
    }
    
    func initBaseView() {
        leftImageV = UIImageView(frame: CGRectMake(15, centerY - 15, 30, 30))
        self.contentView.addSubview(leftImageV!)
        
        leftLabel = UILabel(frame: CGRectMake(50, centerY - 10, 70, 20))
        leftLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        contentView.addSubview(leftLabel!)
        
        rSwtch = UISwitch(frame: CGRectZero)
        rSwtch?.addTarget(self, action: "swithAuthorize:", forControlEvents: UIControlEvents.ValueChanged)
        rSwtch?.transform = CGAffineTransformMakeScale(0.7, 0.7)
        rSwtch?.center = CGPointMake(XuWidth - 45, centerY)
        contentView.addSubview(rSwtch!)
        
        rightLabel = UILabel(frame: CGRectMake(CGRectGetMinX(rSwtch!.frame) - 50, centerY - 10, 60, 20))
        rightLabel?.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        rightLabel?.textColor = XuColorGray
        contentView.addSubview(rightLabel!)
    }
    
    func setupViewData(xcarOwnership:CarOwnership) {
        let image = UIImage(named: xcarOwnership.brand!)
        leftImageV?.image = image
        
        leftLabel?.text = xcarOwnership.plate!
        
        rightLabel?.text = "在线支付"
        
        rSwtch?.on = xcarOwnership.isAuthorize!
        
        guard xcarOwnership.isCerificate != nil else {return}
        
        if !xcarOwnership.isCerificate! {
            let button = UIButton(type: UIButtonType.Custom)
            button.frame = CGRectMake(CGRectGetMaxX((leftLabel?.frame)!) , centerY - 10, 60, 20)
            button.setTitle("车主未认证", forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeSmall)
            button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            contentView.addSubview(button)
            button.addTarget(self, action: "carOwnerCerificate:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    //MARK:--CarTableViewCellDelegate
    func payAuthorizeSwitch(cell: UITableViewCell, bool: Bool) {
        guard self.delegate != nil else {return}
        self.delegate?.payAuthorizeSwitch(self, bool: bool)
    }
    
    //MARK:--ControllerAction
    func carOwnerCerificate(sender:UIButton) {
        print("cerificate")
    }
    
    func swithAuthorize(sender:UISwitch) {
        guard self.delegate != nil else {return}
        self.delegate?.payAuthorizeSwitch(self, bool: sender.on)
        //(self.superCell == nil ? self : self.superCell!)
    }
    
    //MRAK: --UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.xCarOwnership?.assistPhones?.count)! + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return XuCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = CarTableViewCell(reuseIdentifier: "subCarCell")
            let xcos = CarOwnership(xco: self.xCarOwnership!)
            xcos.assistPhones = nil
            cell.delegate = self
            cell.setupWithCarOwnership(xcos)
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 110, 300)
            cell.backgroundColor = UIColor.clearColor()
            return cell
        }else {
            var cell = tableView.dequeueReusableCellWithIdentifier("textCell")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "textCell")
            }
            let text = self.xCarOwnership?.assistPhones?.objectAtIndex(indexPath.row - 1)
            let label = UILabel(frame: CGRectMake(55, 15, XuWidth - 60, 20))
            cell?.contentView.addSubview(label)
            label.text = "账户\(text!)为您的车辆开启在线支付功能"
            label.font = UIFont.systemFontOfSize(XuTextSizeSmallest)
            label.textColor = XuColorGray
            cell?.backgroundColor = UIColor.clearColor()
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let layer = CAShapeLayer()
        let bounds = CGRectInset(cell.bounds, 10, 0)
        layer.fillColor = UIColor.clearColor().CGColor
        let lineLayer = CALayer()
        let lineHeight = 1 / UIScreen.mainScreen().scale
        lineLayer.frame = CGRectMake(CGRectGetMinX(bounds) + 45, bounds.size.height - lineHeight, 135, lineHeight)
        lineLayer.backgroundColor = XuColorGrayThin.CGColor
        layer.addSublayer(lineLayer)
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, atIndex: 0)
        testView.backgroundColor = UIColor.clearColor()
        cell.backgroundView = testView
        cell.separatorInset = UIEdgeInsetsMake(50, 0, 50, 0)
    }
    
    //MARK: --OTHERS
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