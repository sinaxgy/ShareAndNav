//
//  FootMenuView.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/27.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class FootMenuView: UIView {

    init(title:String) {
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width - 20, 40))
        self.initView()
    }
    
    init() {
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width - 20, 40))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        let imageView = UIImageView(frame: CGRectMake(5, 10, 20, 20))
        self.addSubview(imageView)
        
        let brandLabel = UILabel(frame: CGRectMake(28, 10, 62, 20))
        brandLabel.text = "京A B1212"
        brandLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(brandLabel)
        
        let brokenLabel = UILabel(frame: CGRectMake(100, 10, 30, 20))
        brokenLabel.text = "违章  1"
        brokenLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(brokenLabel)
        
        let deductLabel = UILabel(frame: CGRectMake(140, 10, 30, 20))
        deductLabel.text = "扣6分"
        deductLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(deductLabel)
        
        let parkLabel = UILabel(frame: CGRectMake(160, 10, 30, 20))
        parkLabel.text = "停车"
        parkLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(parkLabel)
        
        let timeLabel = UILabel(frame: CGRectMake(160, 10, 30, 20))
        timeLabel.text = "00:00:00"
        timeLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(timeLabel)
        
        let shareLabel = UILabel(frame: CGRectMake(200, 10, 60, 20))
        shareLabel.text = "00:00:00"
        shareLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(shareLabel)
        
    }

}
