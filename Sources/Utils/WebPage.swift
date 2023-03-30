//
//  WebPage.swift
//  DebugSettings
//
//  Created by joker on 2023/3/30.
//

import UIKit
import WebKit
import SnapKit
#if canImport(Toast)
import Toast
#endif
#if canImport(Toast_Swift)
import Toast_Swift
#endif
public class WebPage: UIViewController, WKUIDelegate {
    
    public var pageURL: URL?
    
    public var navigationBarHeight: Int = 0
    
    private var webView: WKWebView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(navigationBarHeight)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            }
        }
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage.leftArrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        guard let pageURL = pageURL else {
            return
        }
        let myRequest = URLRequest(url: pageURL)
        webView.load(myRequest)
    }
    
    @objc func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
