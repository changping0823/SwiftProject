//
//  API.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/18.
//

import UIKit
import Moya

enum API{
    case articleList(page: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.wanandroid.com/")!
    }
    
    var path: String {
        switch self {
        case .articleList(let page):
            return "article/list/\(page)/json"
        }
    }
    
    var method: Moya.Method {
//        switch self {
//        case .articleList:
//            return .get
//        default:
//            return .post
//        }
        return .get

    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/x-www-form-urlencoded;charset=utf-8"]
    }
    

}
