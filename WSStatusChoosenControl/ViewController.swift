//
//  ViewController.swift
//  WSStatusChooseControll
//
//  Created by 何文新 on 16/1/5.
//  Copyright © 2016年 wesin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var statusControl:HPStatusChoosenControl?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let back = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        back.backgroundColor = UIColor.brownColor()
        self.view.addSubview(back)
        let dataSource = [(0,"呵呵"),(1,"哈哈嘻"),(2,"虎虎"),(3,"嘎嘎"),(4, "唧唧"),(5, "咋咋"),(6,"咕咕"),(7,"咯咯"),(8,"喵喵咪")]
        statusControl = HPStatusChoosenControl(data: dataSource)
        self.view.insertSubview(statusControl!, belowSubview: back)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        statusControl?.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 44)
    }
}

