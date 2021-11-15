//
//  Global.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/20.
//

import UIKit

let STATUS_BAR_MANAGER = UIApplication.shared.windows.first?.windowScene?.statusBarManager
/// 状态栏高度
let STATUS_BAR_HEIGHT = STATUS_BAR_MANAGER!.statusBarFrame.size.height

/// 导航栏高度
let NAVIGATION_HEIGHT = STATUS_BAR_HEIGHT + 44

/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width

/// 屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

/// 屏幕bounds
let SCREEN_BOUNDS = UIScreen.main.bounds


let isIphoneX = STATUS_BAR_HEIGHT > 64
