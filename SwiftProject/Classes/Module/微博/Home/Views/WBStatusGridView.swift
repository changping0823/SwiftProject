//
//  WBStatusGridView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/10.
//

import UIKit

class WBStatusGridView: UIView {
        
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 以下属性均为默认值，可外部赋值进行修改
    var middleSpace: CGFloat = 5 // 中间间隙
    var imageWH: CGFloat = 120 // NineGridView宽度（根据屏幕宽和当前HxNineGridView需要展示的真实宽度进行调整）
    weak var delegate: WBStatusGridViewDelegate?
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
    }
    
    
       override func layoutSubviews() {
           super.layoutSubviews()
           
           contentView.frame = bounds
           var number = 3
           if imageSrcs.count == 4 {
               number = 2
           }
           for index in 0..<contentView.subviews.count {
               let view = contentView.subviews[index]
               let rows = index/number
               let columns = index%number
               view.frame = CGRect.init(x: Double(columns) * (imageWH + middleSpace), y: Double(rows) * (imageWH + middleSpace), width: imageWH, height: imageWH)
           }
       }
    
    // 图片列表
     var imageSrcs: [WBStatusesPicUrls] = [WBStatusesPicUrls]() {
         didSet {
             addCellViews()
         }
     }
    
    private func addCellViews() {
        while contentView.subviews.count < imageSrcs.count {
            let cellView = UIImageView()
            cellView.contentMode = .scaleAspectFill
            cellView.layer.masksToBounds = true
            cellView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapImageView(_:)))
            cellView.addGestureRecognizer(tap)
            contentView.addSubview(cellView)
        }
        for index in 0..<contentView.subviews.count {
            let view: UIImageView = contentView.subviews[index] as! UIImageView
            view.tag = index
            if index < imageSrcs.count {
                view.isHidden = false
                view.setImage(with: imageSrcs[index].bmiddle_pic, placeholder: UIImage.init(named: "timeline_image_placeholder"))
            }else{
                view.isHidden = true
            }
        }

    }
 
    @objc func onTapImageView(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            self.delegate?.onClickImageView(imageSrcs: self.imageSrcs, index: view.tag)
        }
    }

    
}


// 代理
protocol WBStatusGridViewDelegate: NSObjectProtocol {
    // 图片点击事件
    func onClickImageView(imageSrcs: [WBStatusesPicUrls], index: Int)
}
