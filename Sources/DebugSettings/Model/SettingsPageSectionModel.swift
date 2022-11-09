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
public class SettingsPageSectionModel: ObjcBridgeClass {
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
struct SettingsPageSectionBuilder {
    static func buildBlock(_ components: SettingsPageEntryModel...) -> SettingsPageSectionModel {
        return SettingsPageSectionModel(title: "", items: components)
    }
}

public extension SettingsPageSectionModel {
    convenience init(name: String, @SettingsPageSectionBuilder content: () -> SettingsPageSectionModel) {
        self.init(title: name, items: content().items)
    }
}
