//
//  BaseTabBarController.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/19.
//

import UIKit
import SwiftUI

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let home =  HomeViewController()
        let wechat = UIHostingController(rootView: ContentView())
        let playAndroid = PAHomeViewController()

        addChild(home, childTitle: "首页", itemImage: "home", index: 0)
        addChild(wechat, childTitle: "微信", itemImage: "favor", index: 1)
        addChild(playAndroid, childTitle: "玩安卓", itemImage: "find", index: 2)
        
//        UITabBarAppearance *appearance = [UITabBarAppearance new];
//        //tabBar背景颜色
//        appearance.backgroundColor = [UIColor whiteColor];
//       // 去掉半透明效果
//        appearance.backgroundEffect = nil;
//       // tabBaritem title选中状态颜色
//       appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{
//            NSForegroundColorAttributeName:KColorFromRGB(0x53A2F8),
//            NSFontAttributeName:[UIFont systemFontOfSize:12],
//        };
//        //tabBaritem title未选中状态颜色
//        appearance.stackedLayoutAppearance.normal.titleTextAttributes =  @{
//            NSForegroundColorAttributeName:KColorFromRGB(0x7E7E7E),
//            NSFontAttributeName:[UIFont systemFontOfSize:12],
//        };
//        self.tabBar.scrollEdgeAppearance = appearance;
//        self.tabBar.standardAppearance = appearance;
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor.white;
        appearance.backgroundEffect = nil
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
        tabBar.standardAppearance = appearance
    }
    
    private func addChild(_ childController: UIViewController ,childTitle:String,itemImage:String,index:Int) {
        let nav = CustomNavigationController(rootViewController: childController)
        if index == 1 {
            nav.appBar.isHidden = true
        }
        childController.title = childTitle
        childController.tabBarItem.tag = index
        childController.tabBarItem.image = UIImage.init(named: "tabbar_" + itemImage + "_normal")?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage.init(named: "tabbar_" + itemImage + "_selected")?.withRenderingMode(.alwaysOriginal)
        self.addChild(nav)
    }
    
}
