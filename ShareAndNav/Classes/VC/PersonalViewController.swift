//
//  PersonalViewController.swift
//  ShareAndNav
//
//  Created by xubupt218 on 15/11/12.
//  Copyright © 2015年 徐成. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {
    
    var collectionView:UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = XuColorWhite
        self.navigationItem.title = "个人资料"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "message_off"), style: UIBarButtonItemStyle.Plain, target: self, action: "showMessageView:")
    }
    
    //MARK: --ControllerAction
    func showMessageView(sender:UIBarButtonItem) {
        let messageVC = MessageViewController()
        self.navigationController?.pushViewController(messageVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
