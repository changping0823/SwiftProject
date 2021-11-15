//
//  ArticleCell.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/18.
//

import UIKit
import AttributedString
import BSText

class ArticleCell: UITableViewCell {

    var titleLabel: BSLabel = BSLabel()
    /// 分享者/作者（没有作者就是分享者）
    var authorButton : UIButton = UIButton()
    var subTitle : UILabel?


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 32
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        authorButton.titleLabel!.font = UIFont.systemFont(ofSize: 12)
        authorButton.setTitleColor(UIColor.darkGray, for: .normal)
        contentView.addSubview(authorButton)
        
        titleLabel.snp.makeConstraints({ make in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        })

        
        authorButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
    func setModel(article: Article) {
        let titleAttri = NSMutableAttributedString()
        
        if article.isTop {
            let topLabel = self.markLabel(mark: "置顶")
            let attachText = NSMutableAttributedString.bs_attachmentString(with: topLabel, contentMode: .center, attachmentSize: topLabel.frame.size, alignTo: topLabel.font, alignment: .center)
            titleAttri.append(attachText!)
            titleAttri.bs_append(string: " ")
        }
        
        if(article.fresh){
            let freshLabel = self.markLabel(mark: "新")
            let attachText = NSMutableAttributedString.bs_attachmentString(with: freshLabel, contentMode: .center, attachmentSize: freshLabel.frame.size, alignTo: freshLabel.font, alignment: .center)
            
            titleAttri.append(attachText!)
            titleAttri.bs_append(string: " ")
        }

        
        titleAttri.bs_append(string: article.title)
        titleAttri.bs_font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleAttri.bs_lineSpacing = 5
        titleLabel.attributedText = titleAttri

        if let stringCount = article.author?.count, stringCount > 0 {
            authorButton.setTitle("作者：\(article.author!)", for: .normal)
        }else{
            authorButton.setTitle("分享人：\(article.shareUser!)", for: .normal)
        }

    }

    func markLabel(mark: String) -> PaddingLabel {
        let label = PaddingLabel()
        label.text = mark
        label.textColor = UIColor.paRedColor
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.padding = UIEdgeInsets.init(top: 1, left: 4, bottom: 1, right: 4)
        label.layer.borderColor = UIColor.paRedColor.cgColor
        label.layer.borderWidth = 1.0
        label.sizeToFit()
        return label
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
