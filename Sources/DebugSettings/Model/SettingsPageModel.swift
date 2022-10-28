//
//  SettingsPageModel.swift
//  
//
//  Created by joker on 2022/10/27.
//

import Foundation
import ObjcBridge

@objcMembers
public class SettingsPageModel: ObjcBridgeClass, SettingsIdentifiable {
    public let title: String
    public let sections: [SettingsSectionItem]
    
    public init(title: String, sections: [SettingsSectionItem]) {
        self.title = title
        self.sections = sections
    }
}
@objcMembers
public class SettingsSectionItem: ObjcBridgeClass, SettingsIdentifiable {
    public let title: String
    public let items: [SettingsEntryItem]
    
    public init(title: String, items: [SettingsEntryItem]) {
        self.title = title
        self.items = items
    }
}
@objcMembers
public class SettingsEntryItem: ObjcBridgeClass, SettingsIdentifiable {
    public let title: String
    public let subtitle: String?
    public let detailDescription: String?
    
    public init(title: String, subtitle: String?, detailDescription: String?) {
        self.title = title
        self.subtitle = subtitle
        self.detailDescription = detailDescription
    }
}
