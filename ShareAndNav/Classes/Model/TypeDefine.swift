//
//  TypeDefine.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/26.
//  Copyright © 2015年 徐成. All rights reserved.
//

import Foundation
import UIKit

var currentUser:String = ""
//MARK:-- const value
let XuAPIKey = "723f58282834ef26a8e354d60aaa8eb7"

let XuCellHeight:CGFloat = 50
let XuWidth = UIScreen.mainScreen().bounds.width
let XuHeight = UIScreen.mainScreen().bounds.height

let XuTextSizeSmall:CGFloat = 12.0
let XuTextSizeSmallest:CGFloat = 10.0
let XuTextSizeMiddle:CGFloat = 14.0
let XutextSizeBig:CGFloat = 15
let XutextSizeNav:CGFloat = 20
let XuFontSmall:CGFloat = 10

let XuCornerRadius:CGFloat = 5

let XuColorBackground = UIColor(red: 230/255, green: 230/255, blue: 232/255, alpha: 1)
let XuColorBlueThin = UIColor(red: 127/255, green: 193/255, blue: 1, alpha: 1)
let XuColorBlue = UIColor(red: 0, green: 132/255, blue: 1, alpha: 1)
let XuColorWhite = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
let XuColorGrayThin = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
let XuColorGray = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)

//MARK: -- enum and struct
enum XuLoginType {
    case DynamicCode,Password,Default
}

