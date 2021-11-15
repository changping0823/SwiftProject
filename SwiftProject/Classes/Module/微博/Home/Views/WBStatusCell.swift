//
//  WBStatusCell.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit

import ObjectMapper

class WBStatusCell: UITableViewCell {
    
    lazy var userView = WBStatusUserView()
    lazy var statusView = WBStatusContentView()
    
    lazy var toolView = WBStatusToolView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        
        userView.backgroundColor = UIColor.white
        contentView.addSubview(userView)
        
        statusView.backgroundColor = UIColor.white
        contentView.addSubview(statusView)
        
        toolView.backgroundColor = UIColor.white
        contentView.addSubview(toolView)
        
        userView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(60)
        }
        statusView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        toolView.snp.makeConstraints { make in
            make.top.equalTo(statusView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(36)
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
            userView.status = _status
            toolView.status = _status
            statusView.status = _status
        }
        get{
            return _status
        }
    }
    
}
