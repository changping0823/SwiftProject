//
//  UIDevice+Extension.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/18.
//

import UIKit
import Alamofire


extension UIDevice {
    static var isNetworkConnect: Bool {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true // 无返回就默认网络已连接
    }
}
