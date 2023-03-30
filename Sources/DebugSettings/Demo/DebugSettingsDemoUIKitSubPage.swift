//
//  File.swift
//  
//
//  Created by joker on 2022/11/22.
//

import Foundation

#if canImport(ObjcBridge)
import ObjcBridge
#endif
#if canImport(Utils)
import Utils
#endif

/// 用于UIKit类型App接入时的Demo页面
public final class DebugSettingsDemoUIKitSubPage: SwiftDebugSettingsPage {
    
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
        var pageType: SwiftDebugSettingsPage.Type { DebugSettingsDemoUIKitSubPage.self }
    }
    
    public override class var pageId: String { SettingsPage.subpage.id }
    public override class var pageModel: SettingsPageModel {
        SettingsPageModel(id: self.pageId, name: "调试选项子页面") {
            SettingsPageSectionModel(name: "Section1") {
                
                SettingPageEntry.switch1.switchEntryModel(title: "Switch1")
                
                SettingPageEntry.button1.buttonEntryModel(title: "修改按钮副标题")
                
                SettingPageEntry.subpage1.subPageEntryModel(title: "Subpage1")
                
            }
        }
    }
}

extension DebugSettingsDemoUIKitSubPage {
    
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
            entryItem.subtitle = "刷新了页面后的subtitle"
            SettingsManager.refreshPage(for: self.pageId)
        default:
            break
        }
    }
    
    public override class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {
        print("id: \(entryItem.id) subpage jump")
        
        switch entryItem.id {
        case SettingPageEntry.subpage1.entryId:
            break
        case SettingPageEntry.subpage2.entryId:
            break
        default:
            break
        }
    }
}
