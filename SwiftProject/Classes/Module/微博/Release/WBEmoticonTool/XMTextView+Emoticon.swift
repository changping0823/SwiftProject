//
//  XMTextView+Emoticon.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/12.
//

import UIKit

extension XMTextView {
    /// 插入图片
    /// - Parameter em: 表情模型
    func inserEmoticonView(em: WBEmoticon) {
        
        if em.empty {
            return
        }
        if em.remove {
            deleteBackward()
            return
        }
        
        guard let imageText = WBReleaseEmoticonAttachment(emoticon: em).imageText(font: font!) else {
            return
        }
        let attributeM = NSMutableAttributedString(attributedString: attributedText)
        // 插入图片
        attributeM.replaceCharacters(in: selectedRange, with: imageText)
        // 记录光标位置
        let range = selectedRange
        attributedText = attributeM
        selectedRange = NSRange(location: range.location+1, length: 0)
    }
    
    /// 发送文本
    /// - Returns: 包含图片的完整文本
    func sendText() -> String {
        
        let attributeText = attributedText
        var strM = String()
        attributeText?.enumerateAttributes(in: NSRange(location: 0, length: attributeText!.length), options: [], using: { (dict, range, _) in
            
            if let attachment = dict[NSAttributedString.Key(rawValue: "NSAttachment")] as? WBReleaseEmoticonAttachment {
                strM += attachment.emoticon.chs ?? ""
            } else {
                let str = (attributeText!.string as NSString).substring(with: range)
                strM += str
            }
        })
        
        return strM
    }
    
    /// 接受文本
    var clientText: NSAttributedString {
        return attributedText
    }
}
