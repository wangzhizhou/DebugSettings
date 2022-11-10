//
//  File.swift
//  
//
//  Created by joker on 2022/11/3.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13, *)
extension DebugSettingsDemo {
    static public let switfuiModel = SettingsPageModel(id: SettingsPage.swiftui.rawValue, name: "SwiftUI调试选项子页面") {
        
        SettingsPageSectionModel(name: "Section1") {
            
            SettingsPageEntryModel(
                id: SettingsPage.swiftui.entryId(for: .switch1) ,
                title: "switch1",
                subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                detailDescription: "description description description description description description description description description description description description description description description description description description",
                type: .switch,
                switchValueChangeAction: switchValueChangeAction)
            
            SettingsPageEntryModel(id: SettingsPage.swiftui.entryId(for: .button1), title: "Button1", type: .button, buttonClickAction: buttonClickAction)
            
            SettingsPageEntryModel(id: SettingsPage.swiftui.entryId(for: .subpage1), title: "subpage1", type: .subpage, subpageJumpAction: subpageJumpAction)
            
        }
    }
    static public func swiftUIPage() -> SettingsSwiftUIPage<SettingsView> {
        return SettingsSwiftUIPage(rootView: SettingsView(model: switfuiModel))
    }
}

#endif
