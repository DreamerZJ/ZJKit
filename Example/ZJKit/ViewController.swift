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

    let btn = UIButton()
    let control = UIControl()
    let label = UILabel().next {
        $0.textAlignment = .center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func clickBtn() {
        let vc = NextViewController()
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController {

    func createViewTree() {
        btn.frame = CGRect.init(x: 100, y: 100, width: 80, height: 60)
        btn.acceptInterval = 4
        btn.enlargeEdgeInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0)
        btn.backgroundColor = UIColor.red
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(UIColor.yellow, for: .normal)
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        view.addSubview(btn)

        control.backgroundColor = UIColor.black
        control.frame = CGRect.init(x: 100, y: 200, width: 80, height: 60)
        control.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        view.addSubview(control)

        print("abcd".zj.subStr(2, 3))
        
    }

    func layoutViews() {
        print("布局视图")
    }

    func configViews() {
        print("配置视图")
    }
}

