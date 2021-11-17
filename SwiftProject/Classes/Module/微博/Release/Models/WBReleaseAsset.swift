//
//  WBReleaseAsset.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/16.
//

import UIKit
import DKImagePickerController

//class WBReleaseAsset: DKAsset {
//    var isAdd: Bool = false
//
//    static func addAssets() -> WBReleaseAsset{
//        let asset = WBReleaseAsset(image: UIImage.init(named: "compose_pic_add")!)
//        asset.isAdd = true
//        return asset
//
//    }
//}

private var key: Void?
extension DKAsset{
    
    @IBInspectable var showImage: UIImage? {
        get {
            return objc_getAssociatedObject(self, &key) as? UIImage
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
