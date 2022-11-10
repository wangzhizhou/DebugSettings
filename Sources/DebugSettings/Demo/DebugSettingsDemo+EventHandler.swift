//
//  File.swift
//  
//
//  Created by joker on 2022/10/30.
//

import UIKit
#if canImport(DebugTools)
import DebugTools
#endif

// MARK: 配置项事件处理
extension DebugSettingsDemo {
    /// 处理设置项开关类处理事件
    /// - Parameters:
    ///   - entryItem: 设置项数据模型
    ///   - isOn: 开关是否打开
    ///   - type: 值变化的类型
    static func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchActionType) {
        
        switch entryItem.id {
        case SettingsPage.main.entryId(for: .switch1):
            print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        case SettingsPage.swiftui.entryId(for: .switch1):
            print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        default:
            print("other switch change")
        }
    }
    
    /// 处理按钮类设置项的事件处理器
    /// - Parameter entryItem: 设置项数据模型
    static func buttonClickAction(_ entryItem: SettingsPageEntryModel) {
        switch entryItem.id {
        case SettingsPage.main.entryId(for: .button1):
            LocalPushDemoPage.show()
        case SettingsPage.main.entryId(for: .button2):
            print("id: \(entryItem.id) action")            
        case SettingsPage.subpage.entryId(for: .button1):
            entryItem.subtitle = "刷新了页面后的subtitle"
            SettingsManager.refreshPage(for: SettingsPage.subpage.rawValue)
        case SettingsPage.swiftui.entryId(for: .button1):
            print("id: \(entryItem.id) action")
        default:
            print("other button action")
        }
    }
    
    /// 处理跳转子页面事件
    /// - Parameter entryItem: 设置项数据模型
    static func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {
        switch entryItem.id {
        case SettingsPage.main.entryId(for: .subpage1):
            print("id: \(entryItem.id) subpage jump")
            from?.navigationController?.pushViewController(subpage(), animated: true)
        case SettingsPage.main.entryId(for: .subpage2):
            if #available(iOS 13, *) {
                from?.navigationController?.pushViewController(swiftUIPage(), animated: true)
            }
        case SettingsPage.swiftui.entryId(for: .subpage1):
            print("id: \(entryItem.id) subpage jump")
        default:
            print("other subpage jump")
        }
    }
}
