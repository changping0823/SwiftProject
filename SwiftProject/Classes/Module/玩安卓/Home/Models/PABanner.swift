//
//  PABanner.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/18.
//

import UIKit
import ObjectMapper

class PABanner: Mappable {
    var desc: String?
    var id: Int?
    var imagePath: String?
    var isVisible: Bool = true
    var order: Int?
    var title: String?
    var type: Int?
    var url: String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        desc <- map["desc"]
        id <- map["id"]
        imagePath <- map["imagePath"]
        isVisible <- map["isVisible"]
        order <- map["order"]
        title <- map["title"]
        type <- map["type"]
        url <- map["url"]
    }
}
