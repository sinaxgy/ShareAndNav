//
//  ViolationObject.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/9.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class ViolationObject: NSObject {
    
    var plate:String?
    var times:NSInteger?
    var points:NSInteger?
    var forfeit:NSInteger?
    var info:NSArray?
    
    init(dic:NSDictionary) {
        for (key,value) in dic {
            switch (key as! String,value) {
            case ("plate",_):
                plate = value as? String
            case ("times",_):
                times = value as? NSInteger
            case ("points",_):
                points = value as? NSInteger
            case ("forfeit",_):
                forfeit = value as? NSInteger
            case ("info",_):
                info = value as? NSArray
            default:break
            }
        }
    }

}
