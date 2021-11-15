//
//  WBEmoticonManager.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/10.
//

import UIKit
import ObjectMapper


private let WeiboAccess = "WeiboAccess"

class WBEmoticonManager: NSObject {
    
    var emoticons: [WBEmoticon] = []
    
    
    static let shared = WBEmoticonManager()
    
    private override init() {
        //加载plist文件中的数据
        let bundle = Bundle.main
        //寻找资源的路径
        guard let path = bundle.path(forResource: "content2", ofType: "plist") else { return }
        //获取plist中的数据
        let data = NSMutableDictionary(contentsOfFile: path)
        let array: [[String: Any]] = data?["emoticons"] as! [[String : Any]]
        emoticons = Mapper<WBEmoticon>().mapArray(JSONArray: array)
    }
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    // Optional
    func reset() {
        // Reset all properties to default value
    }
}
