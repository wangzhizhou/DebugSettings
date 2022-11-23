//
//  File.swift
//  
//
//  Created by joker on 2022/11/23.
//

import Foundation

/// 为``SettingsPageModel``实现声明式创建语法，定义DSL实现
///
///  可使用类似于`SwiftUI/RegexBuilder`的声明式语法进行创建：
///  ```swift
///  let pageModel = SettingsPageModel(id: self.pageId, name: "调试页面") {
///
///     SettingsPageSectionModel(name: "Section1") {
///
///         SettingPageEntry.switch1.switchEntryModel(
///             title: "switch1",
///             subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
///             detail: "description")
///
///         SettingPageEntry.button1.buttonEntryModel(
///             title: "Local Push",
///             subtitle: "本地模拟远程推送，测试通知跳转逻辑")
///
///         SettingPageEntry.button2.buttonEntryModel(title: "Test Button")
///
///         SettingPageEntry.subpage1.subPageEntryModel(title: "UIKit子页面")
///
///         SettingPageEntry.subpage2.subPageEntryModel(title: "SwiftUI子页面")
///
///     }
/// }
///  ```
@resultBuilder
public struct SettingsPageBuilder {
    
    public static func buildBlock(_ components: SettingsPageSectionModel...) -> [SettingsPageSectionModel] {
        return components
    }
    
    public static func buildFinalResult(_ component: [SettingsPageSectionModel]) -> SettingsPageModel  {
        return SettingsPageModel(id: "", title: "", navigationBarHeight: 0, sections: component)
    }
}

public extension SettingsPageModel {
    
    /// 为支持声明式DSL创建方式新增的初始化方法
    /// - Parameters:
    ///   - id: 页面Id
    ///   - name: 页面名称
    ///   - navigationBarHeight: 页面导航栏高度
    ///   - content: 页面内容，包含多个Section
    convenience init(id: String, name: String, navigationBarHeight: Int = 0, @SettingsPageBuilder content: () -> SettingsPageModel) {
        self.init(id: id, title: name, navigationBarHeight: navigationBarHeight, sections: content().sections)
    }
}
