//
//  File.swift
//  
//
//  Created by joker on 2022/10/30.
//

import UIKit

// MARK: 配置项事件处理
extension DebugSettingsDemo {
    /// 处理设置项开关类处理事件
    /// - Parameters:
    ///   - entryItem: 设置项数据模型
    ///   - isOn: 开关是否打开
    ///   - type: 值变化的类型
    static func switchValueChangeAction(_ entryItem: SettingsEntryItem, _ isOn: Bool, _ type: SettingsEntrySwitchActionType) {
        
        let mainPageIdSection1 = SettingsIdentifier(segs: [SettingsPageId.main.rawValue]).append(SettingsSectionId.Section1.rawValue)
        switch entryItem.id {
        case mainPageIdSection1.append(SettingsEntrySwitchId.switch1.rawValue):
            print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        default:
            print("other switch change")
        }
    }
    
    
    /// 处理按钮类设置项的事件处理器
    /// - Parameter entryItem: 设置项数据模型
    static func buttonClickAction(_ entryItem: SettingsEntryItem) {
        let mainPageIdSection1 = SettingsIdentifier(segs: [SettingsPageId.main.rawValue]).append(SettingsSectionId.Section1.rawValue)
        switch entryItem.id {
        case mainPageIdSection1.append(SettingsEntryButtonId.button1.rawValue):
            print("id: \(entryItem.id) action")
        default:
            print("other button action")
        }
    }
    
    
    /// 处理跳转子页面事件
    /// - Parameter entryItem: 设置项数据模型
    static func subpageJumpAction(_ entryItem: SettingsEntryItem, _ from: UIViewController) {
        let mainPageIdSection1 = SettingsIdentifier(segs: [SettingsPageId.main.rawValue]).append(SettingsSectionId.Section1.rawValue)
        switch entryItem.id {
        case mainPageIdSection1.append(SettingsEntrySubPageId.page1.rawValue):
            print("id: \(entryItem.id) subpage jump")
            from.navigationController?.pushViewController(subpage(), animated: true)
        case mainPageIdSection1.append(SettingsEntrySubPageId.page2.rawValue):
            from.navigationController?.pushViewController(swiftUIPage(), animated: true)
        default:
            print("other subpage jump")
        }
    }
}
