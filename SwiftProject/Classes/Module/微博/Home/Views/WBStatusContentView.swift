//
//  WBStatusContentView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/10.
//

import UIKit
import Toast_Swift
import JXPhotoBrowser

class WBStatusContentView: UIView {
    
    lazy var statusLabel = UITextView()
    lazy var gridView = WBStatusGridView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
//        statusLabel.numberOfLines = 0
        statusLabel.delegate = self
        statusLabel.isEditable = false        //必须禁止输入，否则点击将弹出输入键盘
        statusLabel.isScrollEnabled = false
        statusLabel.isUserInteractionEnabled = false
//        statusLabel.isSelectable = false
        //内容缩进为0（去除左右边距）
        statusLabel.textContainer.lineFragmentPadding = 0
        //文本边距设为0（去除上下边距）
        statusLabel.textContainerInset = .zero

        addSubview(statusLabel)
        
        gridView.delegate = self
        addSubview(gridView)
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        gridView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(16)
            make.height.equalTo(0)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private var _status: WBStatuses?
    var status: WBStatuses? {
        set{
            _status = newValue
            
            guard let text = _status?.text else { return }
            
            let textFont = UIFont.systemFont(ofSize: 16)
            
            let attri = NSMutableAttributedString.init(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5
            let aattributes = [NSAttributedString.Key.paragraphStyle :style,
                               NSAttributedString.Key.foregroundColor: UIColor.init(white: 0, alpha: 0.85),
                               NSAttributedString.Key.font:textFont]
            attri.setAttributes(aattributes,range: NSRange.init(location: 0, length: text.length))
            
            
            /// 设置话题
            let rangArray = text.topicExpression()
            rangArray.forEach { range in
                let linkUrl = "huati://\(text.subString(withNSRange: range))"
                let utf8Str = linkUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                attri.addAttributes([NSAttributedString.Key.link : utf8Str!],range: range)
            }
            
            /// @用户
            let userRangArray = text.userExpression()
            userRangArray.forEach { range in
                let linkUrl = "user://\(text.subString(withNSRange: range))"
                let utf8Str = linkUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                attri.addAttributes([NSAttributedString.Key.link : utf8Str!],range: range)
            }
            
            /// 设置表情
            let emoticons = WBEmoticonManager.shared.emoticons
            
            //正则匹配要替换的文字的范围
            let emoticonArray = text.emoticonExpression()
            
            var textAttachmentArray: [[String: Any]] = []
            
            emoticonArray.forEach { range in
                //获取原字符串中对应的值
                let subStr: String = text.subString(withNSRange: range)
                
                emoticons.forEach { emoticon in
                    if emoticon.chs == subStr {
                        //新建文字附件来存放我们的图片
                        let textAttachment = NSTextAttachment()
                        //给附件添加图片
                        let image = UIImage.init(named: emoticon.png ?? "")!
                        
                        let mid = textFont.descender + textFont.capHeight
                        let emoticonSize: CGFloat = 20
                        
                        textAttachment.bounds = CGRect(x: 0, y: textFont.descender - emoticonSize/2 + mid + 2, width: emoticonSize, height: emoticonSize).integral
                        
                        textAttachment.image = image
                        
                        //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                        let imageStr = NSAttributedString.init(attachment: textAttachment)
                        
                        //把图片和图片对应的位置存入字典中
                        let imageDic: [String: Any] = ["image":imageStr,"range":range]
                        textAttachmentArray.append(imageDic)
                    }
                    
                }
            }
            textAttachmentArray.reversed().forEach { dict in
                let range: NSRange = dict["range"] as! NSRange
                let att: NSAttributedString = dict["image"] as! NSAttributedString
                attri.replaceCharacters(in: range, with: att)
            }
            
            statusLabel.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color(r: 65, g: 105, b: 160)]
            statusLabel.attributedText = attri

            
            guard let pic_urls = _status?.pic_urls else { return }
            gridView.imageWH = _status!.imgItemWH
            gridView.imageSrcs = pic_urls
            
            gridView.snp.updateConstraints { make in
                make.height.equalTo(_status!.imgViewH)
            }
        }
        get{
            return _status
        }
    }
    

}


extension WBStatusContentView: WBStatusGridViewDelegate{
    func onClickImageView(imageSrcs: [WBStatusesPicUrls], index: Int) {
        let browser = JXPhotoBrowser()
        browser.numberOfItems = {
            imageSrcs.count
        }
        browser.reloadCellAtIndex = { context in
            let url = imageSrcs[context.index].original_pic
            let browserCell = context.cell as? JXPhotoBrowserImageCell
            browserCell?.imageView.setImage(with: url, placeholder: UIImage.init(named: "timeline_image_placeholder"))
        }
        browser.pageIndex = index
        browser.show()
    }
    
}


extension WBStatusContentView: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        if URL.scheme == "huati" {
            self.viewController?.view.makeToast("点击了话题:\(URL.host!)", duration: 2.0, position: .bottom)
            return false
        }else if URL.scheme == "user"{
            self.viewController?.view.makeToast("点击了用户:\(URL.host!)", duration: 2.0, position: .center)
            return false
        }
        return true
    }
    
}
