//
//  CarMaster.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/27.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class CarMaster: NSObject {
    
    var logo:UIImage!
    var lisencePlate:String = "京A B1212"
    var timesOfViolation:UInt = 0
    var scoresOfViolation:UInt = 0
    
    var timeParking:String = "00:00:00"
    
    var revenue:Float = 0
    
    init(logo:UIImage,plate:String,timesOfViolation:UInt,
                        scoresOfViolation:UInt,timeParking:String,revenue:Float) {
        self.logo = logo
        self.lisencePlate = plate
        self.timesOfViolation = timesOfViolation
        self.scoresOfViolation = scoresOfViolation
        self.timeParking = timeParking
        self.revenue = revenue
                            
    }
    
    override init() {
        
    }
}
