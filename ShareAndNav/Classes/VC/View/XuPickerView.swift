//
//  XuPickerView.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/11/9.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

enum XuPickerStyle {
    case Time,Date,DateAndTime,Provinces,CityAndArea,City
}

protocol XuPickerViewDelegate {
    func pickerViewDidCancel()
    func pickerViewDidSelected(pickerString:String)
}

class XuPickerView: UIView ,UIPickerViewDataSource,UIPickerViewDelegate{
    
    lazy var datePicker = UIDatePicker()
    var pickerView:UIPickerView?
    let rectPicker = CGRectMake(0, 44, XuWidth, XuHeight / 4 - 45)
    var pathArray:NSArray?
    var delegate:XuPickerViewDelegate?
    lazy var component = 3;lazy var row0 = 0;lazy var row1 = 0
    lazy var addressString:NSMutableString = "北京 通州"

    init(style:XuPickerStyle) {
        super.init(frame: CGRectMake(0, 0, XuWidth, XuHeight / 4))
        self.layer.borderColor = XuColorGrayThin.CGColor
        self.layer.borderWidth = 1
        self.backgroundColor = XuColorWhite
        self.initBarView()
        switch style {
        case .Date:
            self.initDatePickerView(UIDatePickerMode.Date)
        case .Time:
            self.initDatePickerView(UIDatePickerMode.Time)
        case .DateAndTime:
            self.initDatePickerView(UIDatePickerMode.DateAndTime)
        case .CityAndArea:
            self.initCustomPickerView()
        case .City:
            self.initCustomPickerView()
            self.component = 2
        case .Provinces:
            self.initCustomPickerView()
            self.component = 1
        }
    }
    
    //MARK: -- init View
    func initCustomPickerView() {
        pickerView = UIPickerView(frame: self.rectPicker)
        pickerView?.dataSource = self
        pickerView?.delegate = self
        pickerView?.showsSelectionIndicator = true
        self.addSubview(pickerView!)
        
        let path = NSBundle.mainBundle().pathForResource("CityAndArea", ofType: ".plist")
        self.pathArray = NSArray(contentsOfFile: path!)
    }
    
    func initBarView() {
        let bar = UINavigationBar(frame: CGRectMake(0,0,XuWidth,44))
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel:")
        navItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: "ensure:")
        bar.pushNavigationItem(navItem, animated: false)
        bar.backgroundColor = UIColor.clearColor()
        self.addSubview(bar)
    }
    
    func initDatePickerView(datePickerMode:UIDatePickerMode) {
        datePicker.datePickerMode = datePickerMode
        datePicker.frame = rectPicker
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(datePicker)
    }
    
    //MARK:--controller action
    func cancel(sender:UIBarButtonItem) {
        self.delegate?.pickerViewDidCancel()
        print("cancel")
    }
    
    func ensure(sender:UIBarButtonItem) {
        if pickerView != nil {
            self.addressString = NSMutableString(string: pathArray![pickerView!.selectedRowInComponent(0)]["state"] as! String)
            let a = dicWithDic(pathArray![pickerView!.selectedRowInComponent(0)] as! NSDictionary, key: "cities", row: pickerView!.selectedRowInComponent(1))
            self.addressString.appendString(" ")
            self.addressString.appendString(a.objectForKey("city") as! String)
            if let areas = a.objectForKey("areas") as? NSArray {
                if areas.count > 0 {
                    self.addressString.appendString(" ")
                    self.addressString.appendString(areas.objectAtIndex(pickerView!.selectedRowInComponent(2)) as! String)
                }
            }
            print(self.addressString)
        }else {
            let selectedDate:NSDate = datePicker.date
            let formatter:NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.delegate?.pickerViewDidSelected(formatter.stringFromDate(selectedDate))
        }
    }
    
    func datePickerChanged(datepicker:UIDatePicker) {
        print("changed")
    }
    
    //MARK: --UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            if self.component > 2 {
                self.row0 = row
                self.row1 = 0
                pickerView.reloadComponent(2)
                pickerView.reloadComponent(1)
            }else if self.component > 1 {
                self.row0 = row
                pickerView.reloadComponent(1)
            }
        case 1:
            if self.component > 2{
                self.row1 = row
                pickerView.reloadComponent(2)
            }
        default:break
        }
    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return self.stringWithRow(row, component: component)
//    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.pathArray!.count
        case 1:
            return (self.pathArray![row0]["cities"] as? NSArray)!.count
        case 2:
            let b = (dicWithDic(pathArray![row0] as! NSDictionary, key: "cities", row: row1)).objectForKey("areas") as? NSArray
            return (b?.count)!
        default:break
        }
        return 0
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return self.component
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel(frame: CGRectMake(0,0,XuWidth / 3, 20))
        label.font = UIFont.systemFontOfSize(XuTextSizeMiddle)
        label.text = self.stringWithRow(row, component: component)
        label.textAlignment = NSTextAlignment.Center
        return label
    }
    
    func dicWithDic(mdic:NSDictionary,key:String,row:Int) -> NSDictionary {
        if let array = mdic[key]! as? NSArray {
            guard array.count > row else {return NSDictionary()}
            if let dic = array[row] as? NSDictionary {
                return dic
            }
        }
        return NSDictionary()
    }
    
    func stringWithRow(row:Int,component:Int) -> String? {
        switch component {
        case 0:
            return self.pathArray![row]["state"] as? String
        case 1:
            return dicWithDic(self.pathArray![row0] as! NSDictionary, key: "cities", row: row).objectForKey("city") as? String
        case 2:
            if let array = dicWithDic(self.pathArray![row0] as! NSDictionary, key: "cities", row: row1).objectForKey("areas") as? NSArray {
                if array.count == 0 {return ""}
                return array[row] as? String
            }
            return nil
        default:return nil
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
