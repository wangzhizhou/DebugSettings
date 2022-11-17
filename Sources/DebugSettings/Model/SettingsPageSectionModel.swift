//
//  SettingsPageSectionModel.swift
//  DebugSettings
//
//  Created by joker on 2022/11/7.
//

import Foundation
#if canImport(ObjcBridge)
import ObjcBridge
#endif

@objcMembers
public class SettingsPageSectionModel: DSObjcBridgeClass {
    public let title: String
    
    public convenience init(title: String, itemsBlock: () -> [SettingsPageEntryModel]) {
        self.init(title: title, items: itemsBlock())
    }

    let items: [SettingsPageEntryModel]
    
    init(title: String, items: [SettingsPageEntryModel]) {
        self.title = title
        self.items = items
    }
}

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
    convenience init(name: String, @SettingsPageSectionBuilder content: () -> SettingsPageSectionModel) {
        self.init(title: "❖ \(name)", items: content().items)
    }
}
