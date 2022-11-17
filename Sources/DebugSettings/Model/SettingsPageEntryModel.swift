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
public class SettingsPageEntryModel: DSObjcBridgeClass, SettingsIdentifiable {
    public let id: String
    public var icon: UIImage?
    public var title: String
    public var subtitle: String?
    public var detailDescription: String?
    public let type: EntryType
    public var isSwitchOn: Bool? {
        get { Persistence.boolValueForId(self.id) }
        set {
            let value = newValue ?? false
            if let old = self.isSwitchOn {
                // 初始化之后，再改变时的赋值
                if let switchValueChangeAction = self.switchValueChangeAction {
                    switchValueChangeAction(self, value, value == old ? .old : .new)
                }
            }
            else {
                // 初始化时的赋值
                if let switchValueChangeAction = self.switchValueChangeAction {
                    switchValueChangeAction(self, value, .`init`)
                }
            }
            Persistence.saveBoolValue(value, for: self.id)
        }
    }
    
    /// 开关类型设置值变化处理事件
    public var switchValueChangeAction: SettingsEntrySwitchValueChangeAction?
    
    /// 开关项被用户点击时的处理事件
    public var switchClickAction: SettingsEntrySwitchClickAction?
    
    /// 按钮类型设置点击处理事件
    public var buttonClickAction: SettingsEntryButtonAction?
    
    /// 跳转子页面事件处理
    public var subpageJumpAction: SettingsEntrySubPageJumpAction?
    
    @discardableResult
    public init(
        id: String,
        icon: UIImage? = nil,
        title: String,
        subtitle: String? = nil,
        detailDescription: String? = nil,
        type: EntryType,
        isSwitchOn: Bool = false,
        switchDefaultValue: Bool = false,
        switchValueChangeAction: SettingsEntrySwitchValueChangeAction? = nil,
        switchClickAction: SettingsEntrySwitchClickAction? = nil,
        buttonClickAction: SettingsEntryButtonAction? = nil,
        subpageJumpAction: SettingsEntrySubPageJumpAction? = nil) {
            
            self.id = id
            self.icon = icon
            self.title = title
            self.subtitle = subtitle
            self.detailDescription = detailDescription
            self.type = type
            self.switchValueChangeAction = switchValueChangeAction
            self.switchClickAction = switchClickAction
            self.buttonClickAction = buttonClickAction
            self.subpageJumpAction = subpageJumpAction
            super.init()
            if self.isSwitchOn == nil {
                self.isSwitchOn = switchDefaultValue
            }
            else {
                self.isSwitchOn = self.isSwitchOn
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
public enum SettingsEntrySwitchValueChangeActionType: Int {
    /// 初始值
    case `init`
    
    /// 初始化后没有变化过的值
    case old
    
    /// 初始化后被变化的值
    case new
}

/// 开关类型设置项的值变化处理事件
public typealias SettingsEntrySwitchValueChangeAction = (_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) -> Void
public typealias SettingsEntrySwitchClickAction = (_ entryItem: SettingsPageEntryModel) -> Void
public typealias SettingsEntryButtonAction = (_ entryItem: SettingsPageEntryModel) -> Void
public typealias SettingsEntrySubPageJumpAction = (_ entryItem: SettingsPageEntryModel, _ from: UIViewController?) -> Void
