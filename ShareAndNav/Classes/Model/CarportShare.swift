//
//  CarportShare.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/9.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class CarportShare: NSObject {
    
    var time = ""
    var isOn = false
    var weekly:String?
    
    init(dic:NSDictionary) {
        for (key,value) in dic {
            switch (key as! String,value) {
            case ("time",_):
                time = value as! String
            case ("isOn",_):
                isOn = value.boolValue
            case ("weekly",_):
                weekly = value as? String
            default:break
            }
        }
    }

}
