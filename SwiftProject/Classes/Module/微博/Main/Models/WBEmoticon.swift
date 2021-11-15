//
//  WBEmoticon.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/9.
//

import UIKit
import ObjectMapper

class WBEmoticon: Mappable {
    //    chs = "[微笑]";
    var chs: String?
    //    cht = "[微笑]";
    var cht: String?
    //    gif = "d_hehe.gif";
    var gif: String?
    //    png = "d_hehe.png";
    var png: String?
    //    type = 0;
    var type: Int = 0
    /// 是否删除按钮
    var remove: Bool = false
    /// 是否空按钮
    var empty: Bool = false
    
    
    required init?(map: Map) {
        
    }
    init(){
    }
    
    func mapping(map: Map) {
        chs <- map["chs"]
        cht <- map["cht"]
        gif <- map["gif"]
        png <- map["png"]
        type <- map["type"]
    }
    

    
}
