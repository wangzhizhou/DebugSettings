//
//  SwiftDebugSettingsPage+EventHandler.swift
//  FHDebug
//
//  Created by joker on 2022/11/11.
//

import Foundation

/// 处理Switch开关事件
extension SwiftDebugSettingsPage {
    /// 处理开关值变化事件
    open class func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) {}
    
    /// 处理switch开关项点击时的事
    open class func switchClickAction(_ entryItem: SettingsPageEntryModel) {}
}

/// 处理Button点击事件
extension SwiftDebugSettingsPage {
    /// 处理按钮类设置项的事件处理器
    /// - Parameter entryItem: 设置项数据模型
    open class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {}
}

/// 处理跳转子页面事件
extension SwiftDebugSettingsPage {
    /// 处理跳转子页面事件
    /// - Parameter entryItem: 设置项数据模型
    open class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {}
}
