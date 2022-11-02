//
//  DebugSettingsDemo.swift
//  
//
//  Created by joker on 2022/10/29.
//

import Foundation
#if canImport(ObjcBridge)
import ObjcBridge
#endif


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
                            type: .switch,
                            switchValueChangeAction: switchValueChangeAction)
                    }
                    let entryButtonItems = SettingsEntryButtonId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
                            detailDescription: "description description description description description description description description description description description description description description description description description description",
                            type: .button,
                            buttonClickAction: buttonClickAction)
                    }
                    let entrySubPageItems = SettingsEntrySubPageId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                        let entryId = sectionId.append(entryIdRawValue)
                        return SettingsEntryItem(
                            id: entryId ,
                            title: entryIdRawValue,
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
