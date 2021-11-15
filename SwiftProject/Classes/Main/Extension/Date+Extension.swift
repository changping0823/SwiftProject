//
//  Date+Extension.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/31.
//

import Foundation

private let yearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy 年 M 月 d 日"
    return formatter
}()

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()

extension Date {
    
    var formatString: String {
        let date = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self, to: date)
        
        if components.year! >= 1 || components.month! >= 1 || components.day! > 1 {
            return "\(yearFormatter.string(from: self)) \(timeFormatter.string(from: self))"
        } else if components.day == 1 {
            return "昨天 \(timeFormatter.string(from: self))"
        } else {
            return timeFormatter.string(from: self)
        }
    }
    
}
    extension Date {
    //字符串 -> 日期
    static func dateWhitString(_ string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        
//        NSDateFormatter *iosDateFormater=[[[NSDateFormatter alloc] init] autorelease];
        let wbFormatter = DateFormatter()
        wbFormatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        //必须设置，否则无法解析
        wbFormatter.locale = Locale.init(identifier: "en_US")
//        NSDate *newDate=[iosDateFormater dateFromString:date];
        guard let newDate = wbFormatter.date(from: string) else { return Date() }
//        return newDate!
        //目的格式
        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = dateFormat
//        [resultFormatter setDateFormat:@"MM月dd日 HH:mm"];

        let dateString = resultFormatter.string(from: newDate);
        return resultFormatter.date(from: dateString) ?? Date();
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale.init(identifier: "zh_CN")
//        formatter.dateFormat = dateFormat
//        let date = formatter.date(from: string)
//        return date!
    }
    //对时间的处理
    //传入的时间戳精确到毫秒
    static func customDate(date:String)->String{
        
        let myDate = dateWhitString(date)
        
        let fmt  = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        fmt.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        //获得当前时间
        let now = NSDate()
        //计算时间差
        let interval:Int = Int(now.timeIntervalSince(myDate as Date))
        // 处理小于一分钟的时间
        if interval < 60 {
            return "刚刚"
        }
        // 处理小于一小时的时间
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        // 处理小于一天的时间
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        // 处理昨天时间
        let calendar = Calendar.current
        if calendar.isDateInYesterday(myDate as Date) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr  = fmt.string(from: myDate as Date)
            return timeStr
        }
        //处理一年之内的时间
        let cmp  = calendar.dateComponents([.year,.month,.day], from: myDate as Date, to: now as Date)
        if cmp.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr  = fmt.string(from: myDate as Date)
            return timeStr
        }
        //超过一年的时间
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: myDate as Date)
        return timeStr
    }


}
