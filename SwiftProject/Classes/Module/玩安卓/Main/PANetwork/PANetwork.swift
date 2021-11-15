//
//  PANetwork.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/16.
//

import UIKit
import Alamofire

import Moya
import SwiftyJSON
import ObjectMapper


@discardableResult
func PARequest<T: Mappable>(_ target: TargetType, needShowFailAlert: Bool = true, modelType: T.Type, successCallback:@escaping RequestModelSuccessCallback<T>, failureCallback: RequestFailureCallback? = nil) -> Cancellable? {
    return request(target, needShowFailAlert: needShowFailAlert, modelType: T.self, successCallback: successCallback, failureCallback: failureCallback)
}

/// 网络请求，当模型为数组类型
/// - Parameters:
///   - target: 接口
///   - showFailAlert: 是否显示网络请求失败的弹框
///   - modelType: 模型
///   - successCallback: 成功的回调
///   - failureCallback: 失败的回调
/// - Returns: 取消当前网络请求Cancellable实例
@discardableResult
func PARequest<T: Mappable>(_ target: TargetType, needShowFailAlert: Bool = true, modelType: [T].Type, successCallback:@escaping RequestModelsSuccessCallback<T>, failureCallback: RequestFailureCallback? = nil) -> Cancellable? {
    return request(target, needShowFailAlert: needShowFailAlert, modelType: [T].self, successCallback: successCallback, failureCallback: failureCallback)
}
