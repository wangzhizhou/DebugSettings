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
    public let id: SettingsIdentifier
    public let title: String
    public let sections: [SettingsSectionItem]
    public var navigationBarHeight: Int
    
    public init(id: SettingsIdentifier, title: String, sections: [SettingsSectionItem], navigationBarHeight: Int = 40) {
        self.id = id
        self.title = title
        self.sections = sections
        self.navigationBarHeight = navigationBarHeight
    }
}

@objcMembers
public class SettingsSectionItem: ObjcBridgeClass, SettingsIdentifiable {
    public let id: SettingsIdentifier
    public let title: String
    public let items: [SettingsEntryItem]
    
    public init(id: SettingsIdentifier, title: String, items: [SettingsEntryItem]) {
        self.id = id
        self.title = title
        self.items = items
    }
}

@objcMembers
public class SettingsEntryItem: ObjcBridgeClass, SettingsIdentifiable {
    
    public let id: SettingsIdentifier
    public var icon: String?
    public let title: String
    public var subtitle: String?
    public var detailDescription: String?
    public let type: EntryType
    public var isSwitchOn: Bool? {
        get { Persistence.boolValueForId(self.id.persistenceKey) }
        set { Persistence.saveBoolValue(newValue ?? false, for: self.id.persistenceKey) }
    }
    
    public init(id: SettingsIdentifier, icon: String? = nil, title: String, subtitle: String? = nil, detailDescription: String? = nil, type: EntryType, isSwitchOn: Bool = false) {
        self.id = id
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.detailDescription = detailDescription
        self.type = type
        super.init()
        if self.isSwitchOn == nil {
            self.isSwitchOn = isSwitchOn
        }
    }
}

@objc
public enum EntryType: Int {
    case `switch`
    case button
}
