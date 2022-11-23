//
//  File.swift
//  
//
//  Created by joker on 2022/11/23.
//

import Foundation

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
