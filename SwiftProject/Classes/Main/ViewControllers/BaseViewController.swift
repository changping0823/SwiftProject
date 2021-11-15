//
//  BaseViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/19.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

    }
    
    //类销毁时 通知此方法
    deinit {
        print("\(type(of: self)) ---> 销毁")
    }
}
