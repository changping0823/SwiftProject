//
//  WBStatusToolView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/9.
//

import UIKit

class WBStatusToolView: UIView {

    lazy var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.color(r: 223, g: 223, b: 223)
        return view
    }()
    
    lazy var retweetBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "timeline_icon_retweet"), for: .normal)
        button.setTitle("转发", for: .normal)
        button.setTitleColor(UIColor.color(r: 80, g: 80, b: 80), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    lazy var commentBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "timeline_icon_comment"), for: .normal)
        button.setTitle("评论", for: .normal)
        button.setTitleColor(UIColor.color(r: 80, g: 80, b: 80), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    lazy var likeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "timeline_icon_unlike"), for: .normal)
        button.setTitle("赞", for: .normal)
        button.setTitleColor(UIColor.color(r: 80, g: 80, b: 80), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topDivider)
        addSubview(retweetBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)

        topDivider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(0.5)
        }
        
        retweetBtn.snp.makeConstraints { make in
            make.top.equalTo(topDivider.snp.bottom)
            make.left.bottom.equalToSuperview()
            make.width.equalTo(commentBtn)
        }
        commentBtn.snp.makeConstraints { make in
            make.top.equalTo(topDivider.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(retweetBtn.snp.right)
            make.width.equalTo(likeBtn)
        }
        likeBtn.snp.makeConstraints { make in
            make.top.equalTo(topDivider.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalTo(commentBtn.snp.right)
            make.right.bottom.equalToSuperview()
            make.width.equalTo(retweetBtn)
        }
        
    }
    
    
    private var _status: WBStatuses?
    var status: WBStatuses? {
        set{
            _status = newValue
            guard let status = _status else { return }
            if status.reposts_count == 0 {
                retweetBtn.setTitle(" " + "转发", for: .normal)
            }else{
                retweetBtn.setTitle(" \(String(status.reposts_count))", for: .normal)
            }
            
            if status.comments_count == 0 {
                commentBtn.setTitle(" " + "评论", for: .normal)
            }else{
                commentBtn.setTitle(" \(String(status.comments_count))", for: .normal)
            }
            
            if status.attitudes_count == 0 {
                likeBtn.setTitle(" " + "赞", for: .normal)
            }else{
                likeBtn.setTitle(" \(String(status.attitudes_count))", for: .normal)
            }
            
        }
        get{
            return _status
        }
    }

    
}
