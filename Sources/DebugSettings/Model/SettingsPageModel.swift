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
    public var navigationBarHeight: Int
    
    public init(id: SettingsIdentifier, title: String, navigationBarHeight: Int = 40, sections: () -> [SettingsSectionItem]) {
        self.id = id
        self.title = title
        self.sections = sections()
        self.navigationBarHeight = navigationBarHeight
    }
    
    let sections: [SettingsSectionItem]
}

@objcMembers
public class SettingsSectionItem: ObjcBridgeClass, SettingsIdentifiable {
    public let id: SettingsIdentifier
    public let title: String
    
    public init(id: SettingsIdentifier, title: String, items: () -> [SettingsEntryItem]) {
        self.id = id
        self.title = title
        self.items = items()
    }
    
    let items: [SettingsEntryItem]
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
        set {
            let value = newValue ?? false
            if self.isSwitchOn == nil {
                // 初始人时的赋值
                if let switchValueChangeAction = self.switchValueChangeAction {
                    switchValueChangeAction(self, value, .`init`)
                }
            }
            else {
                // 初始化之后，再改变时的赋值
                if let switchValueChangeAction = self.switchValueChangeAction {
                    switchValueChangeAction(self, value, .new)
                }
            }
            Persistence.saveBoolValue(value, for: self.id.persistenceKey)
        }
    }
    
    /// 开关类型设置值变化处理事件
    public var switchValueChangeAction: SettingsEntrySwitchAction?
    
    /// 按钮类型设置点击处理事件
    public var buttonClickAction: SettingsEntryButtonAction?
    
    /// 跳转子页面事件处理
    public var subpageJumpAction: SettingsEntrySubPageJumpAction?
    
    public init(
        id: SettingsIdentifier,
        icon: String? = nil,
        title: String,
        subtitle: String? = nil,
        detailDescription: String? = nil,
        type: EntryType,
        isSwitchOn: Bool = false,
        switchValueChangeAction: SettingsEntrySwitchAction? = nil,
        buttonClickAction: SettingsEntryButtonAction? = nil,
        subpageJumpAction: SettingsEntrySubPageJumpAction? = nil) {
            
            self.id = id
            self.icon = icon
            self.title = title
            self.subtitle = subtitle
            self.detailDescription = detailDescription
            self.type = type
            self.switchValueChangeAction = switchValueChangeAction
            self.buttonClickAction = buttonClickAction
            self.subpageJumpAction = subpageJumpAction
            super.init()
            if self.isSwitchOn == nil {
                self.isSwitchOn = isSwitchOn
            }
        }
}

@objc
public enum EntryType: Int {
    
    /// 开关类型的设置项
    case `switch`
    
    /// 按钮类型的设置项
    case button
    
    /// 子页面
    case subpage
}

@objc
public enum SettingsEntrySwitchActionType: Int {
    /// 初始值
    case `init`
    
    /// 初始化后被变化的值
    case new
}

/// 开关类型设置项的值变化处理事件
public typealias SettingsEntrySwitchAction = (_ entryItem: SettingsEntryItem, _ isOn: Bool, _ type: SettingsEntrySwitchActionType) -> Void
public typealias SettingsEntryButtonAction = (_ entryItem: SettingsEntryItem) -> Void
public typealias SettingsEntrySubPageJumpAction = (_ entryItem: SettingsEntryItem, _ from: UIViewController) -> Void

