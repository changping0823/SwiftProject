//
//  Double+Time.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/27.
//

import UIKit

extension Double {
    
//    static var paRedColor: UIColor {
//        return UIColor(r: 240, g: 81, b: 88, alpha: 1.0)
//    }
//
    //MARK: -根据后台时间戳返回几分钟前，几小时前，几天前
    static var currennTime: String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        print(currentTime,   self, "sdsss")
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta: TimeInterval = TimeInterval(1632931200000 / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
}
