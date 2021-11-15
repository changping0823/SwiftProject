//
//  WKWebViewController.swift
//  SwiftProject
//
//  Created by Charles on 2021/11/4.
//

import UIKit
import WebKit

class WKWebViewController: CustomNavigationViewController {

    lazy var webView: WKWebView = {
        let web = WKWebView()
        web.navigationDelegate = self
        return web
    }()
    
    open func loadURLWithString(_ URLString: String) {
        if let URL = URL(string: URLString) {
            if (URL.scheme != "") && (URL.host != nil) {
                loadURL(URL)
            } else {
                loadURLWithString("http://\(URLString)")
            }
        }
    }
    
    open func loadURL(_ URL: Foundation.URL, cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 0) {
        webView.load(URLRequest(url: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        /// 设置访问的URL
//        let url = NSURL(string: "http://www.jianshu.com/u/37fe1e005f6c")
//        /// 根据URL创建请求
//        let requst = NSURLRequest(url: url! as URL)
//        webView.load(requst as URLRequest)
//        webView.frame = view.bounds
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalToSuperview().offset(NAVIGATION_HEIGHT)
        }
        
    }
    
}



extension WKWebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        /// 获取网页title
        navBar.title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        let responseUrl = navigationResponse.response.url
        
        print(responseUrl!.absoluteString)
        if responseUrl!.absoluteString.hasPrefix(WeiboRedirectUrl) {
            // 继续加载
            // 2.判断是否授权成功
            let codeStr = "code="
            if responseUrl!.query!.hasPrefix(codeStr) {
                // 授权成功
                let code = String(responseUrl?.query?[codeStr.endIndex...] ?? "")
                print(code)
                request(WeiboApi.accessToken(code: code), modelType: WBAccess.self) { access, respone in
                    WBAccountTool.saveAccess(access: access)
                }
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)

    }
    // 返回 true正常加载  false不加载
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool{
//
//        /*
//         加载授权界面
//         https://api.weibo.com/oauth2/authorize?client_id=2202957917&redirect_uri=http://www.jianshu.com/u/8fed18ed70c9
//         跳转到授权界面
//         https://api.weibo.com/oauth2/authorize
//         授权成功
//         http://www.jianshu.com/u/8fed18ed70c9?code=ed9df4b69d51158ad03d15a72ea8fa65
//         取消授权
//         http://www.jianshu.com/u/8fed18ed70c9?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
//         */
//
//
//    }
}


