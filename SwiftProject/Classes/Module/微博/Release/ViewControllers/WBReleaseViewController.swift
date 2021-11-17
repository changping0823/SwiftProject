//
//  WBReleaseViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/11.
//

import UIKit
import DKImagePickerController

class WBReleaseViewController: WBBaseViewController {
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView = UIView()
    
    
    lazy var textView: XMTextView = {
        let view = XMTextView()
        view.backgroundColor = UIColor.darkGray
        view.placeholder = "分享新鲜事..."
        view.placeholderFont = UIFont.systemFont(ofSize: 16)
        view.font = UIFont.systemFont(ofSize: 16)
        view.delegate = self
        return view
    }()
    lazy var pictureView: WBReleasePictureView = {
        let view = WBReleasePictureView()
        return view
    }()
    
    lazy var emoticonView: WBReleaseEmoticonView = {
        let view = WBReleaseEmoticonView()
        view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 300)
        view.deletage = self
        return view
    }()
    
    lazy var toolView: WBReleaseToolView = {
        let view = WBReleaseToolView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        scrollView.backgroundColor = UIColor.red
        view.addSubview(scrollView)
        
        contentView.backgroundColor = UIColor.yellow
        scrollView.addSubview(contentView)
        
        contentView.addSubview(textView)
        contentView.addSubview(pictureView)
        
        
        view.addSubview(toolView)
        

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(toolView.snp.top)
        }
        contentView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(150)
        }
        pictureView.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
        
        toolView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(88)
        }

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowNotification(node:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideNotification(node:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupNavBar(){
        weak var weakSelf = self
        navBar.barBackgroundImage = nil
        navBar.backgroundColor = UIColor.color(r: 245, g: 245, b: 245)
        navBar.title = "发微博"
        navBar.titleLabelColor = UIColor.color(r: 38, g: 38, b: 38)
        navBar.wr_setLeftButton(title: "取消", titleColor: UIColor.color(r: 38, g: 38, b: 38))
        navBar.leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        navBar.onClickLeftButton = {
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        
        navBar.wr_setRightButton(title: "发送", titleColor: UIColor.white)
        navBar.rightButton.setBackgroundImage(UIImage.init(named: "newfollowimg_3"), for: .normal)
        navBar.rightButton.isEnabled = false
        let rightButtonFrame = CGRect.init(x: SCREEN_WIDTH - 70, y: STATUS_BAR_HEIGHT+10, width: 56, height: 24)
        navBar.rightButton.frame = rightButtonFrame
        navBar.rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        navBar.onClickRightButton = {
            weakSelf?.view.endEditing(false)
        }
    }

    
    @objc func keyboardWillShowNotification(node : Notification){
        keyboardFrameWillChange(node: node, isShow: true)
    }
    
    @objc func keyboardWillHideNotification(node : Notification){
        keyboardFrameWillChange(node: node, isShow: false)
    }
    
    func keyboardFrameWillChange(node : Notification,isShow:Bool){
        // 1.获取动画执行的时间
        let duration = node.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        // 2.获取键盘最终 Y值
        let endFrame = (node.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        toolView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-(SCREEN_HEIGHT - endFrame.origin.y))
            if isShow {
                make.height.equalTo(44)
            }else{
                make.height.equalTo(88)
            }
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

}

// MARK: UITextView代理
extension WBReleaseViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        navBar.rightButton.isEnabled = textView.text.length > 0
    }
    
}


// MARK: 发布工具代理
extension WBReleaseViewController: WBReleaseToolViewDelegate{
    func pictureButtonClick(sender: UIButton) {
        let pickerController = DKImagePickerController()
        DKImagePickerControllerResource.customLocalizationBlock = { title in
            if title == "picker.select.title" {
                return "下一步(%@)"
            } else {
                return nil
            }
        }
        
        weak var weakSelf = self
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            weakSelf?.pictureView.snp.updateConstraints { make in
                
            }
            weakSelf?.pictureView.assets = assets
        }

        self.present(pickerController, animated: true) {
            
        }
    }
    
    func emoticonButtonClick(sender: UIButton) {
        if sender.isSelected {
            textView.inputView = emoticonView
        }else{
            textView.inputView = nil
        }
        UIView.performWithoutAnimation {
            self.textView.resignFirstResponder()
            self.textView.becomeFirstResponder()
        }
    }
}

// MARK: 表情工具代理
extension WBReleaseViewController: WBReleaseEmoticonViewDelegate{
    func emoticonAction(emoticon: WBEmoticon) {
        
        if emoticon.remove {
            textView.deleteBackward()
            return
        }
        textView.inserEmoticonView(em: emoticon)
    }
}
