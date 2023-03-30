//
//  WebPage.swift
//  DebugSettings
//
//  Created by joker on 2023/3/30.
//

import UIKit
import WebKit

public class WebPage: UIViewController, WKUIDelegate {
    
    public var pageURL: URL?
    
    private var webView: WKWebView!
    
    public override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        guard let pageURL = pageURL else {
            return
        }
        let myRequest = URLRequest(url: pageURL)
        webView.load(myRequest)
    }
}
