//
//  HomeViewController.m
//  ShareAndNav
//
//  Created by 徐成 on 15/10/27.
//  Copyright © 2015年 徐成. All rights reserved.
//

#import "HomeViewController.h"
#import "ShareAndNav-Swift.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMapView];
    
}

- (void) initMapView
{
    self.view.backgroundColor = [UIColor grayColor];
    mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    mapView.compassOrigin = CGPointMake(mapView.compassOrigin.x, 22);
    mapView.scaleOrigin = CGPointMake(mapView.scaleOrigin.x, 22);
    //self.gdMapView.delegate = self;
    [self.view addSubview:self.mapView];
    mapView.showsUserLocation = YES;
    mapView.headingFilter = 100;
    mapView.desiredAccuracy = kCLLocationAccuracyKilometer;
    mapView.distanceFilter = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
