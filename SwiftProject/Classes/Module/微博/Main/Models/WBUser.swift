//
//  WBUser.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit
import ObjectMapper

class WBUser: Mappable {

    // "id": 1404376560,
    var id: Int?
    // "screen_name": "zaku",
    var screen_name: String?
    // "name": "zaku",
    var name: String?
    // "province": "11",
    var province: String?
    // "city": "5",
    var city: String?
    // "location": "北京 朝阳区",
    var location: String?
    // "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
    var description: String?
    // "url": "http://blog.sina.com.cn/zaku",
    var url: String?
    // "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
    var profile_image_url: String?
    // "domain": "zaku",
    var domain: String?
    // "gender": 性别，m：男、f：女、n：未知
    var gender: String?
    // "followers_count": 1204,
    var followers_count: Int?
    // "friends_count": 447,
    var friends_count: Int?
    // "statuses_count": 2908,
    var statuses_count: Int?
    // "favourites_count": 0,
    var favourites_count: Int?
    // "created_at": "Fri Aug 28 00:00:00 +0800 2009",
    var created_at: String?
    // "following": false,
    var following: Bool = false
    // "allow_all_act_msg": false,
    var allow_all_act_msg: Bool = false
    // "remark": "",
    var remark: String?
    // "geo_enabled": true,
    var geo_enabled: Bool = false
    // "verified":是否是微博认证用户，即加V用户，true：是，false：否
    var verified: Bool = false
    // "allow_all_comment": true,
    var allow_all_comment: Bool = false
    // "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
    var avatar_large: String?
    // "verified_reason": "",
    var verified_reason: String?
    // "follow_me": false,
    var follow_me: Bool = false
    // "online_status": 0,
    var online_status: Int?
    // "bi_followers_count": 215
    var bi_followers_count: Int?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        screen_name <- map["screen_name"]
        name <- map["name"]
        province <- map["province"]
        city <- map["city"]
        location <- map["location"]
        description <- map["description"]
        url <- map["url"]
        profile_image_url <- map["profile_image_url"]
        domain <- map["domain"]
        
        gender <- map["gender"]
        followers_count <- map["followers_count"]
        friends_count <- map["friends_count"]
        statuses_count <- map["statuses_count"]
        favourites_count <- map["favourites_count"]
        created_at <- map["created_at"]
        following <- map["following"]
        allow_all_act_msg <- map["allow_all_act_msg"]
        remark <- map["remark"]
        geo_enabled <- map["geo_enabled"]
        
        verified <- map["verified"]
        allow_all_comment <- map["allow_all_comment"]
        avatar_large <- map["avatar_large"]
        verified_reason <- map["verified_reason"]
        follow_me <- map["follow_me"]
        online_status <- map["online_status"]
        bi_followers_count <- map["bi_followers_count"]
    }
}
