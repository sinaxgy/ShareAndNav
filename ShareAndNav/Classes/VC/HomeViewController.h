//
//  HomeViewController.h
//  ShareAndNav
//
//  Created by 徐成 on 15/10/27.
//  Copyright © 2015年 徐成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#define APIKey = @"723f58282834ef26a8e354d60aaa8eb7"

@interface HomeViewController : UIViewController

@property (nonatomic,strong) MAMapView *mapView;

@end
