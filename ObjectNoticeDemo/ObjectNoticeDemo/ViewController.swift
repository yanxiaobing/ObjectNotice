//
//  ViewController.swift
//  ObjectNoticeDemo
//
//  Created by xbingo on 2020/3/9.
//  Copyright © 2020 Xbingo. All rights reserved.
//

import UIKit

struct NoticeKeys {
    static var updateLab = "notice_for_updateLab"
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ObjectNotice.shared.observer(self, NoticeKeys.updateLab) { (object, userInfo) in
            self.lab.text = "收到通知"
        }
    }

    @IBOutlet weak var lab: UILabel!

    @IBAction func sendNotice(_ sender: Any) {
        
        ObjectNotice.shared.post(NoticeKeys.updateLab)
    }
    
    deinit {
        ObjectNotice.shared.removeObserver(self)
    }
    
}

