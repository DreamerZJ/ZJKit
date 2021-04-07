//
//  ScreenConst.swift
//  Pods
//
//  Created by micheal on 2021/1/29.
//

import Foundation
// 屏幕分辨率缩放系数
let scale = UIScreen.main.scale
// 屏幕宽度、高度
let (screenWidth,screenHeight) = (min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height), max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
