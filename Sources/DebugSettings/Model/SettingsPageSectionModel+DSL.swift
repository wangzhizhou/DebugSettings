//
//  File.swift
//  
//
//  Created by joker on 2022/11/23.
//

import Foundation

/// 为``SettingsPageSectionModel``实现声明式创建语法，定义DSL实现
///
///  可使用类似于`SwiftUI/RegexBuilder`的声明式语法进行创建：
///  ```swift
///     let sectionModel = SettingsPageSectionModel(name: "Section1") {
///
///         SettingPageEntry.switch1.switchEntryModel(title: "Switch1")
///
///         SettingPageEntry.button1.buttonEntryModel(title: "修改按钮副标题")
///
///         SettingPageEntry.subpage1.subPageEntryModel(title: "Subpage1")
///
///     }
///  ```
@resultBuilder
public struct SettingsPageSectionBuilder {
    public static func buildBlock(_ components: [SettingsPageEntryModel]...) -> [SettingsPageEntryModel] {
        return components.flatMap { $0 }
    }
    
    public static func buildEither(first component: [SettingsPageEntryModel]) -> [SettingsPageEntryModel] {
        return component
    }
    
    public static func buildEither(second component: [SettingsPageEntryModel]) -> [SettingsPageEntryModel] {
        return component
    }
    
    public static func buildOptional(_ component: [SettingsPageEntryModel]?) -> [SettingsPageEntryModel] {
        return component ?? []
    }
    
    public static func buildArray(_ components: [[SettingsPageEntryModel]]) -> [SettingsPageEntryModel] {
        return components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: SettingsPageEntryModel) -> [SettingsPageEntryModel] {
        return [expression]
    }
    
    public static func buildExpression(_ expression: [SettingsPageEntryModel]) -> [SettingsPageEntryModel] {
        return expression
    }
    
    public static func buildExpression(_ expression: Void) -> [SettingsPageEntryModel] {
        return []
    }
    
    public static func buildFinalResult(_ component: [SettingsPageEntryModel]) -> SettingsPageSectionModel {
        return SettingsPageSectionModel(title: "", items: component)
    }
}

public extension SettingsPageSectionModel {
    
    /// 为支持声明式创建DSL新增的初始化方法
    /// - Parameters:
    ///   - name: Section的标题
    ///   - content: Section的内容，包含多个调试选项
    convenience init(name: String, @SettingsPageSectionBuilder content: () -> SettingsPageSectionModel) {
        self.init(title: "❖ \(name)", items: content().items)
    }
}
