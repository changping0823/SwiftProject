//
//  WBReleaseToolView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/12.
//

import UIKit

class WBReleaseToolView: UIView {
    
    weak var delegate: WBReleaseToolViewDelegate?
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.color(r: 215, g: 215, b: 215)
        return view
    }()
    
    lazy var pictureBtn  = toolButton(imageName: "compose_toolbar_picture", tag: 0)
    lazy var userBtn     = toolButton(imageName: "compose_mentionbutton_background", tag: 1)
    lazy var topicBtn    = toolButton(imageName: "compose_trendbutton_background", tag: 2)
    lazy var gifBtn      = toolButton(imageName: "compose_gifbutton_background", tag: 3)
    lazy var emoticonBtn = toolButton(imageName: "compose_emoticonbutton_background", tag: 4)
    lazy var moreBtn     = toolButton(imageName: "compose_toolbar_more", tag: 5)

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.color(r: 242, g: 242, b: 242)
        addSubview(dividerView)
        
        addSubview(pictureBtn)
        addSubview(userBtn)
        addSubview(topicBtn)
        addSubview(gifBtn)
        emoticonBtn.setImage(UIImage.init(named: "compose_keyboardbutton_background"), for: .selected)
        addSubview(emoticonBtn)
        addSubview(moreBtn)

        /// 添加布局约束
        makeConstraints()

    }
    
    func makeConstraints() {
        dividerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        pictureBtn.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(userBtn)
        }
        userBtn.snp.makeConstraints { make in
            make.left.equalTo(pictureBtn.snp.right)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(topicBtn)
        }
        topicBtn.snp.makeConstraints { make in
            make.left.equalTo(userBtn.snp.right)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(gifBtn)
        }
        gifBtn.snp.makeConstraints { make in
            make.left.equalTo(topicBtn.snp.right)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(emoticonBtn)
        }
        emoticonBtn.snp.makeConstraints { make in
            make.left.equalTo(gifBtn.snp.right)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(moreBtn)
        }
        moreBtn.snp.makeConstraints { make in
            make.left.equalTo(emoticonBtn.snp.right)
            make.centerY.right.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(pictureBtn)
        }
    }
    
    func toolButton(imageName: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: .normal)
        button.tag = tag
        button.addTarget(self, action: #selector(toolButtonClick(sender:)), for: .touchUpInside)
        return button
    }
    
    @objc func toolButtonClick(sender: UIButton){
        if sender.tag == 0 {
            self.delegate?.pictureButtonClick(sender: sender)
        }
        if sender.tag == 4 {
            sender.isSelected = !sender.isSelected
            self.delegate?.emoticonButtonClick(sender: sender)
        }
    }

}



// 代理
protocol WBReleaseToolViewDelegate: NSObjectProtocol {
    // 表情点击事件
    func emoticonButtonClick(sender: UIButton)
    func pictureButtonClick(sender: UIButton)
}

