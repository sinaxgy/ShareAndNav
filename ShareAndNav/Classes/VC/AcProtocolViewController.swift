//
//  AcProtocolViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/13.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class AcProtocolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XuColorWhite
        self.navigationItem.title = "协议"
        
        self.initView()
    }
    
    func initView() {
        let webView = UIWebView(frame: self.view.frame)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.baidu.com")!))
        self.view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
