//
//  UniversalTableViewCell.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/28.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

enum UniversalCellStyle {
    case RightText,Switch,LeftLogo,CarAuthorize
}

extension UILabel {
    func initView() {
        
    }
}

class UniversalTableViewCell: UITableViewCell {
    
    var leftImage:UIImageView?
    var leftLabel:UILabel?
    var rightLabel:UILabel?
    var rSwtch:UISwitch?
    var subTableView:UITableView?
    
    var rightButtonTitle:String? {
        didSet{
            let rightButton = UIButton(type: UIButtonType.Custom)
            rightButton.setTitle(rightButtonTitle, forState: UIControlState.Normal)
            rightButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            rightButton.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
            rightButton.backgroundColor = XuColorBlue
            let width = XuTextSizeMiddle * CGFloat(NSString(string: rightButtonTitle!).length)
            rightButton.frame = CGRectMake(0, 0, width, 20)
            rightButton.layer.cornerRadius = XuCornerRadius
            rightButton.center = CGPointMake(self.center.x - width / 2 - 10, self.center.y)
            self.addSubview(rightButton)
            
            
        }
    }
    
    init(universalStyle:UniversalCellStyle,reuseIdentifier:String) {
        switch universalStyle {
        case .CarAuthorize:
            super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
            //self.initViewWithCarOwnership(xcarOwnership)
            break
        default:
            super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
            break
        }
    }
    
    func setupWithCarOwnership(xcarO:CarOwnership) {
        self.initViewWithCarOwnership(xcarO)
    }
    
    func initBaseView() {
        
    }
    
    func initViewWithCarOwnership(xcarOwnership:CarOwnership) {
        self.imageView?.image = UIImage(named: xcarOwnership.brand!)
        self.textLabel?.text = xcarOwnership.plate!
        self.detailTextLabel?.text = "在线支付"
        detailTextLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        textLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        let xswith = UISwitch(frame: CGRectMake(self.contentView.frame.width - 35, self.contentView.center.y - 10, 20, 15))
        xswith.on = xcarOwnership.isAuthorize!
        xswith.addTarget(self, action: "swithAuthorize:", forControlEvents: UIControlEvents.ValueChanged)
        self.contentView.addSubview(xswith)
        detailTextLabel?.center = CGPointMake(CGRectGetMinX(xswith.frame) - 50, (detailTextLabel?.center.y)!)
        
        if xcarOwnership.isCerificate != nil {
            if !xcarOwnership.isCerificate! {
                let button = UIButton(type: UIButtonType.Custom)
                button.frame = CGRectMake(0, 0, 80, 16)
                button.setTitle("车主未认证", forState: UIControlState.Normal)
                button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
                button.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
                button.addTarget(self, action: "carOwnerCerificate:", forControlEvents: UIControlEvents.TouchUpInside)
                button.center = CGPointMake(CGRectGetMaxX((self.textLabel?.frame)!) + 50, self.center.y)
                self.contentView.addSubview(button)
            }
        }
    }
    
    //MARK:--ControllerAction
    func carOwnerCerificate(sender:UIButton) {
        print("cerificate")
    }
    
    func swithAuthorize(sender:UISwitch) {
        print("switch")
    }

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
