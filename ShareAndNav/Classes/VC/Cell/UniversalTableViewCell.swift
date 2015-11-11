//
//  UniversalTableViewCell.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/28.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

enum UniversalCellStyle {
    case RightButton,RightLabel,RightSwitch,LeftLogo,CarAuthorize//,RightObject
}

extension UILabel {
    func initView() {
        
    }
}


class UniversalTableViewCell: UITableViewCell {
    
    private var leftImage:UIImageView?
    private var leftLabel:UILabel?
    private var rightLabel:UILabel?
    private var rSwtch:UISwitch?
    private var subTableView:UITableView?
    private var rButton:UIButton?
    
    
    var leftLabelText:String? {
        didSet{
            guard leftLabel != nil else {return}
            let width = XuTextSizeMiddle * CGFloat(NSString(string: leftLabelText!).length)
            leftLabel?.frame.size = CGSizeMake(width + 10, XuTextSizeMiddle + 5)
            leftLabel?.text = leftLabelText
        }
    }
    
    var rightLabelText:String? {
        didSet{
            guard rightLabel != nil else {return}
            let width = XuTextSizeMiddle * CGFloat(NSString(string: rightLabelText!).length)
            rightLabel?.frame.size = CGSizeMake(width + 10, XuTextSizeMiddle + 5)
            rightLabel?.text = rightLabelText
            rightLabel?.center = CGPointMake(XuWidth - width / 2 - 25, XuCellHeight / 2)
        }
    }
    
    var rightButtonTitle:String? {
        didSet{
            guard rButton != nil else {return}
            rButton?.setTitle(rightButtonTitle, forState: UIControlState.Normal)
            let width = XuTextSizeMiddle * CGFloat(NSString(string: rightButtonTitle!).length) + 5
            rButton?.frame.size = CGSizeMake(width + 10, XuTextSizeMiddle + 5)
            rButton?.center = CGPointMake(XuWidth - width / 2 - 25, XuCellHeight / 2)
        }
    }
    
    init(universalStyle:UniversalCellStyle,reuseIdentifier:String) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.initLeftLabel()
        switch universalStyle {
        case .RightButton:
            self.initRightButton()
        case .RightSwitch:
            self.initRightSwitch()
        case .RightLabel:
            self.initRightButton()
        default:break
        }
    }
    
    init(rightObject:NSObject?,reuseIdentifier:String) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        switch rightObject {
        case nil:
            break
        case is UIView:
            (rightObject as! UIView).center = CGPointMake(XuWidth - CGRectGetWidth((rightObject as! UIView).frame) / 2 - 20, XuCellHeight / 2)
            break
        default:break
        }
    }
    
    //MARK: -- init
    func initLeftLabel() {
        leftLabel = UILabel(frame: CGRectMake(15, 0, 0, 20))
        leftLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        leftLabel?.center.y = XuCellHeight / 2
        self.addSubview(leftLabel!)
    }
    
    func initRightButton() {
        rButton = UIButton(type: UIButtonType.Custom)
        rButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        rButton?.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        rButton?.backgroundColor = XuColorBlue
        rButton?.frame = CGRectZero
        rButton?.layer.cornerRadius = XuCornerRadius
        self.addSubview(rButton!)
    }
    
    func initRightSwitch() {
        rSwtch = UISwitch(frame: CGRectZero)
        rSwtch?.addTarget(self, action: "rightSwitchAction:", forControlEvents: UIControlEvents.ValueChanged)
        rSwtch?.transform = CGAffineTransformMakeScale(0.7, 0.7)
        rSwtch?.center = CGPointMake(XuWidth - 45, XuCellHeight / 2)
        contentView.addSubview(rSwtch!)
    }
    
    func initRightLabel() {
        rightLabel = UILabel(frame: CGRectMake(15, 0, 0, 20))
        rightLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        rightLabel?.center.y = XuCellHeight / 2
        self.addSubview(rightLabel!)
    
    }
    
    //MARK: --control event
    func rightButtonAction(sender:UIButton) {
        
    }
    
    func rightSwitchAction(sender:UISwitch) {
        
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
