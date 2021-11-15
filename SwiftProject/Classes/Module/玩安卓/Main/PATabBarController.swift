//
//  PATabBarController.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/16.
//

import UIKit

class PATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
            let bar = UITabBarAppearance.init()
            bar.backgroundColor = UIColor.white
            bar.shadowColor = UIColor.gray
            self.tabBar.scrollEdgeAppearance = bar
            self.tabBar.standardAppearance = bar
        }
        let homeVC =  PAHomeViewController()
        let knowledgeVC = KnowledgeViewController()
        let publicVC = PublicViewController()

        addChild(homeVC, childTitle: "首页", itemImage: "home", index: 0)
        addChild(knowledgeVC, childTitle: "知识体系", itemImage: "favor", index: 1)
        addChild(publicVC, childTitle: "公众号", itemImage: "find", index: 2)
    }
    
    private func addChild(_ childController: UIViewController ,childTitle:String,itemImage:String,index:Int) {
        childController.title = childTitle
        childController.tabBarItem.tag = index
        childController.tabBarItem.image = UIImage.init(named: "tabbar_" + itemImage + "_normal")?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage.init(named: "tabbar_" + itemImage + "_selected")?.withRenderingMode(.alwaysOriginal)
        self.addChild(childController)
    }


}
