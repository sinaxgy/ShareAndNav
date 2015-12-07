//
//  MasterMapDelegate.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/26.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class MasterMapDelegate: NSObject ,AMapSearchDelegate,MAMapViewDelegate{
    
    
    //MARK: --MAMapViewDelegate
    func mapView(mapView: MAMapView!, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        for ele in mapView.subviews {
            if let trackButton = ele as? UIButton {
                guard trackButton.tag == 1 else {break}
                if mode == MAUserTrackingMode.Follow {
                    trackButton.setImage(UIImage(named: "track_on"), forState: UIControlState.Normal)
                }else if mode == MAUserTrackingMode.None {
                    trackButton.setImage(UIImage(named: "track_off"), forState: UIControlState.Normal)
                }
            }
        }
    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            //self.userLocation = userLocation.location
        }
    }
    
    //MARK: --AMapSearchDelegate
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 { return }
        //self.annotations = response.pois
        print(response.pois.count)
        print(response.suggestion.keywords)
        print(response.suggestion.cities)
        for ele in response.pois {
            if let poi = ele as? AMapPOI {
                print("name:\(poi.name)>>>>>>location:\(poi.location.latitude)")
            }
        }
    }
    
    func onRouteSearchDone(request: AMapRouteSearchBaseRequest!, response: AMapRouteSearchResponse!) {
        print(response.route)
    }
}
