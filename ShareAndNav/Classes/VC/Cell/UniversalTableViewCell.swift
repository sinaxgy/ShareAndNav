//
//  UniversalTableViewCell.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/28.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

enum UniversalCellStyle {
    case RightText,Switch,LeftLogo
}

class UniversalTableViewCell: UITableViewCell {
    var rightLabel:UILabel!
    
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
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        switch universalStyle {
        case .LeftLogo:
            break
        default:
            break
        }
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
