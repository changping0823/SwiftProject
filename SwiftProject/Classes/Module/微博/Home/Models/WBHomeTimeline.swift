//
//  WBHomeTimeline.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit
import ObjectMapper

class WBHomeTimeline: Mappable {
    
    var statuses: [WBStatuses]?
    // "ad": ,
    var ad: [Any]?
    // "previous_cursor": 0, // 暂未支持
    // "next_cursor": 11488013766, // 暂未支持
    // "total_number": 81655
    var total_number: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statuses <- map["statuses"]
        ad <- map["ad"]
        total_number <- map["total_number"]
    }
    

}
