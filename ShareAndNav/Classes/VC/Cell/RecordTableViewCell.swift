//
//  RecordTableViewCell.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/14.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    private var luLabel:UILabel!
    private var ldLabel:UILabel!
    private var ruLabel:UILabel!
    private var rdLabel:UILabel!
    private var locateBtn:UIButton!
    private var showButton:UIButton!
    var showDetail = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.initBaseView()
        if showDetail {
            self.frame.size.height = 52
        }else {
            
        }
    }
    
    func initBaseView() {
        luLabel = UILabel(frame: CGRectMake(30,5,250,15))
        luLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(luLabel)
        
        ldLabel = UILabel(frame: CGRectMake(30,30,220,15))
        ldLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.addSubview(ldLabel)
        
        let rs = CGRectGetMaxX(luLabel.frame)
        ruLabel = UILabel(frame: CGRectMake(rs + 10,5,XuWidth - rs - 20,15))
        ruLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        ruLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(ruLabel)
        
        rdLabel = UILabel(frame: CGRectMake(rs + 10,30,XuWidth - rs - 20,15))
        rdLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        rdLabel.textAlignment = NSTextAlignment.Right
        self.addSubview(rdLabel)
        
        locateBtn = UIButton(type: UIButtonType.System)
        locateBtn.frame = CGRectMake(15, 30, 10, 15)
        locateBtn.setImage(UIImage(named: "location"), forState: UIControlState.Normal)
        self.addSubview(locateBtn)
        
        showButton = UIButton(type: UIButtonType.System)
        locateBtn.frame = CGRectMake(0, 0, 15, 15)
        locateBtn.center = CGPointMake(XuWidth / 2, 45)
        locateBtn.setImage(UIImage(named: "down"), forState: UIControlState.Normal)
        self.addSubview(locateBtn)
    }
    
    func setupData(xdic:NSDictionary) {
        luLabel.text = "\(xdic.objectForKey("plate"))  \(xdic.objectForKey("date"))"
        ldLabel.text = "\(xdic.objectForKey("address"))"
        ruLabel.text = "\(xdic.objectForKey("totalTime"))"
        rdLabel.text = "\(xdic.objectForKey("cost"))"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
