//
//  WBHomeViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/3.
//


import UIKit
import ESPullToRefresh
import DropDown

class WBHomeViewController: WBBaseViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .plain)
        weak var weakSelf = self
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(WBStatusCell.self, forCellReuseIdentifier: "WBStatusCell")
        return table
    }()
    
    let titles = ["写微博", "图片", "视频", "微评", "直播"]
    let images = [UIImage(named: "timeline_card_small_article"),
                  UIImage(named: "timeline_card_small_groupcard"),
                  UIImage(named: "timeline_card_small_video"),
                  UIImage(named: "timeline_card_small_profile"),
                  UIImage(named: "timeline_card_small_web")]
    
    lazy var menuView1: FWMenuView = {
        
        let vProperty = FWMenuViewProperty()
        vProperty.popupCustomAlignment = .topRight
        vProperty.popupAnimationType = .scale
        vProperty.maskViewColor = UIColor.clear
        vProperty.touchWildToHide = "1"
        vProperty.popupViewEdgeInsets = UIEdgeInsets(top: NAVIGATION_HEIGHT, left: 0, bottom: 0, right: 10)
        vProperty.topBottomMargin = 0
        vProperty.animationDuration = 0.3
        vProperty.popupArrowStyle = .round
        vProperty.popupArrowVertexScaleX = 1
        vProperty.backgroundColor = UIColor.color(r: 64, g: 63, b: 66)
        vProperty.splitColor = UIColor.color(r: 64, g: 63, b: 66)
        vProperty.separatorColor = UIColor.color(r: 91, g: 91, b: 93)
        vProperty.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.backgroundColor: UIColor.clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)]
        vProperty.textAlignment = .left
        vProperty.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        weak var weakSelf = self
        let menuView = FWMenuView.menu(itemTitles: titles, itemImageNames: images as? [UIImage], itemBlock: { (popupView, index, title) in
            print("Menu：点击了第\(index)个按钮")
            weakSelf?.present(WBReleaseViewController(), animated: true, completion: nil)
        }, property: vProperty)
        
        return menuView
    }()
    
    var homeStatuses:[WBStatuses] = []
    var page: Int = 1
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.wr_setRightButton(image: UIImage.init(named: "navigationbar_icon_compose")!)
        weak var weakSelf = self
        navBar.onClickRightButton = {
            weakSelf?.menuView1.show()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navBar.snp.bottom)
        }

        tableView.es.addPullToRefresh {
            [unowned self] in
            page = 1
            loadData(refresh: true)
        }
        
        tableView.es.addInfiniteScrolling {
            [unowned self] in
            /// 在这里做加载更多相关事件
            page += 1
            loadData(refresh: false)
        }
        tableView.es.startPullToRefresh()
        
    }
    
    func loadData(refresh: Bool) {
        PARequest(WeiboApi.statusesHomeTimeline(20, page), modelType: WBHomeTimeline.self, successCallback:{ (timeline, _) in
            guard let datas:[WBStatuses] = timeline.statuses, datas.count > 0 else {
                return
            }
            if refresh {
                self.homeStatuses = datas
                self.tableView.es.stopPullToRefresh()
            }else{
                self.homeStatuses.append(contentsOf: datas)
                /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
                self.tableView.es.stopLoadingMore()
            }
            self.tableView.reloadData()
        })
    }

}



extension WBHomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(WBStatusDetailViewController(), animated: true)
    }
}

extension WBHomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.homeStatuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WBStatusCell(style: .default, reuseIdentifier: "WBStatusCell")
        cell.status = homeStatuses[indexPath.row]
        return cell
    }
}
