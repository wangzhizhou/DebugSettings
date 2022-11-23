//
//  SwiftDebugSettingsPage+EventHandler.swift
//  FHDebug
//
//  Created by joker on 2022/11/11.
//

import Foundation
import UIKit

extension SwiftDebugSettingsPage {
    
    /// 处理开关值变化事件
    /// - Parameter entryItem: 开关类调试选项数据模型
    /// - Parameter isOn: 开关状态是否打开
    /// - Parameter type: 开关值变化时的类型
    open class func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) {}
    
    /// 处理switch开关项点击时的事件
    /// - Parameter entryItem: 开关类调试选项数据模型
    open class func switchClickAction(_ entryItem: SettingsPageEntryModel) {}
}

extension SwiftDebugSettingsPage {
    
    /// 处理按钮类设置项的事件处理器
    /// - Parameter entryItem: 按钮类调试选项数据模型
    open class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {}
}

extension SwiftDebugSettingsPage {
    
    /// 处理跳转子页面事件
    /// - Parameter entryItem: 子页面类设置项数据模型
    /// - Parameter from: 发生跳转时所在的页面VC
    open class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {}
}
