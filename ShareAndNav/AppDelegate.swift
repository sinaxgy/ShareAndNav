//
//  AppDelegate.swift
//  ShareAndNav
//
//  Created by 徐成 on 15/10/24.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        NSThread.sleepForTimeInterval(30)
//        self.launchScreen()
        MAMapServices.sharedServices().apiKey = XuAPIKey
        AMapSearchServices.sharedServices().apiKey = XuAPIKey
        
        if XuRegularExpression.isVaild(KeyChain.get(XuCurrentUser), fortype: XuRegularType.phone) {
            self.window?.rootViewController = UINavigationController(rootViewController: MasterViewController())
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func launchScreen() {
        let launchView = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewControllerWithIdentifier("LaunchScreen")
        launchView.view.backgroundColor = UIColor.greenColor()
        let imageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        imageView.image = UIImage(named: "logo")
        launchView.view.addSubview(imageView)
        
        self.window?.rootViewController = launchView
    }
}

