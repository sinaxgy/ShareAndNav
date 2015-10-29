//
//  FootMenuView.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/27.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

enum XuSegmentedViewType:Int {
    case brand = 1,broken,parkTime,revenue
}

class FootMenuView: UIView {
    
    lazy var carmaster = CarMaster()
    
    init(title:String) {
        let width = UIScreen.mainScreen().bounds.width - 20
        super.init(frame: CGRectMake(0, 0, width, 40))
        self.layer.cornerRadius = XuCornerRadius
        for var i:CGFloat = 1;i < 3;i++ {
            let line = UIView(frame: CGRectMake(0, 0, 0.5, 20))
            line.backgroundColor = XuColorGray
            line.center = CGPointMake(i * width / 4, 20)
            self.addSubview(line)
        }
        
        self.initView(width / 4)
    }
    
    init() {
        super.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width - 20, 40))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func singleTap(recoginzer:UITapGestureRecognizer) {
        
    }
    
    func initView(subWidth:CGFloat) {
        //车牌
        let brandView = UIView(frame: CGRectMake(0, 5, subWidth, 30))
        let singleTap = UITapGestureRecognizer(target: self, action: "singleTap:")
        brandView.tag = XuSegmentedViewType.brand.rawValue
        brandView.addGestureRecognizer(singleTap)
        self.addSubview(brandView)
        
        let imageView = UIImageView(frame: CGRectMake(5, 10, 20, 20))
        imageView.image = carmaster.logo
        brandView.addSubview(imageView)
        let brandLabel = UILabel(frame: CGRectMake(28, 10, subWidth - 28, 20))
        brandLabel.text = carmaster.lisencePlate
        brandLabel.textAlignment = NSTextAlignment.Center
        brandLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        brandView.addSubview(brandLabel)
        
        //违章
        let brokenView = UIView(frame: CGRectMake(subWidth, 5, subWidth, 30))
        brokenView.tag = XuSegmentedViewType.broken.rawValue
        brokenView.addGestureRecognizer(singleTap)
        self.addSubview(brokenView)
        
        let brokenLabel = UILabel(frame: CGRectMake(0, 0, subWidth, 20))
        brokenLabel.text = "违章  \(carmaster.timesOfBroken)  扣 \(carmaster.scoresOfBroken) 分"
        brokenLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        brokenLabel.textAlignment = NSTextAlignment.Center
        brokenView.addSubview(brokenLabel)
        
        //停车时间
        let parkView = UIView(frame: CGRectMake(subWidth * 2, 5, subWidth, 30))
        parkView.tag = XuSegmentedViewType.parkTime.rawValue
        parkView.addGestureRecognizer(singleTap)
        self.addSubview(parkView)
        
        let parkLabel = UILabel(frame: CGRectMake(0, 0, subWidth, 20))
        parkLabel.text = "停车 \(carmaster.timeParking)"
        parkLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        parkLabel.textAlignment = NSTextAlignment.Center
        parkView.addSubview(parkLabel)
        
        //分享
        let revenueView = UIView(frame: CGRectMake(subWidth * 3, 5, subWidth, 30))
        revenueView.tag = XuSegmentedViewType.revenue.rawValue
        revenueView.addGestureRecognizer(singleTap)
        self.addSubview(revenueView)
        
        let revenueLabel = UILabel(frame: CGRectMake(0, 0, subWidth, 20))
        revenueLabel.text = "分享 ¥ \(carmaster.revenue)"
        revenueLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        revenueLabel.textAlignment = NSTextAlignment.Center
        revenueView.addSubview(revenueLabel)
    }

}
