//
//  File.swift
//  
//
//  Created by joker on 2022/11/22.
//

#if canImport(SwiftUI)
import SwiftUI

/// 用于SwiftUI类型App接入时的Demo页面
public final class DebugSettingsDemoSwiftUIPage: SwiftDebugSettingsPage {
    
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
        
        var id: String { self.rawValue }
        var pageType: SwiftDebugSettingsPage.Type { DebugSettingsDemoSwiftUIPage.self }
    }
    
    public override class var pageId: String { SettingsPage.swiftui.id }
    
    public override class var pageModel: SettingsPageModel {
        SettingsPageModel(id: self.pageId, name: "SwiftUI调试选项子页面") {
            
            SettingsPageSectionModel(name: "Section1") {
                
                SettingPageEntry.switch1.switchEntryModel(title: "switch1", subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关", detail: "description description description description description description description description description description description description description description description description description description")
                
                SettingPageEntry.button1.buttonEntryModel(title: "Button1")
                
                SettingPageEntry.subpage1.subPageEntryModel(title: "subpage1")
                
            }
        }
    }
    
    public override class func show()  {
        
        if #available(iOS 13.0, *) {
            let rootView = SettingsContentView(model: self.pageModel).navigationBarTitle(self.pageModel.title)
            SettingsSwiftUIPage(rootView: rootView).pushOnTopViewController()
        } else {
            // Fallback on earlier versions
            fatalError("not available in this operation system version")
        }
    }
}

extension DebugSettingsDemoSwiftUIPage {
    
    public override class func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) {
        print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        
        switch entryItem.id {
        case SettingPageEntry.switch1.entryId:
            break
        default:
            break
        }
    }
    
    public override class func switchClickAction(_ entryItem: SettingsPageEntryModel) {
        print("id: \(entryItem.id), clicked")
    }
    
    public override class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {
        print("id: \(entryItem.id) action")
    }
    
    public override class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {
        print("id: \(entryItem.id) subpage jump")
    }
}

#endif
