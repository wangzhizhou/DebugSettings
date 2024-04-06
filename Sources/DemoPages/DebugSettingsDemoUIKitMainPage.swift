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
#if canImport(DebugSettings)
import DebugSettings
#endif
import FLEX

/// 用于UIKit类型App接入时的Demo页面
public final class DebugSettingsDemoUIKitMainPage: SwiftDebugSettingsBasePage {
    
    /// 定义页面内调试选项，同一个枚举中可以保证页面内部调试选项的Id唯一性
    private enum SettingPageEntry: String, CaseIterable, SettingsPageEntryProtocol {
        
        // 开关类
        case FLEX
        case LocalPush
        case uikitSubPage
        case proxyman
        case proxymanTest

        // SettingsPageEntryProtocol
        var id: String { self.rawValue }
        var pageType: SwiftDebugSettingsBasePage.Type { DebugSettingsDemoUIKitMainPage.self }
    }
    
    public override class var pageId: String { SettingsPage.main.id }
    public override class var pageModel: SettingsPageModel {
        SettingsPageModel(id: self.pageId, name: "调试页面") {
            SettingsPageSectionModel(name: "Section 1") {
                
                SettingPageEntry.FLEX.buttonEntryModel(
                    title: "FLEX",
                    detail: "FLEX (Flipboard Explorer) is a set of in-app debugging and exploration tools for iOS development. When presented, FLEX shows a toolbar that lives in a window above your application. From this toolbar, you can view and modify nearly every piece of state in your running application.",
                    helpInfoUrl: "https://github.com/FLEXTool/FLEX"
                )

                SettingPageEntry.LocalPush.subPageEntryModel(
                    title: "Local Push",
                    subtitle: "本地模拟远程推送，测试通知跳转逻辑",
                    detail: "仅支持本地普通Alert推送模拟，不支持 静默推送、VoIP推送、地理位置推等其它特殊类型推送，同时实现方案使用Apple私有API实现，上架应用需要排除这部分工具实现的代码，否则有审核风险"
                )

                SettingPageEntry.uikitSubPage.subPageEntryModel(title: "UIKit 子页面")

                SettingPageEntry.proxyman.switchEntryModel(title: "Proxyman")
                
                SettingPageEntry.proxymanTest.buttonEntryModel(title: "Test Proxyman")

            }
        }
    }
}

extension DebugSettingsDemoUIKitMainPage {
    
    public override class func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) {
        print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        switch entryItem.id {
        case SettingPageEntry.proxyman.entryId:
            if isOn {
                Proxyman.start()
            } else {
                Proxyman.stop()
            }
        default:
            break
        }
    }
    
    public override class func switchClickAction(_ entryItem: SettingsPageEntryModel) {
        print("id: \(entryItem.id) clicked")
    }
    
    public override class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {
        print("id: \(entryItem.id) action")
        
        switch entryItem.id {
        case SettingPageEntry.FLEX.entryId:
            FLEXManager.shared.toggleExplorer()
        case SettingPageEntry.proxymanTest.entryId:
            Proxyman.testReport()
        default:
            break
        }
    }
    
    public override class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController?) {
        print("id: \(entryItem.id) subpage jump")
        
        switch entryItem.id {
        case SettingPageEntry.LocalPush.entryId:
            LocalPushDemoPage.show()
        case SettingPageEntry.uikitSubPage.entryId:
            DebugSettingsDemoUIKitSubPage.show()
        default:
            break
        }
    }
}

