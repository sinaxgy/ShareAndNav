//
//  CarOwnership.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/6.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class CarOwnership: NSObject {
    
    var brand:String?
    var plate:String?
    var isCerificate:Bool?
    var isAuthorize:Bool?
    var assistPhones:NSArray?
    
    init(dic:NSDictionary) {
        for (key,value) in dic {
            switch (key as! String,value) {
            case ("brand",_):
                brand = value as? String
            case ("plate",_):
                plate = value as? String
            case ("cerificate",_):
                isCerificate = value.boolValue
            case ("authorize",_):
                isAuthorize = value.boolValue
            case ("assist",_):
                assistPhones = value as? NSArray
            default:break
            }
        }
    }
    
    init(xco:CarOwnership) {
        self.brand = xco.brand
        self.plate = xco.plate
        self.isCerificate = xco.isCerificate
        self.isAuthorize = xco.isAuthorize
        self.assistPhones = xco.assistPhones
    }
    
    func dictionaryValue() -> NSDictionary {
        let mdic:NSMutableDictionary = [:]
        mdic.setObject(self.brand!, forKey: "brand")
        mdic.setObject(self.plate!, forKey: "plate")
        mdic.setObject(self.isAuthorize!, forKey: "authorize")
        if self.isCerificate != nil {
            mdic.setObject(self.isCerificate!, forKey: "cerificate")
        }
        if self.assistPhones != nil {
            mdic.setObject(self.assistPhones!, forKey: "assist")
        }
        return mdic
    }
}
