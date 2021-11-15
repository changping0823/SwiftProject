//
//  WBAccess.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit
import ObjectMapper

class WBAccess: Mappable,NSCoding {

    

    
    var access_token: String = ""
    var isRealName: Bool = false
    var remind_in: String = ""
    var expires_in: Int = 0
    var uid: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        access_token <- map["access_token"]
        isRealName <- map["isRealName"]
        remind_in <- map["remind_in"]
        expires_in <- map["expires_in"]
        uid <- map["uid"]
    }
    
    
    /**
    *  将某个对象写入文件时会调用
    *  在这个方法中说清楚哪些属性需要存储
    */
    func encode(with coder: NSCoder) {
        print(NSHomeDirectory())
        coder.encode(self.access_token, forKey: "access_token")
        coder.encode(self.isRealName, forKey: "isRealName")
        coder.encode(self.remind_in, forKey: "remind_in")
        coder.encode(self.expires_in, forKey: "expires_in")
        coder.encode(self.uid, forKey: "uid")
    }

    /**
    *  从文件中解析对象时会调用
    *  在这个方法中说清楚哪些属性需要存储
    */
    required init?(coder: NSCoder) {
        
        self.access_token = coder.decodeObject(forKey: "access_token") as! String
        self.isRealName   = coder.decodeBool(forKey: "isRealName")
        self.remind_in    = coder.decodeObject(forKey: "remind_in") as! String
        self.expires_in   = coder.decodeInteger(forKey: "expires_in")
        self.uid          = coder.decodeObject(forKey: "uid") as! String

   }
   
    
}
