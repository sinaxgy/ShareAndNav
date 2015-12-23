//
//  XuAssistantSwift.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/12/9.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class XuAssistantSwift: NSObject {
    
    
    class func getCurrentViewController() -> UIViewController {
        var window = UIApplication.sharedApplication().keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.sharedApplication().windows
            for win in windows {
                if win.windowLevel == UIWindowLevelNormal {
                    window = win
                }
            }
        }
        if window?.subviews.count > 0{
            let nextResponder = window?.subviews[0].nextResponder()
            if  nextResponder is UINavigationController {
                return (nextResponder as! UINavigationController).visibleViewController!
            }else if nextResponder is UIViewController {
                return nextResponder as! UIViewController
            }
        }
        return (window?.rootViewController)!
    }
    
    class func getCurrentVCWithAsyncClosure(viewController:((UIViewController) -> Void)) {
        let globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(globalQueue) { () -> Void in
            var window = UIApplication.sharedApplication().keyWindow
            if window?.windowLevel != UIWindowLevelNormal {
                let windows = UIApplication.sharedApplication().windows
                for win in windows {
                    if win.windowLevel == UIWindowLevelNormal {
                        window = win
                    }
                }
            }
            if window?.subviews.count > 0{
                let nextResponder = window?.subviews[0].nextResponder()
                if  nextResponder is UINavigationController {
                    viewController((nextResponder as! UINavigationController).visibleViewController!)
                }else if nextResponder is UIViewController {
                    viewController(nextResponder as! UIViewController)
                }
            }
            viewController((window?.rootViewController)!)
        }
    }
    
    class func fileSize() {
        let fileManager = NSFileManager.defaultManager()
        let path = (NSHomeDirectory() as NSString).stringByAppendingPathComponent("Documents")
        if fileManager.fileExistsAtPath(path) {
            //let size = (fileManager.attributesOfItemAtPath(path) as NSDictionary).fileSize()
        }
        
    }
}
