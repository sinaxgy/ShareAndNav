//
//  MasterViewController.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/29.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController ,MAMapViewDelegate,AMapSearchDelegate,SubMasterViewDelegate{
    
    var mapView:MAMapView!
    var search:AMapSearchAPI!
    var userLocation:CLLocation!
    
    lazy var movement:CGFloat = 0
    var secview:SubMasterView?
    var blackCoverView:UIView?
    var trackButton:UIButton!
    var subMasterRecoginzerPan:UIPanGestureRecognizer?
    var subMasterRecoginzerTap:UITapGestureRecognizer?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initMapView()
        self.initNavigationItemView()
    }
    
    func initNavigationItemView() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "head_protraits"), style: UIBarButtonItemStyle.Plain, target: self, action: "showSubMasterView:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
        self.search = AMapSearchAPI()
        self.search.delegate = self
        
        let view = UIView(frame: CGRectMake(0, 0, 50, mapView.frame.height - 100))
        view.backgroundColor = UIColor.clearColor()
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panRecognizer:")
        view.addGestureRecognizer(panRecognizer)
        mapView.addSubview(view)
    }
    
    func initMapView() {
        self.mapView = MAMapView(frame: CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64))
        mapView.compassOrigin = CGPointMake(mapView.compassOrigin.x, 22)
        mapView.scaleOrigin = CGPointMake(mapView.scaleOrigin.x, mapView.frame.height - 60)
        self.view.addSubview(mapView)
        mapView.rotateEnabled = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.Follow
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressRecoginzer:")
        mapView.addGestureRecognizer(longPress)
        
        for var i:CGFloat = 0; i < 2; i++ {
            let imageName = (i == 0 ? "parking" : "fuelling")
            let selector:Selector = (i == 0 ? "parkingSearch:" : "fuellingSearch:")
            let button = UIButton(type: UIButtonType.Custom)
            button.frame = CGRectMake(mapView.frame.width - 45, mapView.frame.height - 300 + i * 45, 40, 40)
            button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
            button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
            mapView.addSubview(button)
        }
        
        trackButton = UIButton(type: UIButtonType.Custom)
        trackButton.frame = CGRectMake(5, mapView.frame.height - 100, 40, 40)
        trackButton.setImage(UIImage(named: "track_on"), forState: UIControlState.Normal)
        trackButton.addTarget(self, action: "trackingAction:", forControlEvents: UIControlEvents.TouchUpInside)
        mapView.addSubview(trackButton)
        
        let carMaster = CarMaster(logo: UIImage(named: "fute")!, plate: "京AB1212", timesOfViolation: 1, scoresOfViolation: 6, timeParking: "69:20:20", revenue: 25.00)
        let footView = FootMenuView(carmaster: carMaster)
        footView.center = CGPointMake(mapView.center.x, mapView.frame.height - 40)
        self.mapView.addSubview(footView)
        footView.footerViewClicked = {
            (type) in
//            let animation = CATransition()
//            animation.duration = 0.5
//            animation.type = "cube"
//            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            switch type {
            case .brand:
                //animation.subtype = kCATransitionFromTop
                let carVC = CarViewController()
                self.navigationController?.pushViewController(carVC, animated: true)
            case .violation:
                //animation.subtype = kCATransitionFromLeft
                let violationVC = ViolationViewController()
                self.navigationController?.pushViewController(violationVC, animated: true)
            case .parkTime:
                //animation.subtype = kCATransitionFromBottom
                self.navigationController?.pushViewController(ParkingRecordViewController(), animated: true)
            case .revenue:
                let carportVC = CarportViewController()
                //animation.subtype = kCATransitionFromRight
                self.navigationController?.pushViewController(carportVC, animated: true)
            }
            //self.view.window?.layer.addAnimation(animation, forKey: "push")
        }
    }
    
    //MARK: --ControllerAction
    func showSubMasterView(sender:UIBarButtonItem) {
        self.creatOriginalSubMasterView()
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.blackCoverView?.alpha = 2 / 3
            self.secview?.center.x = XuWidth / 6
            }, completion: nil)
    }
    
    func showMessageView(sender:UIBarButtonItem) {
        let messageVC = MessageViewController()
        self.navigationController?.pushViewController(messageVC, animated: true)
    }
    
    func trackingAction(sender:UIButton) {
        if mapView.userTrackingMode != MAUserTrackingMode.Follow {
            mapView.userTrackingMode = MAUserTrackingMode.Follow
            sender.setImage(UIImage(named: "track_on"), forState: UIControlState.Normal)
        }
        mapView.setZoomLevel(16, animated: true)
    }
    
    func parkingSearch(sender:UIButton) {   //周边搜索
        let request = AMapPOIAroundSearchRequest()
        let latitude = CGFloat(userLocation.coordinate.latitude)
        let longtitude = CGFloat(userLocation.coordinate.longitude)
        request.location = AMapGeoPoint.locationWithLatitude(latitude, longitude: longtitude)
        request.keywords = "停车场"
        request.types = "汽车服务"
        request.sortrule = 0
        request.requireExtension = true
        
        //self.search.AMapPOIAroundSearch(request)
    }
    
    //加油站搜索
    func fuellingSearch(sender:UIButton) {
        
    }
    
    func hideSubMasterView(sender:NSObject) {
        self.subMasterViewDidDisAppear()
    }
    
    //MARK: --UIGestureRecognizer
    func creatOriginalSubMasterView() {
        blackCoverView = UIView(frame: UIScreen.mainScreen().bounds)
        blackCoverView?.backgroundColor = UIColor.blackColor()
        blackCoverView!.alpha = 0
        subMasterRecoginzerTap = UITapGestureRecognizer(target: self, action: "tapBlackView:")
        blackCoverView!.addGestureRecognizer(subMasterRecoginzerTap!)
        
        self.navigationController?.view.addSubview(blackCoverView!)
        secview = SubMasterView()
        secview?.delegate = self
        subMasterRecoginzerPan = UIPanGestureRecognizer(target: self, action: "panSubMasterView:")
        secview?.addGestureRecognizer(subMasterRecoginzerPan!)
        self.navigationController?.view.addSubview(secview!)
        secview!.center.x = -self.view.center.x
    }
    
    func panRecognizer(panRecognizer:UIPanGestureRecognizer) {
        let movementX = panRecognizer.translationInView(panRecognizer.view).x
        if movementX > 0 && secview == nil{
            self.creatOriginalSubMasterView()
        }
        guard secview != nil else {return}
        if movement < XuWidth * 2 / 3 {
            secview?.center.x += (movementX - movement)
            movement = movementX
            blackCoverView?.alpha = movement / self.view.frame.width
        }
        
        if panRecognizer.state == UIGestureRecognizerState.Ended {
            if secview != nil {
                if movement > XuWidth / 3 {
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.secview?.center.x = XuWidth / 6
                        self.blackCoverView?.alpha = 2/3
                        }, completion: { (_) -> Void in
                            self.movement = 0
                    })
                    
                }else {
                    self.movement = 0
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.blackCoverView?.alpha = 0
                        self.secview?.center.x = -XuWidth/2
                        }, completion: { (_) -> Void in
                            self.subMasterViewDidDisAppear()
                    })
                }
            }
        }
        
    }
    
    func longPressRecoginzer(sender:UILongPressGestureRecognizer) {
//        let point = sender.locationInView(sender.view)
//        if sender.state == UIGestureRecognizerState.Began {
//            if point.x < 50 {
//                self.creatOriginalSubMasterView()
//                self.movement = point.x
//            }else {
//                
//            }
//        }
//        if secview != nil {
//            if movement < XuWidth * 2 / 3 {
//                secview?.center.x += (point.x - self.movement)
//                self.movement = point.x
//                blackCoverView?.alpha = movement / self.view.frame.width
//            }
//        }
//        if sender.state == UIGestureRecognizerState.Ended {
//            if secview != nil {
//                if movement > XuWidth / 3 {
//                    UIView.animateWithDuration(0.3, animations: { () -> Void in
//                        self.secview?.center.x = XuWidth / 6
//                        self.blackCoverView?.alpha = 2/3
//                        }, completion: { (_) -> Void in
//                            self.movement = 0
//                    })
//                    
//                }else {
//                    self.movement = 0
//                    UIView.animateWithDuration(0.3, animations: { () -> Void in
//                        self.blackCoverView?.alpha = 0
//                        self.secview?.center.x = -XuWidth/2
//                        }, completion: { (_) -> Void in
//                            self.subMasterViewDidDisAppear()
//                    })
//                }
//            }
//        }
    }
    
    func subMasterViewDidDisAppear() {
        self.blackCoverView?.removeFromSuperview()
        self.blackCoverView?.removeGestureRecognizer(self.subMasterRecoginzerTap!)
        self.secview?.removeFromSuperview()
        self.secview?.removeGestureRecognizer(self.subMasterRecoginzerPan!)
        self.blackCoverView = nil
        self.secview = nil
        self.movement = 0
    }
    
    func tapBlackView(recoginzer:UITapGestureRecognizer) {
        if self.blackCoverView != nil {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.blackCoverView?.alpha = 0
                self.secview?.center.x = -XuWidth/2
                }, completion: { (_) -> Void in
                    self.blackCoverView?.removeFromSuperview()
                    self.secview?.removeFromSuperview()
                    self.blackCoverView = nil
                    self.secview = nil
            })
            
        }
    }
    
    func panSubMasterView(sender:UIPanGestureRecognizer) {
        let moved = sender.translationInView(sender.view).x
        if moved < 0 {
            if secview != nil && blackCoverView != nil {
                secview?.center.x = XuWidth / 6 + moved
                blackCoverView?.alpha = 2 / 3 + moved / XuWidth
            }
        }
        if sender.state == UIGestureRecognizerState.Ended {
            if fabs(moved) > XuWidth / 6 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.blackCoverView?.alpha = 0
                    self.secview?.center.x = -XuWidth/2
                    }, completion: { (_) -> Void in
                        self.subMasterViewDidDisAppear()
                })
            }else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.secview?.center.x = XuWidth / 6
                    self.blackCoverView?.alpha = 2/3
                    }, completion: nil)
            }
        }
        
    }
    
    //MARK: --MAMapViewDelegate
    func mapView(mapView: MAMapView!, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        if trackButton != nil {
            if mode == MAUserTrackingMode.Follow {
                trackButton.setImage(UIImage(named: "track_on"), forState: UIControlState.Normal)
            }else if mode == MAUserTrackingMode.None {
                trackButton.setImage(UIImage(named: "track_off"), forState: UIControlState.Normal)
            }
        }
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            self.userLocation = userLocation.location
        }
    }
    
    //MARK: --AMapSearchDelegate
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 { return }
        print(response.pois.count)
        print(response.suggestion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideSubMasterView:", name: NotificationOfHideSubMaster, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: -- SubMasterViewDelegate
    func SubMasterClicked(index: Int) {
        switch index {
        case 0: self.navigationController?.pushViewController(PersonalViewController(), animated: true)
        case 1: self.navigationController?.pushViewController(PayViewController(), animated: true)
        case 2: self.navigationController?.pushViewController(ParkingRecordViewController(), animated: true)
        case 3: self.navigationController?.pushViewController(CarViewController(), animated: true)
        case 4: self.navigationController?.pushViewController(CarportViewController(), animated: true)
        case 5: self.navigationController?.pushViewController(ViolationViewController(), animated: true)
        case 6: self.navigationController?.pushViewController(PersonalViewController(), animated: true)
        case 7: self.navigationController?.pushViewController(PersonalViewController(), animated: true)
        case 8: self.navigationController?.pushViewController(SettingViewController(), animated: true)
        default:break
        }
    }

}
