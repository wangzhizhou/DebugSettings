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
public class DebugSettingsDemo: DSObjcBridgeClass {

    static public func mainPage() -> SettingsUIKitPage {
        
        let model = SettingsPageModel(id: SettingsPage.main.rawValue, title: "调试页面") {
            
            let section1 = SettingsPageSectionModel(title: "Section1") {
                let switch1 = SettingsPageEntryModel(
                    id: SettingsPage.main.entryId(for: .switch1) ,
                    title: "switch1",
                    subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                    detailDescription: "description description description description description description description description description description description description description description description description description description",
                    type: .switch,
                    switchValueChangeAction: switchValueChangeAction)
                
                let button1 = SettingsPageEntryModel(id: SettingsPage.main.entryId(for: .button1), title: "Local Push", subtitle: "本地模拟远程推送，测试通知跳转逻辑", type: .button, buttonClickAction: buttonClickAction)
                
                let button2 = SettingsPageEntryModel(id: SettingsPage.main.entryId(for: .button2), title: "Test Button", type: .button, buttonClickAction: buttonClickAction)
            
                let subPage1 = SettingsPageEntryModel(id: SettingsPage.main.entryId(for: .subpage1), title: "UIKit子页面", type: .subpage, subpageJumpAction: subpageJumpAction)
                
                let subPage2 = SettingsPageEntryModel(id: SettingsPage.main.entryId(for: .subpage2), title: "SwiftUI子页面", type: .subpage, subpageJumpAction: subpageJumpAction)
                
                return [switch1, button1, button2, subPage1, subPage2]
            }
            
            return [section1]
        }
        return SettingsUIKitPage(pageModel: model)
    }
    
    static public func subpage() -> SettingsUIKitPage {
        let model = SettingsPageModel(id: SettingsPage.subpage.rawValue, title: "调试选项子页面") {
            let section1 = SettingsPageSectionModel(title: "Section1") {
                
                let switch1 = SettingsPageEntryModel(id: SettingsPage.subpage.entryId(for: .switch1), title: "Switch1", type: .switch, switchValueChangeAction: switchValueChangeAction)
                
                let button1 = SettingsPageEntryModel(id: SettingsPage.subpage.entryId(for: .button1), title: "修改按钮副标题", type: .button, buttonClickAction: buttonClickAction)
                
                let subpage1 = SettingsPageEntryModel(id: SettingsPage.subpage.entryId(for: .subpage1), title: "Subpage1", type: .subpage, subpageJumpAction: subpageJumpAction)
                
                return [switch1, button1, subpage1]
            }
            
            return [section1]
        }
        return SettingsUIKitPage(pageModel: model)
    }
}
