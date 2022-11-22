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


public final class DebugSettingsDemoUIKitSubPage: SwiftDebugSettingsPage {
    
    /// 定义页面页Settings项目Id，同一个枚举中可以保持读写时的唯一性
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
    
    public override class var pageId: String { SettingsPage.subpage.rawValue }
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
        switch entryItem.id {
        case SettingPageEntry.switch1.entryId:
            print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        default:
            print("other switch change")
        }
    }
    
    public override class func switchClickAction(_ entryItem: SettingsPageEntryModel) {
        
    }
    
    public override class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {
        switch entryItem.id {
        case SettingPageEntry.button1.entryId:
            entryItem.subtitle = "刷新了页面后的subtitle"
            SettingsManager.refreshPage(for: self.pageId)
        default:
            print("other button action")
        }
    }
    
    public override class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {
        switch entryItem.id {
        case SettingPageEntry.subpage1.entryId:
            print("id: \(entryItem.id) subpage jump")
        case SettingPageEntry.subpage2.entryId:
            if #available(iOS 13, *) {
            }
        default:
            print("other subpage jump")
        }
    }
}
