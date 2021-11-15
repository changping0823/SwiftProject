//
//  ResponseModel.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/18.
//

import UIKit

struct ResponseModel: Codable {
    var errorCode: Int = -999
    var errorMsg: String = ""
    // 这里的data用String类型 保存response.data
    var data: String = ""
    /// 分页的游标 根据具体的业务选择是否添加这个属性
    var cursor: String = ""
}
