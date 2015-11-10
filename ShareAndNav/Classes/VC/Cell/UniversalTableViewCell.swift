//
//  UniversalTableViewCell.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/28.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

enum UniversalCellStyle {
    case RightButton,RightText,Switch,LeftLogo,CarAuthorize
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
    
    var rightButtonTitle:String? {
        didSet{
            guard rButton == nil else {rButton?.setTitle(rightButtonTitle, forState: UIControlState.Normal);return}
            rButton?.setTitle(rightButtonTitle, forState: UIControlState.Normal)
            let width = XuTextSizeMiddle * CGFloat(NSString(string: rightButtonTitle!).length)
            rButton?.frame.size.width = width
            rButton?.center = CGPointMake(XuWidth - width / 2 - 15, XuCellHeight / 2)
        }
    }
    
    var leftLabelText:String? {
        didSet{
            guard leftLabel == nil else {leftLabel?.text = leftLabelText;return}
            let width = XuTextSizeMiddle * CGFloat(NSString(string: leftLabelText!).length)
            leftLabel?.frame.size.width = width
            leftLabel?.text = leftLabelText
        }
    }
    
    init(universalStyle:UniversalCellStyle,reuseIdentifier:String) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.initLeftLabel()
        switch universalStyle {
        case .RightButton:
            self.initRightButton()
            break
        case .CarAuthorize:
            //self.initViewWithCarOwnership(xcarOwnership)
            break
        default:
            //super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
            break
        }
    }
    
    //MARK: -- init
    func initLeftLabel() {
        leftLabel = UILabel(frame: CGRectMake(15, 0, 0, 20))
        leftLabel?.text = leftLabelText
        leftLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        leftLabel?.center.y = XuCellHeight / 2
        self.addSubview(leftLabel!)
    }
    
    func initRightButton() {
        rButton = UIButton(type: UIButtonType.Custom)
        rButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        rButton?.titleLabel?.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        rButton?.backgroundColor = XuColorBlue
        rButton?.frame = CGRectMake(0, 0, 0, 20)
        rButton?.layer.cornerRadius = XuCornerRadius
        self.addSubview(rButton!)
        
    }
    
    func initBaseView() {
        
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
