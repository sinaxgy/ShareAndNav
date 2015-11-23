//
//  ViolationTableViewCell.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/20.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class ViolationTableViewCell: UITableViewCell {
    
    private var luLabel:UILabel!
    private var ldLabel:UILabel!
    private var ruLabel:UILabel!
    private var rdLabel:UILabel!
    private var locateBtn:UIButton!
    
    var locationClosure : (() -> Void)?
    var xviolation:Violation? {
        didSet{
            luLabel.text = xviolation?.date
            ruLabel.text = "\((xviolation?.reason)!) 扣\((xviolation?.point)!)"
            ldLabel.text = xviolation?.address
            rdLabel.text = "罚款" + (xviolation?.forfeit)!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        self.initBaseView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initBaseView() {
        let xShift:CGFloat = (self.accessoryType == UITableViewCellAccessoryType.DisclosureIndicator ? 10 : 0)
        luLabel = UILabel(frame: CGRectMake(30,5,200,15))
        luLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.contentView.addSubview(luLabel)
        
        ldLabel = UILabel(frame: CGRectMake(30,25,220,15))
        ldLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        self.contentView.addSubview(ldLabel)
        
        let rs = CGRectGetMaxX(luLabel.frame)
        ruLabel = UILabel(frame: CGRectMake(rs + 10 - xShift,5,XuWidth - rs - 25,15))
        ruLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        ruLabel.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(ruLabel)
        
        rdLabel = UILabel(frame: CGRectMake(rs + 10 - xShift,25,XuWidth - rs - 25,15))
        rdLabel.font = UIFont.systemFontOfSize(XuTextSizeSmall)
        rdLabel.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(rdLabel)
        
        let image = UIImage(named: "location")!
        locateBtn = UIButton(type: UIButtonType.System)
        locateBtn.frame = CGRectMake(15, 25, 10, 10 * image.size.height / image.size.width)
        locateBtn.setImage(UIImage(named: "location"), forState: UIControlState.Normal)
        locateBtn.addTarget(self, action: "locationAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(locateBtn)
    }
    
    func locationAction(sender:UIButton) {
        self.locationClosure?()
    }
}


