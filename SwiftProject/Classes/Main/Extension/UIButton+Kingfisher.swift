//
//  UIButton+Kingfisher.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/22.
//


import UIKit
import Kingfisher

extension UIButton {
    @discardableResult
    public func setImage(
        with source: String?,
        placeholder: UIImage? = nil,
        for state: UIControl.State,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        if source == nil {
            return nil
        }
        let url = URL(string: source!)
        return self.kf.setImage(with: url, for: state, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: completionHandler)
        
    }
}
