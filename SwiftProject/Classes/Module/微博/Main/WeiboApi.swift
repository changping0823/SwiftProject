//
//  WeiboApi.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit
import Moya

enum WeiboApi{
    case accessToken(code: String)
    case usersshow(Int)
    case statusesHomeTimeline(Int,Int)
}


extension WeiboApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.weibo.com/")!
    }
    
    var path: String {
        switch self {
        case .accessToken(let code):
            return "oauth2/access_token?client_id=\(WeiboAppKey)&client_secret=\(WeiboAppSecret)&grant_type=authorization_code&redirect_uri=\(WeiboRedirectUrl)&code=\(code)"
        case .usersshow(_):
            return "2/users/show.json"
        case .statusesHomeTimeline(_, _):
            return "2/statuses/home_timeline.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .accessToken:
            return .post
        case .usersshow:
            return .get
        case .statusesHomeTimeline:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        guard let access = WBAccountTool.access() else {
            return .requestPlain
        }
//        let access = WBAccountTool.access()!
        
        switch self {
        case .usersshow(_):
            return .requestParameters(parameters: ["access_token": access.access_token,"uid":access.uid], encoding: URLEncoding.default)
        case .statusesHomeTimeline(let count, let page):
            return .requestParameters(parameters: ["access_token": access.access_token,"page":page,"count":count], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/x-www-form-urlencoded;charset=utf-8"]
    }
}
