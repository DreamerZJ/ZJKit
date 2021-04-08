//
//  NextViewController.swift
//  ZJKit_Example
//
//  Created by micheal on 2021/4/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    var timer: Timer?
    let btn = UIButton().next {
        $0.setTitle("返回", for: .normal)
        $0.setTitleColor(UIColor.red, for: .normal)
    }

    deinit {
        print("NextViewController销毁！！")
        timer?.invalidate()
        timer = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        timer = Timer.start(timeInterval: 1, block: { (_) in
            print("计时开始！！")
        })

        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        btn.addActionBlock({ [weak self](_) in
            self?.dismiss(animated: true, completion: nil)
        })
    }
}
