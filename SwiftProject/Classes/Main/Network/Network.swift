//
//  Network.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/24.
//

import UIKit
import Alamofire

/// 网络请求超时时间
private var networkTimeout = 30

typealias SuccessBlock = ([String:Any]) -> Void

class Network: NSObject {
    
    @discardableResult
    
    // MARK: - GET请求
    class func GET(url:String,param:[String:Any]?,success: @escaping SuccessBlock) -> DataRequest{
        request(urlString: url, method: .get, parameters: param, success: success)
    }
        
    /// POST请求
    /// - Parameters:
    ///   - urlString: 请求连接
    ///   - parameters: 请求参数
    ///   - success: 成功回调
    /// - Returns: DataRequest
    class func POST(urlString: String, parameters:[String:Any]?, success: @escaping SuccessBlock) -> DataRequest{
        request(urlString: urlString, method: .post, parameters: parameters, success: success)
    }

    
    /// 网络请求
    /// - Parameters:
    ///   - urlString: 请求连接
    ///   - method: 请求方式
    ///   - parameters: 请求参数
    ///   - success: 成功回调
    /// - Returns: DataRequest
    class func request(urlString: String,method: HTTPMethod = .post, parameters:[String:Any]?, success: @escaping SuccessBlock) -> DataRequest{
        let url:URL = URL(string: urlString)!
        
        let request = AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default)
        request.responseJSON { (response) in
            
//            print(response.request)  // 原始的URL请求
//            print(response.response) // HTTP URL响应
//            print(response.data)     // 服务器返回的数据
//            print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            switch response.result {
            case let .success(result):
                guard let resultDict:[String:Any] = result as? [String : Any] else {
                    return
                }
                success(resultDict)
            case let .failure(error):
                print(error)
            }
        }
        return request;
    }
}
