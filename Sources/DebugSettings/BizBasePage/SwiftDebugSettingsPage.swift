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

/// 业务侧调试设置页面继承的基类，封装了通用能力，部分API由子类覆盖
@objcMembers
open class SwiftDebugSettingsPage: NSObject, SwiftDebugSettingsPageProtocol {
    
    /// 定义pageId，子类覆盖实现，这里的默认值为兜底
    open class var pageId: String {
        if let bundleId = Bundle.main.bundleIdentifier {
            return "\(bundleId).debug.settings.page"
        }
        else {
            fatalError("需要为页面定义一个唯一Id，例如：com.debug.settings.demo.empty.page")
        }
    }
    
    /// 子类必须覆盖实现，创建自已的调试选项页面数据模型
    open class var pageModel: SettingsPageModel {
        fatalError("子类需要覆盖这个只读计算属性，定义页面内容，可参考：DebugSettingsDemo.mainPage方法中的示例")
    }
    
    /// 对调试页面VC的弱引用，用来方便的调用页面VC相关的方法
    public static weak var weakPage: SettingsUIKitPage?
    
    /// 触发页面数据模型创建，用于调试页面数据初始化操作，一般在App启动时调用
    public static func setup() {
        
        beforeSetup()
        
        // 触发一个数据模型创建过程，用来在启动时初始化调试选项逻辑
        _ = pageModel
        
        afterSetup()
    }
    
    /// 展示调试选项页面，业务在需要跳转展示调试页面时调用
    open class func show() {
        let topVC = UIViewController.topViewController()
        if let uikitVC = topVC as? SettingsUIKitPage, pageModel.id == uikitVC.pageModel.id {
            return
        }
        beforeShow()
        let page = SettingsUIKitPage(pageModel: pageModel)
        weakPage = page
        page.pushOnTopViewController()
        afterShow()
    }
    

    
    
    
    /// 在调试页面展示Toast提示
    /// - Parameter message: Toast提示内容
    public static func showToast(_ message: String) {
        UIViewController.topViewController()?.view.makeToast(message, duration: 3, position: .center)
    }
    
    /// 防止被实例化，限制只使用类方法
    private override init() {}
    
}


extension SwiftDebugSettingsPage {
    
    open class func beforeSetup() {
        
    }
    
    open class func afterSetup() {
        
    }
    
    open class func beforeShow() {
        
    }
    
    open class func afterShow() {
        
    }
}
