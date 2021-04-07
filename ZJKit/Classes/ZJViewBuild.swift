//
//  ZJViewBuild.swift
//  ZJKit
//
//  Created by micheal on 2019/5/7.
//  Copyright © 2019 covermedia. All rights reserved.
//

import Foundation


/// 创建view协议，划分为创建、布局、配置
public protocol ZJViewBuild {
    func createViewTree()
    func layoutViews()
    func configViews()
}


extension ZJViewBuild {
    public func buildViews() {
        createViewTree()
        layoutViews()
        configViews()
    }

    public func createViewTree() {}
    public func layoutViews() {}
    public func configViews() {}
}
