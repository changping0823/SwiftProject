//
//  HomeHeaderView.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/18.
//

import UIKit
import FSPagerView
import Kingfisher

class HomeHeaderView: UIView {
    
    lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.dataSource = self
        pagerView.delegate = self
        /// 循环间隔
        pagerView.automaticSlidingInterval = 3.0
        /// 是否无限循环
        pagerView.isInfinite = true
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()
    
    var dataArray = [PABanner]() {
        didSet {
            self.pagerView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.randomColor
        self.addSubview(pagerView)
        
        pagerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


extension HomeHeaderView: FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        dataArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.setImage(with: dataArray[index].imagePath)
        cell.textLabel?.text = dataArray[index].title
        return cell
    }
    
}


extension HomeHeaderView: FSPagerViewDelegate{
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let webViewController = WebViewController(withUrl: self.dataArray[index].url)
        navigationController?.pushViewController(webViewController, animated: true)
    }
}
