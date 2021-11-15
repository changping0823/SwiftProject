//
//  UIImageView+Kingfisher.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/22.
//


import UIKit
import Kingfisher

extension UIImageView {
    @discardableResult
    public func setImage(
        with source: String?,
        placeholder: Placeholder? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        if source == nil {
            return nil
        }
        let url = URL(string: source!)
        return self.kf.setImage(with: url, placeholder: placeholder, options: KingfisherManager.shared.defaultOptions, completionHandler: completionHandler)
    }
    
    
}
