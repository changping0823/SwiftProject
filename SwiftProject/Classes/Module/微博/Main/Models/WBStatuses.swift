//
//  WBStatuses.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit
import ObjectMapper

class WBStatuses: Mappable {

    // created_at     string     微博创建时间
    var created_at: String?
    // id     int64     微博ID
    var id: Int?
    // mid     int64     微博MID
    var mid: Int?
    // idstr     string     字符串型的微博ID
    var idstr: String?
    // text     string     微博信息内容
    var text: String?
    // source     string     微博来源
    var source: String?
    /// 移动端显示的微博来源
    var showSource: String?
    // favorited     boolean     是否已收藏，true：是，false：否
    var favorited: Bool = false
    // truncated     boolean     是否被截断，true：是，false：否
    var truncated: Bool = false
    // in_reply_to_status_id     string     （暂未支持）回复ID
    var in_reply_to_status_id: String?
    // in_reply_to_user_id     string     （暂未支持）回复人UID
    var in_reply_to_user_id: String?
    // in_reply_to_screen_name     string     （暂未支持）回复人昵称
    var in_reply_to_screen_name: String?
    
    /// 微博配图数量
    var pic_num: Int = 0
    /// 微博配图url数组
    var pic_urls:[WBStatusesPicUrls]?
    // thumbnail_pic     string     缩略图片地址，没有时不返回此字段
    var thumbnail_pic: String?
    // bmiddle_pic     string     中等尺寸图片地址，没有时不返回此字段
    var bmiddle_pic: String?
    // original_pic     string     原始图片地址，没有时不返回此字段
    var original_pic: String?
    
    // geo     object     地理信息字段 详细
    // user     object     微博作者的用户信息字段 详细
    var user: WBUser?
    // retweeted_status     object     被转发的原微博信息字段，当该微博为转发微博时返回 详细
    // reposts_count     int     转发数
    var reposts_count: Int = 0
    // comments_count     int     评论数
    var comments_count: Int = 0
    // attitudes_count     int     表态数
    var attitudes_count: Int = 0
    // mlevel     int     暂未支持
    var mlevel: Int?
    // visible     object     微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
    // pic_ids     object     微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
    // ad     object array     微博流内的推广微博ID
    
    
    var imgViewH: CGFloat = 0
    var imgItemWH: CGFloat = 0
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        created_at <- map["created_at"]
        id <- map["id"]
        mid <- map["mid"]
        idstr <- map["idstr"]
        text <- map["text"]
        source <- map["source"]
        
        
        favorited <- map["favorited"]
        truncated <- map["truncated"]
        in_reply_to_status_id <- map["in_reply_to_status_id"]
        in_reply_to_user_id <- map["in_reply_to_user_id"]
        in_reply_to_screen_name <- map["in_reply_to_screen_name"]
        
        pic_num <- map["pic_num"]
        thumbnail_pic <- map["thumbnail_pic"]
        bmiddle_pic <- map["bmiddle_pic"]
        original_pic <- map["original_pic"]
        pic_urls <- map["pic_urls"]
        
        user <- map["user"]
        reposts_count <- map["reposts_count"]
        comments_count <- map["comments_count"]
        attitudes_count <- map["attitudes_count"]
        // geo     object     地理信息字段 详细
        // retweeted_status     object     被转发的原微博信息字段，当该微博为转发微博时返回 详细
        mlevel <- map["mlevel"]
        // visible     object     微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
        // pic_ids     object     微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
        // ad     object array     微博流内的推广微博ID
        
        
        /// 截取“>”与“</a>” 之间的字符
        /// sourcePattern = ">.*</a>"  包括 “>”与“</a>”
        /// sourcePattern = "(?<=>).*(?=</a>)"  不包括 “>”与“</a>”
        let sourcePattern = "(?<=>).*(?=</a>)"
        let array = source?.regularExpression(pattern: sourcePattern)
        array!.forEach { nsRange in
            showSource = source?.subString(withNSRange: nsRange)
        }
        
        guard let picNumber = pic_urls?.count else { return }
        
        var rows = 0
        var columns = 3
        if picNumber == 4 {
            columns = 2
        }
        rows = (picNumber + columns - 1)/columns

        /// 计算图片内容的高度
        let middleSpace: CGFloat = 5 // 中间间隙
        let contentW = SCREEN_WIDTH - 32;
        
        imgItemWH = (contentW - Double((columns - 1)) * middleSpace)/Double(columns);
        
        imgViewH = (imgItemWH + middleSpace) * Double(rows) - middleSpace
    }
}


class WBStatusesPicUrls: Mappable {
    var thumbnail_pic: String?
    var bmiddle_pic: String?
    var large_pic: String?
    var original_pic: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        thumbnail_pic <- map["thumbnail_pic"]
        
        bmiddle_pic = thumbnail_pic?.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        large_pic = thumbnail_pic?.replacingOccurrences(of: "thumbnail", with: "large")
        original_pic = thumbnail_pic?.replacingOccurrences(of: "thumbnail", with: "original")
    }
    
    
    
}
