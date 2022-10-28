//
//  SettingsPageModel.swift
//  
//
//  Created by joker on 2022/10/27.
//

import Foundation
import ObjcBridge

@objcMembers
public class SettingsPageModel: ObjcBridgeClass {
    public let title: String
    public let sections: [SettingsSectionItem]
    public let navigationBarHeight: Int
    
    public init(title: String, sections: [SettingsSectionItem], navigationBarHeight: Int = 40) {
        self.title = title
        self.sections = sections
        self.navigationBarHeight = navigationBarHeight
    }
}
extension SettingsPageModel: SettingsIdentifiable {
    public var id: String {
        return UUID().uuidString
    }
}

@objcMembers
public class SettingsSectionItem: ObjcBridgeClass {
    public let title: String
    public let items: [SettingsEntryItem]
    
    public init(title: String, items: [SettingsEntryItem]) {
        self.title = title
        self.items = items
    }
}
extension SettingsSectionItem: SettingsIdentifiable {
    public var id: String {
        return UUID().uuidString
    }
}

@objcMembers
public class SettingsEntryItem: ObjcBridgeClass {
    public var icon: String? = nil
    public let title: String
    public let subtitle: String?
    public let detailDescription: String?
    public let type: EntryType
    public var isSwitchOn: Bool = false
    
    public init(icon: String? = nil, title: String, subtitle: String?, detailDescription: String?, type: EntryType, isSwitchOn: Bool) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.detailDescription = detailDescription
        self.type = type
        self.isSwitchOn = isSwitchOn
    }
}
extension SettingsEntryItem: SettingsIdentifiable {
    public var id: String {
        return UUID().uuidString
    }
}

@objc
public enum EntryType: Int {
    case `switch`
    case button
}
