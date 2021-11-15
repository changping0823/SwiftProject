//
//  WBAccountTool.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit
import ObjectMapper

private let WeiboAccess = "WeiboAccess"

class WBAccountTool: NSObject {
    static private var accessUserDefaults = UserDefaults.standard
    static func saveAccess(access: WBAccess) {
        accessUserDefaults.set(access.toJSONString(), forKey: WeiboAccess)
    }
    
    static func access() -> WBAccess? {
        guard let text = accessUserDefaults.string(forKey: WeiboAccess) else {
            return nil
        }
        return WBAccess.init(JSONString: text)
    }
    
    static func clear() {
        accessUserDefaults.set(nil, forKey: WeiboAccess)
    }
}
