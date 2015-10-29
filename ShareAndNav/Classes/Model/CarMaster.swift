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
    
    var timesOfBroken:UInt = 0
    var scoresOfBroken:UInt = 0
    
    var timeParking:String = "00:00:00"
    
    var revenue:Float = 0

    init(logo:UIImage,plate:String,timesOfBroken:UInt,scoresOfBroken:UInt,timeParking:String,revenue:Float) {
        self.logo = logo
        self.lisencePlate = plate
        self.timesOfBroken = timesOfBroken
        self.scoresOfBroken = scoresOfBroken
        self.timeParking = timeParking
        self.revenue = revenue
    }
    
    override init() {
        
    }
}
