//
//  SwiftDebugSettingsPage.swift
//  FHDebug
//
//  Created by joker on 2022/11/11.
//

import Foundation
import UIKit
#if canImport(Toast)
import Toast
#endif
#if canImport(Toast_Swift)
import Toast_Swift
#endif

@objcMembers
open class SwiftDebugSettingsPage: NSObject, SwiftDebugSettingsPageProtocol {
    /// 定义pageId，子类可覆盖
    open class var pageId: String {
        if let bundleId = Bundle.main.bundleIdentifier {
            return "\(bundleId).debug.settings.page"
        }
        else {
            fatalError("需要为页面定义一个唯一Id，例如：com.debug.settings.demo.empty.page")
        }
    }
    /// DSL定义页面模型，子类可覆盖
    open class var pageModel: SettingsPageModel {
        fatalError("子类需要覆盖这个只读计算属性，定义页面内容，可参考：DebugSettingsDemo.mainPage方法中的示例")
    }
    
    public static weak var weakPage: SettingsUIKitPage?
    
    public static func setup() {
        // 触发一个数据模型创建过程，用来在启动时初始化调试选项逻辑
        _ = pageModel
    }
    
    open class func show() {
        let topVC = UIViewController.topViewController()
        if topVC is SettingsUIKitPage {
            return
        }
        let page = SettingsUIKitPage(pageModel: pageModel)
        weakPage = page
        page.pushOnTopViewController()
    }
    
    public static func showToast(_ message: String) {
        UIViewController.topViewController()?.view.makeToast(message, duration: 3, position: .center)
    }
    
    private override init() {}
    
}
