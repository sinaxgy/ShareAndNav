//
//  MasterMapDelegate.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/26.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class MasterMapDelegate: NSObject ,AMapSearchDelegate,MAMapViewDelegate{
    
    private var poi:NSArray?
    var mapView:XuMapView?
    private var xAnnotations:NSArray?{
        didSet{
            mapView?.addAnnotations(xAnnotations as! [AnyObject])
        }
    }
    
    //MARK: --MAMapViewDelegate
    func mapView(mapView: MAMapView!, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        guard let mv = mapView as? XuMapView else {return}
        if mode == MAUserTrackingMode.Follow {
            mv.trackButton.setImage(UIImage(named: "track_on"), forState: UIControlState.Normal)
        }else if mode == MAUserTrackingMode.None {
            mv.trackButton.setImage(UIImage(named: "track_off"), forState: UIControlState.Normal)
        }
    }
    
    func mapView(mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
        self.mapView?.stepper.value = mapView.zoomLevel
        print(mapView.zoomLevel)
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            //self.userLocation = userLocation.location
        }
    }
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        switch annotation {
        case is MAUserLocation:break
        case is XuPointAnnotation:
            let reuseIdentifier = "point"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            }
            annotationView.image = UIImage(named: "location")
            return annotationView
        default:break
        }
        return MAAnnotationView()
    }
    
    //MARK: --AMapSearchDelegate
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 { return }
        self.poi = response.pois
        print(response.pois.count)
        print(response.suggestion.keywords) //nil
        print(response.suggestion.cities)       //nil
        let annotations:NSMutableArray = []
        for ele in response.pois {
            if let poi = ele as? AMapPOI {
                print("name:\(poi.name)>>>>>>location:\(poi.location.latitude)")
                annotations.addObject(XuPointAnnotation(poi: poi))
            }
        }
        self.xAnnotations = annotations
    }
    
    func onRouteSearchDone(request: AMapRouteSearchBaseRequest!, response: AMapRouteSearchResponse!) {
        print(response.route)
    }
    
    //MARK: --init
//    override init() {
//        super.init()
//        var onceToken:dispatch_once_t = 0
//        dispatch_once(&onceToken) { () -> Void in
//            let after = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * NSEC_PER_USEC))
//            dispatch_after(after, dispatch_get_main_queue(), { () -> Void in
//                guard let vc = XuAssistantSwift.getCurrentViewController() as? MasterViewController else {return}
//                self.currentVC = vc
//            })
//        }
//    }
}
