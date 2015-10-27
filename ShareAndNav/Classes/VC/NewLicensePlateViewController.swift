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
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var determineButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "跳过", style: UIBarButtonItemStyle.Plain, target: self, action: "skipThisTap:")
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSForegroundColorAttributeName:XuColorBlue,
            NSFontAttributeName:UIFont.systemFontOfSize(XuTextSizeSmall, weight: 2)],
            forState: UIControlState.Normal)
        
        self.navigationItem.title = "添加车辆"
        
        boundsView.layer.borderWidth = 2
        boundsView.layer.cornerRadius = 6.0
        boundsView.layer.borderColor = XuColorGray.CGColor
        
        determineButton.layer.cornerRadius = 6.0
    }
    
    func skipThisTap(sender:UIBarButtonItem) {
        
    }

    @IBAction func determainAction(sender: AnyObject) {
        
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
