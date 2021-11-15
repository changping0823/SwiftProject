//
//  HomeViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/19.
//

import UIKit
import SnapKit
import SwiftUI

class HomeViewController: CustomNavigationViewController {
    
    let tableView = UITableView()
    
    let dataArray = [["title":"玩安卓","value":"PATabBarController"],
                     ["title":"微信（SwiftUI）","value":"WeChatViewController"],
                     ["title":"微博","value":"WBTabBarController"]]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeCellId")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.init(top: NAVIGATION_HEIGHT, left: 0, bottom: 0, right: 0))
        }
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
//        navigationController?.isNavigationBarHidden = true
        // 设置导航栏颜色
        navBarBarTintColor = UIColor.red
        
        // 设置初始导航栏透明度
//        navBarBackgroundAlpha = 0
//
//        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white
        navBarTitleColor = .white
        navBar.wr_setRightButton(image: UIImage.init(named: "navigationbar_icon_compose")!)
        weak var weakSelf = self
        navBar.onClickRightButton = {
            weakSelf?.present(WBReleaseViewController(), animated: true, completion: nil)
        }

    }
    
}


extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controllerString = dataArray[indexPath.row]["value"] else {
            return
        }
        if controllerString == "WeChatViewController" {
            let vc = UIHostingController(rootView: WeChatRootView())
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        guard let controller = controllerString.transformClass() else { return }
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
}



extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellId", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]["title"]
        return cell
    }
    
    
}
