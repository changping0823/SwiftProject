//
//  PAHomeViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/8/19.
//

import UIKit
import ESPullToRefresh

class PAHomeViewController: PABaseViewController {
    
    let headerView = HomeHeaderView()
    
    let tableView = UITableView()
    
    var dataArray: [Article] = []
    
    var pageIndex: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = "玩安卓"
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200)
        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HomeCellId")
        view.addSubview(tableView)
        
        
        tableView.es.addPullToRefresh() { [weak self] in
            self?.requestTopArticle()
            self?.requestBanner()
        }
        tableView.es.addInfiniteScrolling() { [weak self] in
            self?.requestArticleList(refresh: false)
        }
        tableView.es.startPullToRefresh()
        
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.init(top: NAVIGATION_HEIGHT, left: 0, bottom: 0, right: 0))
        }
        
    }
    
    func requestTopArticle() {
        PARequest(PAApi.topArticle, modelType: [Article].self, successCallback:{ (topArticles, _) in
            topArticles.forEach { (article) in
                article.isTop = true
            }
            self.dataArray = topArticles
            self.requestArticleList(refresh: true)
        })
    }
    func requestArticleList(refresh: Bool) {
        if refresh {
            pageIndex = 0;
        }
        PARequest(PAApi.articleList(page: pageIndex), modelType: ArticleModel.self, successCallback:  { (articleModel,responseModel) in
            guard let datas = articleModel.datas, datas.count > 0 else {
                return
            }
            if refresh {
                self.tableView.es.stopPullToRefresh()
            }else{
                self.tableView.es.stopLoadingMore()
            }
            self.dataArray.append(contentsOf: datas)
            self.pageIndex += 1;
            self.tableView.reloadData()
        },failureCallback:{ response in
            if refresh {
                self.tableView.es.stopPullToRefresh()
            }else{
                self.tableView.es.stopLoadingMore()
            }
        })
        
    }
    
    func requestBanner() {
        PARequest(PAApi.homeBanner, modelType: [PABanner].self, successCallback:{ (banners, _) in
            self.headerView.dataArray = banners
        })
    }
    
}

extension PAHomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ArticleCell(style: .default, reuseIdentifier: "HomeCellId")
        cell.setModel(article: self.dataArray[indexPath.row])
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webViewController = WebViewController(withUrl: self.dataArray[indexPath.row].link)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
}

