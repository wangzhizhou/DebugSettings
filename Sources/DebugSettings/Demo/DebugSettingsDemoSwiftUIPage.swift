//
//  File.swift
//  
//
//  Created by joker on 2022/11/22.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13, *)
public final class DebugSettingsDemoSwiftUIPage: SwiftDebugSettingsPage {
    
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
        var pageType: SwiftDebugSettingsPage.Type { DebugSettingsDemoSwiftUIPage.self }
    }
    
    public override class var pageId: String { SettingsPage.swiftui.rawValue }
    
    public override class var pageModel: SettingsPageModel {
        SettingsPageModel(id: self.pageId, name: "SwiftUI调试选项子页面") {
            
            SettingsPageSectionModel(name: "Section1") {
                
                SettingPageEntry.switch1.switchEntryModel(title: "switch1", subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关", detail: "description description description description description description description description description description description description description description description description description description")
                
                SettingPageEntry.button1.buttonEntryModel(title: "Button1")
                
                SettingPageEntry.subpage1.subPageEntryModel(title: "subpage1")
                
            }
        }
    }
    
    public override class func show() {
        SettingsSwiftUIPage(rootView: SettingsView(model: self.pageModel)).pushOnTopViewController()
    }
}

extension DebugSettingsDemoSwiftUIPage {
    
    public override class func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) {
        switch entryItem.id {
        case SettingPageEntry.switch1.entryId:
            print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        default:
            print("other switch change")
        }
    }
    
    public override class func switchClickAction(_ entryItem: SettingsPageEntryModel) {
        switch entryItem.id {
        case SettingPageEntry.switch1.entryId:
            print("id: \(entryItem.id), clicked")
        default:
            print("id: \(entryItem.id), clicked")
        }
    }
    
    public override class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {
        switch entryItem.id {
        case SettingPageEntry.button1.entryId:
            print("id: \(entryItem.id) action")
        default:
            print("other button action")
        }
    }
    
    public override class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {
        switch entryItem.id {
        case SettingPageEntry.subpage1.entryId:
            print("id: \(entryItem.id) subpage jump")
        default:
            print("other subpage jump")
        }
    }
}

#endif
