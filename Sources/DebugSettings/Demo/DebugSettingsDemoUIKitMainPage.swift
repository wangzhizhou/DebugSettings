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
#if canImport(Utils)
import Utils
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
        case button3
        case button4
        
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
            SettingsPageSectionModel(name: "Section 1") {
                
                SettingPageEntry.switch1.switchEntryModel(
                    title: "switch 1",
                    subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                    detail: "description description description description",
                    helpInfoUrl: "https://www.baidu.com")
                
                SettingPageEntry.button1.buttonEntryModel(
                    title: "Local Push",
                    subtitle: "本地模拟远程推送，测试通知跳转逻辑",
                    detail: "仅支持本地普通Alert推送模拟，不支持 静默推送、VoIP推送、地理位置推等其它特殊类型推送，同时实现方案使用Apple私有API实现，上架应用需要排除这部分工具实现的代码，否则有审核风险")
                
                SettingPageEntry.button2.buttonEntryModel(title: "Test Button")
                
                SettingPageEntry.subpage1.subPageEntryModel(title: "UIKit子页面")
            }
            
            SettingsPageSectionModel(name: "Section 2") {
                
                SettingPageEntry.switch2.switchEntryModel(
                    title: "switch 2",
                    subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                    detail: "description description description description",
                    helpInfoUrl: "https://www.baidu.com")
                
                SettingPageEntry.button3.buttonEntryModel(
                    title: "Local Push",
                    subtitle: "本地模拟远程推送，测试通知跳转逻辑",
                    detail: "仅支持本地普通Alert推送模拟，不支持 静默推送、VoIP推送、地理位置推等其它特殊类型推送，同时实现方案使用Apple私有API实现，上架应用需要排除这部分工具实现的代码，否则有审核风险")
                
                SettingPageEntry.button4.buttonEntryModel(title: "Test Button")
                
                SettingPageEntry.subpage2.subPageEntryModel(title: "UIKit子页面")
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
        default:
            break
        }
    }
}

