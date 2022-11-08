//
//  SettingsPageEntryModel.swift
//  DebugSettings
//
//  Created by joker on 2022/11/7.
//

import Foundation
#if canImport(ObjcBridge)
import ObjcBridge
#endif

@objcMembers
public class SettingsPageEntryModel: ObjcBridgeClass, SettingsIdentifiable {
    public let id: String
    public var icon: UIImage?
    public let title: String
    public var subtitle: String?
    public var detailDescription: String?
    public let type: EntryType
    public var isSwitchOn: Bool? {
        get { Persistence.boolValueForId(self.id) }
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
            Persistence.saveBoolValue(value, for: self.id)
        }
    }
    
    /// 开关类型设置值变化处理事件
    public var switchValueChangeAction: SettingsEntrySwitchAction?
    
    /// 按钮类型设置点击处理事件
    public var buttonClickAction: SettingsEntryButtonAction?
    
    /// 跳转子页面事件处理
    public var subpageJumpAction: SettingsEntrySubPageJumpAction?
    
    public init(
        id: String,
        icon: UIImage? = nil,
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
public typealias SettingsEntrySwitchAction = (_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchActionType) -> Void
public typealias SettingsEntryButtonAction = (_ entryItem: SettingsPageEntryModel) -> Void
public typealias SettingsEntrySubPageJumpAction = (_ entryItem: SettingsPageEntryModel, _ from: UIViewController?) -> Void
