//
//  DebugSettingsDemo.swift
//  
//
//  Created by joker on 2022/10/29.
//

import Foundation
import ObjcBridge


/// 配置项页面定义
@objcMembers
public class DebugSettingsDemo: ObjcBridgeClass {

    static public func mainPage() -> SettingsPage {
        
        let pageId = SettingsIdentifier(segs: [SettingsPageId.main.rawValue])
        let model = SettingsPageModel(id: pageId, title: "调试页面") {
            let sections = SettingsSectionId.allCases.map { $0.rawValue }.map { sectionIdRawValue in
                let sectionId = pageId.append(sectionIdRawValue)
                return SettingsSectionItem(id: sectionId, title: sectionIdRawValue) {
                    let entrySwitchItems = SettingsEntrySwitchId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
                            subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                            detailDescription: "description description description description description description description description description description description description description description description description description description",
                            type: .switch,
                            switchValueChangeAction: switchValueChangeAction)
                    }
                    let entryButtonItems = SettingsEntryButtonId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
                            subtitle: "只是一个测试按钮 只是一个测试按钮 只是一个测试按钮",
                            detailDescription: "description description description description description description description description description description description description description description description description description description",
                            type: .button,
                            buttonClickAction: buttonClickAction)
                    }
                    let entrySubPageItems = SettingsEntrySubPageId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
                            subtitle: "进入测试子页面 进入测试子页面 进入测试子页面 进入测试子页面 进入测试子页面",
                            detailDescription: "description description description description description description description description description description description description description description description description description description",
                            type: .subpage,
                            subpageJumpAction: subpageJumpAction)
                    }
                    return entrySwitchItems + entryButtonItems + entrySubPageItems
                }
            }
            return sections
        }
        return SettingsPage(pageModel: model)
    }
    
    static public func subpage() -> SettingsPage {
        
        let pageId = SettingsIdentifier(segs: [SettingsPageId.subpage.rawValue])
        let model = SettingsPageModel(id: pageId, title: "调试选项子页面") {
            let sections = SettingsSectionId.allCases.map { $0.rawValue }.map { sectionIdRawValue in
                let sectionId = pageId.append(sectionIdRawValue)
                return SettingsSectionItem(id: sectionId, title: sectionIdRawValue) {
                    let entrySwitchItems = SettingsEntrySwitchId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
                            subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                            detailDescription: "description description description description description description description description description description description description description description description description description description",
                            type: .switch,
                            switchValueChangeAction: switchValueChangeAction)
                    }
                    let entryButtonItems = SettingsEntryButtonId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
                            subtitle: "只是一个测试按钮 只是一个测试按钮 只是一个测试按钮",
                            detailDescription: "description description description description description description description description description description description description description description description description description description",
                            type: .button,
                            buttonClickAction: buttonClickAction)
                    }
                    let entrySubPageItems = SettingsEntrySubPageId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
                            subtitle: "进入测试子页面 进入测试子页面 进入测试子页面 进入测试子页面 进入测试子页面",
                            detailDescription: "description description description description description description description description description description description description description description description description description description",
                            type: .subpage,
                            subpageJumpAction: subpageJumpAction)
                    }
                    return entrySwitchItems + entryButtonItems + entrySubPageItems
                }
            }
            return sections
        }
        return SettingsPage(pageModel: model)
    }
}

// MARK: 配置项事件处理
extension DebugSettingsDemo {
    /// 处理设置项开关类处理事件
    /// - Parameters:
    ///   - entryItem: 设置项数据模型
    ///   - isOn: 开关是否打开
    ///   - type: 值变化的类型
    static func switchValueChangeAction(_ entryItem: SettingsEntryItem, _ isOn: Bool, _ type: SettingsEntrySwitchActionType) {
        
        let mainPageIdSection1 = SettingsIdentifier(segs: [SettingsPageId.main.rawValue]).append(SettingsSectionId.section1.rawValue)
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
        let mainPageIdSection1 = SettingsIdentifier(segs: [SettingsPageId.main.rawValue]).append(SettingsSectionId.section1.rawValue)
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
        let mainPageIdSection1 = SettingsIdentifier(segs: [SettingsPageId.main.rawValue]).append(SettingsSectionId.section1.rawValue)
        switch entryItem.id {
        case mainPageIdSection1.append(SettingsEntrySubPageId.page1.rawValue):
            print("id: \(entryItem.id) subpage jump")
            from.navigationController?.pushViewController(subpage(), animated: true)
        default:
            print("other subpage jump")
        }
    }
}
