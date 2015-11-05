//
//  NewLicensePlateViewController.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/27.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class NewLicensePlateViewController: UIViewController {
    
    @IBOutlet weak var boundsView: UIView!
    @IBOutlet weak var selectView: UIView!  //第一行视图
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var determineButton: UIButton!
    @IBOutlet weak var checkYesButton: UIButton!
    @IBOutlet weak var checkNoButton: UIButton!
    
    @IBOutlet weak var plateTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "跳过", style: UIBarButtonItemStyle.Plain, target: self, action: "skipThisTap:")
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSForegroundColorAttributeName:XuColorBlue,
            NSFontAttributeName:UIFont.systemFontOfSize(XuTextSizeSmall, weight: 2)],
            forState: UIControlState.Normal)
        
        self.navigationItem.title = "添加车辆"
        
        boundsView.layer.borderWidth = 1.0
        boundsView.layer.cornerRadius = 6.0
        boundsView.layer.borderColor = XuColorWhite.CGColor
        
        determineButton.layer.cornerRadius = 6.0
        
        checkYesButton.setImage(UIImage(named: "check_off"), forState: UIControlState.Normal)
        self.checkYesButton.setImage(UIImage(named: "check_on"), forState: UIControlState.Selected)
        checkNoButton.setImage(UIImage(named: "check_off"), forState: UIControlState.Normal)
        self.checkNoButton.setImage(UIImage(named: "check_on"), forState: UIControlState.Selected)
    }
    
    func skipThisTap(sender:UIBarButtonItem?) {
        let mapView = MasterViewController()
        let nav = UINavigationController(rootViewController: mapView)
        self.presentViewController(nav, animated: true, completion: nil)
    }

    @IBAction func determainAction(sender: AnyObject) {
        self.skipThisTap(nil)
    }
    
    @IBAction func checkedClicked(sender: AnyObject) {
        switch sender.tag {
        case 1,2:
            self.checkYesButton.selected = (self.checkYesButton.selected ? false : true)
            self.checkNoButton.selected = false
        default:
            self.checkNoButton.selected = (self.checkNoButton.selected ? false : true)
            self.checkYesButton.selected = false
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
