//
//  WBReleaseEmoticonView.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/12.
//

import UIKit


class WBReleaseEmoticonCell: UICollectionViewCell {
    private var _emoticon: WBEmoticon?
    
    private var iconView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconView)
        
        iconView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 30, height: 30))
        })
    }
    
    var emoticon: WBEmoticon? {
        get {
            return _emoticon
        }
        set {
            _emoticon = newValue
          
            guard let icon = _emoticon?.png else {
                iconView.image = nil
                return
            }
            iconView.image = UIImage.init(named: icon)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WBReleaseEmoticonFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let col: CGFloat = 7
        
        let width: CGFloat = (collectionView?.bounds.width)! / col
        let height: CGFloat = 40
        let margin: CGFloat = 15
        
        itemSize = CGSize(width: width, height: height)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

class WBReleaseEmoticonView: UIView {
    
    weak var deletage: WBReleaseEmoticonViewDelegate?
    
    fileprivate var emoticons: [WBEmoticon] = []
    
    fileprivate lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.color(r: 215, g: 215, b: 215)
        return view
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collect = UICollectionView(frame: CGRect.zero, collectionViewLayout: WBReleaseEmoticonFlowLayout())
        collect.backgroundColor = UIColor.color(r: 242, g: 242, b: 242)
        collect.delegate = self
        collect.dataSource = self
        collect.register(WBReleaseEmoticonCell.self, forCellWithReuseIdentifier: "WBReleaseEmoticonCell")
        return collect
    }()
    fileprivate var pageView:UIPageControl!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.color(r: 242, g: 242, b: 242)
        addSubview(dividerView)
        addSubview(collectionView)
        //初始化UIPageControl
        pageView = UIPageControl()
        //设置小白点数
        pageView.numberOfPages = 2
        //默认小白点位置
        pageView.currentPage = 0
        pageView.pageIndicatorTintColor = UIColor.color(r: 218, g: 218, b: 218)
        pageView.currentPageIndicatorTintColor = UIColor.color(r: 252, g: 108, b: 8)
        addSubview(pageView)

        
        /// 获取表情数组
        let emptArray = WBEmoticonManager.shared.emoticons
        var index = 0
        for emoticon in emptArray {
            if emoticon.png != nil {
                emoticons.append(emoticon)
                index += 1
                // 添加删除按钮
                if index == 20 {
                    let delete = WBEmoticon()
                    delete.remove = true
                    delete.png = "DeleteButton-normal"
                    emoticons.append(delete)
                    index = 0
                }
            }
        }
        addEmpty()
        
        
        
        //设置小白点数
        pageView.numberOfPages = emoticons.count/21
        
        dividerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(180)
        }
        pageView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
        }
    }
    
    /// 添加空白按钮
    private func addEmpty() {
        let count = emoticons.count % 21
      
        // 有表情并且能被整除不添加
        if emoticons.count > 0 && count == 0 {
            return
        }
        for _ in count..<20 {
            let empty = WBEmoticon()
            empty.remove = false
            empty.png = ""
            emoticons.append(empty)
        }
        let delete = WBEmoticon()
        delete.remove = true
        delete.png = "DeleteButton-normal"
        emoticons.append(delete)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension WBReleaseEmoticonView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoticon = emoticons[indexPath.row]
        deletage?.emoticonAction(emoticon: emoticon)
    }
}

extension WBReleaseEmoticonView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = floor((scrollView.contentOffset.x - bounds.width/2)/bounds.width+1)
        pageView.currentPage = Int(page)
    }
}

extension WBReleaseEmoticonView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WBReleaseEmoticonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WBReleaseEmoticonCell", for: indexPath) as! WBReleaseEmoticonCell
        cell.emoticon = emoticons[indexPath.row]
        return cell
    }
}



// 代理
protocol WBReleaseEmoticonViewDelegate: NSObjectProtocol {
    // 表情点击事件
    func emoticonAction(emoticon: WBEmoticon)
}

