//
//  WBReleaseEmoticonAttachment.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/12.
//

import UIKit

class WBReleaseEmoticonAttachment: NSTextAttachment {
    var emoticon: WBEmoticon
    //MARK: - 构造函数
    init(emoticon: WBEmoticon) {
        
        self.emoticon = emoticon
        super.init(data: nil, ofType: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageText(font: UIFont) -> NSAttributedString? {
        guard let img = emoticon.png else { return nil}
        image = UIImage.init(named: img)
        // 设置bounds
        let lineHeight = font.lineHeight
        bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: self))
        imageText.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: 1))
        
        return imageText
    }
}
