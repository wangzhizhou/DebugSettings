//
//  WebPage.swift
//  DebugSettings
//
//  Created by joker on 2023/3/30.
//

import UIKit
import WebKit
#if canImport(Toast)
import Toast
#endif
#if canImport(Toast_Swift)
import Toast_Swift
#endif
public class WebPage: BasePage {
    
    public var pageURL: URL?
    
    private var webView: WKWebView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        adjustFullPageView(webView)
        guard let pageURL = pageURL else {
            return
        }
        let myRequest = URLRequest(url: pageURL)
        webView.load(myRequest)
    }
}

extension WebPage: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        view.makeToastActivity(.center)
    }
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.hideToastActivity()
    }
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        view.hideToastActivity()
    }
}
