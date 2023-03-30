//
//  WebPage.swift
//  DebugSettings
//
//  Created by joker on 2023/3/30.
//

import UIKit
import WebKit

class WebPage: UIViewController, WKUIDelegate {
    
    var pageURL: URL?
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pageURL = pageURL else {
            return
        }
        let myRequest = URLRequest(url: pageURL)
        webView.load(myRequest)
    }
}
