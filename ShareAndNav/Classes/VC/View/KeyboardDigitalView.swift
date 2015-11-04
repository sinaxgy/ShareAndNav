//
//  KeyboardDigitalView.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/3.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class KeyboardDigitalView: UIView {
    
    let XuHeight:CGFloat = 40
    
    init(carmaster:CarMaster) {
        super.init(frame: CGRectMake(0, 0, XuWidth, XuHeight))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
