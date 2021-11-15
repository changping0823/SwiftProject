//
//  CustomNavigationController.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/20.
//

import UIKit


class CustomNavigationBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CustomNavigationController: BaseNavigationController {

    lazy var appBar: CustomNavigationBar = {
        let bar = CustomNavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: NAVIGATION_HEIGHT))
        bar.backgroundColor = UIColor.red
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        isNavigationBarHidden = true
//
//        view.addSubview(appBar)
        
    }

//    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
//        
//        appBar.isHidden = hidden
//        super.setNavigationBarHidden(true, animated: animated);
//    }
}
