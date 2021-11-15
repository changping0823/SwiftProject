//
//  UIView+ViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/27.
//

import UIKit

extension UIView{

    var viewController: UIViewController? {
        
        for view in sequence(first: self.superview, next: {$0?.superview}){
            
            if let responder = view?.next{
                
                if responder.isKind(of: UIViewController.self){
                    
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    var navigationController: UINavigationController? {
        
        return viewController?.navigationController
    }
}
