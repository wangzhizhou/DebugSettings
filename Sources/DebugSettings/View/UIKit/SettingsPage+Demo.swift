//
//  File.swift
//  
//
//  Created by joker on 2022/10/29.
//

import Foundation

enum SettingsPageId: String, CaseIterable {
    case main
}

enum SettingsSectionId: String, CaseIterable {
    case section1
    case section2
    case section3
    case section4
}

enum SettingsEntryId: String, CaseIterable {
    case item1
    case item2
    case item3
    case item4
    case item5
}

public extension SettingsPage {
    static func demoPage() -> SettingsPage {
        
        let pageId = SettingsIdentifier(segs: [SettingsPageId.main.rawValue])
        let sections = SettingsSectionId.allCases.map { $0.rawValue }.map { sectionIdRawValue in
            let sectionId = pageId.append(sectionIdRawValue)
            let entryItems = SettingsEntryId.allCases.map { $0.rawValue }.map { entryIdRawValue in
                let entryId = sectionId.append(entryIdRawValue)
                return SettingsEntryItem(
                    id: entryId ,
                    title: entryIdRawValue,
                    subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                    detailDescription: "description description description description description description description description description description description description description description description description description description",
                    type: .switch)
            }
            return SettingsSectionItem(id: sectionId, title: sectionIdRawValue, items: entryItems)
        }
        let model = SettingsPageModel(id: pageId, title: "调试页面", sections: sections)
        return SettingsPage(pageModel: model)
    }
}
