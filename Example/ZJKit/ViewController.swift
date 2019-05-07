//
//  ViewController.swift
//  ZJKit
//
//  Created by micheal on 05/07/2019.
//  Copyright (c) 2019 micheal. All rights reserved.
//

import UIKit
import ZJKit

class ViewController: UIViewController, ZJViewBuild {

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {

    func createViewTree() {
        print("创建视图")
    }

    func layoutViews() {
        print("布局视图")
    }

    func configViews() {
        print("配置视图")
    }
}

