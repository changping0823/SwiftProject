//
//  WBTabBarController.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/3.
//


let WeiboAppKey = "3212157982"
let WeiboAppSecret = "3f24b3b21f75d8cf5d4201dc3683167f"
let WeiboRedirectUrl = "https://www.baidu.com"


import UIKit

class WBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
            let bar = UITabBarAppearance.init()
            bar.backgroundColor = UIColor.white
            bar.shadowColor = UIColor.init(white: 0, alpha: 0.15)
            self.tabBar.scrollEdgeAppearance = bar
            self.tabBar.standardAppearance = bar
        }
        let homeVC    =  WBHomeViewController()
        let videoVC   = WBVideoViewController()
        let findVC    = WBFindViewController()
        let messageVC = WBMessageViewController()
        let mineVC    = WBMineViewController()

        addChild(homeVC, childTitle: "微博", itemImage: "home", index: 0)
        addChild(videoVC, childTitle: "视频号", itemImage: "video", index: 1)
        addChild(findVC, childTitle: "发现", itemImage: "discover", index: 2)
        addChild(messageVC, childTitle: "消息", itemImage: "message_center", index: 3)
        addChild(mineVC, childTitle: "我的", itemImage: "profile", index: 4)
        
        self.tabBar.tintColor = UIColor.init(white: 0, alpha: 0.65)
        
        
        /// 判断登录
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.determineLogin()
        }
    }
    
    private func addChild(_ childController: UIViewController ,childTitle:String,itemImage:String,index:Int) {
        childController.tabBarItem.title = childTitle
        childController.tabBarItem.tag = index
        childController.tabBarItem.image = UIImage.init(named: "weibo_tabbar_" + itemImage)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage.init(named: "weibo_tabbar_" + itemImage + "_selected")?.withRenderingMode(.alwaysOriginal)
        self.addChild(childController)
    }
    
    @discardableResult
    func determineLogin() -> Bool {
        let access = WBAccountTool.access()
        if access == nil {
            loginWebWeibo()
            return false
        }
        return true
    }

    func loginWebWeibo() {
        let webViewController = WKWebViewController()
        webViewController.loadURLWithString("https://api.weibo.com/oauth2/authorize?client_id=\(WeiboAppKey)&response_type=code&redirect_uri=\(WeiboRedirectUrl)")
        present(webViewController, animated: true) {
        }
    }

    deinit {
        print("\(type(of: self)) ---> 销毁")
    }
}
