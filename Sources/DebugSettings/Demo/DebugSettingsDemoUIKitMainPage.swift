//
//  DebugSettingsDemo.swift
//  
//
//  Created by joker on 2022/10/29.
//

import Foundation
import UIKit
#if canImport(DebugTools)
import DebugTools
#endif

/// 用于UIKit类型App接入时的Demo页面
public final class DebugSettingsDemoUIKitMainPage: SwiftDebugSettingsPage {
    
    /// 定义页面内调试选项，同一个枚举中可以保证页面内部调试选项的Id唯一性
    private enum SettingPageEntry: String, CaseIterable, SettingsPageEntryProtocol {
        
        // 开关类
        case switch1
        case switch2
        
        // 按钮类
        case button1
        case button2
        
        // 子页面类
        case subpage1
        case subpage2
        
        // SettingsPageEntryProtocol
        var id: String { self.rawValue }
        var pageType: SwiftDebugSettingsPage.Type { DebugSettingsDemoUIKitMainPage.self }
    }
    
    public override class var pageId: String { SettingsPage.main.id }
    public override class var pageModel: SettingsPageModel {
        SettingsPageModel(id: self.pageId, name: "调试页面") {
            SettingsPageSectionModel(name: "Section1") {
                
                SettingPageEntry.switch1.switchEntryModel(
                    title: "switch1",
                    subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                    detail: "description description description description")
                
                SettingPageEntry.button1.buttonEntryModel(
                    title: "Local Push",
                    subtitle: "本地模拟远程推送，测试通知跳转逻辑")
                
                SettingPageEntry.button2.buttonEntryModel(title: "Test Button")
                
                SettingPageEntry.subpage1.subPageEntryModel(title: "UIKit子页面")
                
                SettingPageEntry.subpage2.subPageEntryModel(title: "SwiftUI子页面")
                
            }
        }
    }
}


extension DebugSettingsDemoUIKitMainPage {
    
    public override class func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) {
        print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
    }
    
    public override class func switchClickAction(_ entryItem: SettingsPageEntryModel) {
        print("id: \(entryItem.id) clicked")
    }
    
    public override class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {
        print("id: \(entryItem.id) action")
        
        switch entryItem.id {
        case SettingPageEntry.button1.entryId:
            LocalPushDemoPage.show()
        default:
            break
        }
    }
    
    public override class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {
        print("id: \(entryItem.id) subpage jump")
        
        switch entryItem.id {
        case SettingPageEntry.subpage1.entryId:
            DebugSettingsDemoUIKitSubPage.show()
        case SettingPageEntry.subpage2.entryId:
            if #available(iOS 13, *) {
                DebugSettingsDemoSwiftUIPage.show()
            }
        default:
            break
        }
    }
}

