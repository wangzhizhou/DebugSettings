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
    public init(title: String, items: () -> [SettingsPageEntryModel]) {
        self.title = title
        self.items = items()
    }
    
    let items: [SettingsPageEntryModel]
}
