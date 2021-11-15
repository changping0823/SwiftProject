//
//  WBReleaseViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/11.
//

import UIKit

class WBReleaseViewController: WBBaseViewController {

    lazy var textView: XMTextView = {
        let view = XMTextView()
        view.placeholder = "分享新鲜事..."
        view.placeholderFont = UIFont.systemFont(ofSize: 16)
        view.font = UIFont.systemFont(ofSize: 16)
        view.delegate = self
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
        view.addSubview(textView)
        view.addSubview(toolView)
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(navBar.snp.bottom)
            make.bottom.equalTo(toolView.snp.top)
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
        let rightButtonFrame = CGRect.init(x: SCREEN_WIDTH - 70, y: STATUS_BAR_HEIGHT+10, width: 56, height: 24)
        navBar.rightButton.frame = rightButtonFrame
        navBar.rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        navBar.onClickRightButton = {
            self.view.endEditing(false)
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

    }
    
}


// MARK: 发布工具代理
extension WBReleaseViewController: WBReleaseToolViewDelegate{
    func pictureButtonClick(sender: UIButton) {
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
