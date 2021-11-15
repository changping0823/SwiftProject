//
//  LabelTextView.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/24.
//

import UIKit

class LabelTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.textContainer.lineFragmentPadding = 0 // 左右边距
        self.textContainerInset = UIEdgeInsets.zero // 上下边距
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
