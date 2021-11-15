//
//  NSString+Transform.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/20.
//

import UIKit

extension String{
    
    /**
     * 字符串转成 UIViewController
     *
     * - Returns: UIViewController
     */
    func transformClass() -> UIViewController?{
        /// Swift中命名空间的概念
        var name = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String
        name = name?.replacingOccurrences(of: "-", with: "_")
        let fullClassName = name! + "." + self
        guard let classType = NSClassFromString(fullClassName) as? UIViewController.Type  else{
            print("转换失败")
            return nil;
        }
        return classType.init()
    }
}
