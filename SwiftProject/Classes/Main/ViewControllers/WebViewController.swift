//
//  WebViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/9/27.
//

import UIKit
import WebKit

class WebViewController: CustomNavigationViewController {
    
    lazy var webView: WKWebView = {
        let view = WKWebView(frame: CGRect.zero, configuration: configuration)
        return view
    }()
    
    let configuration = WKWebViewConfiguration()
    var url: String?

    init(withUrl url: String?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    open func loadURLWithString(_ URLString: String?) {
        guard let urlString = URLString else {
            return
        }
        guard let URL = URL(string: urlString) else {
            return
        }
        if (URL.scheme != "") && (URL.host != nil) {
            loadURL(URL)
        } else {
            loadURLWithString("http://\(urlString)")
        }
    }
    
    open func loadURL(_ URL: Foundation.URL, cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 0) {
        webView.load(URLRequest(url: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        loadURLWithString(self.url)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.init(top: NAVIGATION_HEIGHT, left: 0, bottom: 0, right: 0))
        }
    }
}
