//
//  CustomNavigationViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/24.
//

import UIKit

class CustomNavigationViewController: BaseViewController {
    lazy var navBar = WRCustomNavigationBar.CustomNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        self.setupNavBar()
    }
    
    fileprivate func setupNavBar(){
        
        view.addSubview(navBar)
        
        // 设置自定义导航栏背景图片
        navBar.barBackgroundImage = UIImage(named: "millcolorGrad")

        // 设置自定义导航栏背景颜色
        // navBar.backgroundColor = MainNavBarColor
        
        // 设置自定义导航栏标题颜色
        navBar.titleLabelColor = .green

        // 设置自定义导航栏左右按钮字体颜色
        navBar.wr_setTintColor(color: .white)
        
        if self.navigationController?.viewControllers.count != 1 {
            navBar.wr_setLeftButton(title: "<<", titleColor: UIColor.white)
        }
        
        weak var weakSelf = self
        navBar.onClickLeftButton = {
            weakSelf?.navigationController?.popViewController(animated: true)
        }
    }

}
