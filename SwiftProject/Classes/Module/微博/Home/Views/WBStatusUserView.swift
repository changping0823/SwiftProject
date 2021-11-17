//
//  WBStatusUserView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/8.
//

import UIKit

class WBStatusUserView: UIView {
    lazy var iconView: UIButton = {
        let icon = UIButton()
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 20;
        icon.layer.borderColor = UIColor.lightGray.cgColor
        icon.layer.borderWidth = 0.5
        return icon
    }()
    lazy var verifiedView: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "avatar_vip"))
        imageView.isHidden = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8;
        return imageView
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var centerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(white: 0, alpha: 0.5)
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(white: 0, alpha: 0.5)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(centerView)
        addSubview(nicknameLabel)
        addSubview(timeLabel)
        addSubview(verifiedView)
        addSubview(sourceLabel)
        
        iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
        verifiedView.snp.makeConstraints { make in
            make.bottom.right.equalTo(iconView).offset(3)
            make.size.equalTo(CGSize.init(width: 16, height: 16))
            
        }
        centerView.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalTo(iconView)
            make.size.equalTo(CGSize.init(width: 20, height: 5))
        }
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(centerView)
            make.bottom.equalTo(centerView.snp.top)
        }
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(centerView)
            make.top.equalTo(centerView.snp.bottom)
        }
        sourceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp.right).offset(5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private var _status: WBStatuses?
    var status: WBStatuses? {
        set{
            _status = newValue
            iconView.setImage(with: _status?.user?.avatar_large, placeholder: UIImage.init(named: "avator_default"), for: .normal)
            guard let verified = _status?.user?.verified else {
                verifiedView.isHidden = true
                return
            }
            verifiedView.isHidden = !verified
            
            nicknameLabel.text = _status?.user?.name
            guard let created_at = _status?.created_at else {
                return
            }
            timeLabel.text = Date.customDate(date: created_at)
            sourceLabel.text = _status?.showSource

            
        }
        get{
            return _status
        }
    }





    
}
