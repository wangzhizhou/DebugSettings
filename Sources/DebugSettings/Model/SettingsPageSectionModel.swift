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

/// 调试页面各Section对应的数据模型
@objcMembers
public class SettingsPageSectionModel: DSObjcBridgeClass {
    
    /// Section的标题
    public let title: String
    
    public convenience init(title: String, itemsBlock: () -> [SettingsPageEntryModel]) {
        self.init(title: title, items: itemsBlock())
    }

    /// Sectione包含的调试选项数据模型数组
    let items: [SettingsPageEntryModel]
    
    init(title: String, items: [SettingsPageEntryModel]) {
        self.title = title
        self.items = items
    }
}
