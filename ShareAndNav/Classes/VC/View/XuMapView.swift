//
//  XuMapView.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/12/22.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class XuMapView: MAMapView {

    var stepper:XuStepper!
    var trackButton:UIButton!
    
    //MARK: --func
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.compassOrigin = CGPointMake(10, 10)
        self.showsScale = false
        self.rotateEnabled = false
        
        trackButton = UIButton(type: UIButtonType.Custom);trackButton.tag = 1
        trackButton.frame = CGRectMake(5, frame.height - 100, 40, 40)
        trackButton.setImage(UIImage(named: "track_on"), forState: UIControlState.Normal)
        trackButton.addTarget(self, action: "trackingAction:", forControlEvents: UIControlEvents.TouchUpInside)
        trackButton.handleControlEvent(.TouchUpInside) { (_) -> Void in
            if self.userTrackingMode != MAUserTrackingMode.Follow {
                self.userTrackingMode = MAUserTrackingMode.Follow
                self.trackButton.setImage(UIImage(named: "track_on"), forState: UIControlState.Normal)
            }
            self.setZoomLevel(16 * 3, animated: true)
        }
        self.addSubview(trackButton)
        
        stepper = XuStepper(style: XuStepperStyle.Vertical, origin: CGPointMake(XuWidth - 42, XuHeight - 200), width: 33)
        stepper?.maximumValue = self.maxZoomLevel;stepper?.minimumValue = self.minZoomLevel
        stepper?.value = 7
        self.addSubview(stepper!)
        stepper?.stepperValueChanged = { (sender) in
            self.setZoomLevel(CGFloat(sender.value), animated: true)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
