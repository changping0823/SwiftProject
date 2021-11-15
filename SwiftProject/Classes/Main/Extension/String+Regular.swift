//
//  String+Regular.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/9.
//

import UIKit

let kRegularMatcheUser = "@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"  // @用户匹配

extension String{
    /// 表情的正则表达式
    func userExpression() -> [NSRange]{
        return self.regularExpression(pattern: kRegularMatcheUser)
    }
    /// 表情的正则表达式
    func emoticonExpression() -> [NSRange]{
        return self.regularExpression(pattern: "\\[.*?]")
    }
    
    /// 话题的正则表达式
    func topicExpression() -> [NSRange]{
        return self.regularExpression(pattern: "#.*?#")
    }
    
    func regularExpression(pattern: String) -> [NSRange]{
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: self as String, options: [], range: NSMakeRange(0, self.length))
            return matches.map {$0.range}
        } catch {
            print("Error when create regex!")
            return []
        }
    }
    
    
    func nsRange(nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }

}



extension NSRange{
    //NSRange转换为Range
//    func toRange() -> Range<String.Index>? {
//        guard let from16 = utf16.index(utf16.startIndex, offsetBy: self.location, limitedBy: utf16.endIndex) else { return nil }
//        guard let to16 = utf16.index(from16, offsetBy: self.length, limitedBy: utf16.endIndex) else { return nil }
//        guard let from = String.Index(from16, within: self) else { return nil }
//        guard let to = String.Index(to16, within: self) else { return nil }
//        return from ..< to
//    }
}
