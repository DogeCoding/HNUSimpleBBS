//
//  NewsDetailController.swift
//  FeedsTest
//
//  Created by CodingDoge on 2018/1/2.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

import UIKit
import WebKit

// 军事新闻详情页 直接用WK显示了😶
class MilitaryNewsDetailViewController: UIViewController {
    
    var article_url = ""
    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(webView)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: article_url)!))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.snp.makeConstraints{ (make) -> Void in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}

extension MilitaryNewsDetailViewController: WKUIDelegate, WKNavigationDelegate {
    
}
