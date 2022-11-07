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
        
        let model = SettingsPageModel(id: SettingsPage.swiftui.rawValue, title: "SwiftUI调试选项子页面") {
            let section1 = SettingsPageSectionModel(title: "Section1") {
                
                let switch1 = SettingsPageEntryModel(
                    id: SettingsPage.main.entryId(for: .switch1) ,
                    title: "switch1",
                    subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                    detailDescription: "description description description description description description description description description description description description description description description description description description",
                    type: .switch,
                    switchValueChangeAction: switchValueChangeAction)
                
                let button1 = SettingsPageEntryModel(id: SettingsPage.main.entryId(for: .button1), title: "Button1", type: .button, buttonClickAction: buttonClickAction)
                
                
                let subPage1 = SettingsPageEntryModel(id: SettingsPage.main.entryId(for: .subpage1), title: "subpage1", type: .subpage, subpageJumpAction: subpageJumpAction)
                
                
                return [switch1, button1, subPage1]
            }
            
            return [section1]
        }
        return SettingsSwiftUIPage(rootView: SettingsView(model: model))
    }
}

#endif
