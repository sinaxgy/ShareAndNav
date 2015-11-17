//
//  AcProtocolViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/13.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class AcProtocolViewController: UIViewController {
    
    var previousVC:UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XuColorWhite
        self.navigationItem.title = "协议"
        
        self.initView()
        
        if self.previousVC != nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "backPreviousVC:")
        }
    }
    
    func initView() {
        let webView = UIWebView(frame: self.view.frame)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.baidu.com")!))
        self.view.addSubview(webView)
    }
    
    func backPreviousVC(sender:NSObject) {
        self.presentViewController(previousVC!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
