//
//  File.swift
//  
//
//  Created by joker on 2022/11/3.
//

#if canImport(SwiftUI)
import SwiftUI

extension DebugSettingsDemo {
    
    static public func swiftUIPage() -> SettingsSwiftUIPage<SettingsView> {
        
        let pageId = SettingsIdentifier(segs: [SettingsPageId.swiftui.rawValue])
        let model = SettingsPageModel(id: pageId, title: "SwiftUI调试选项子页面") {
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
        return SettingsSwiftUIPage(rootView: SettingsView(model: model))
    }
}

#endif
