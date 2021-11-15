//
//  BaseNavigationController.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/19.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white;
        
    }
    
    override func pushViewController(_ viewController:UIViewController, animated:Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
