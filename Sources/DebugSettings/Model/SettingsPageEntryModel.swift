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

/// 调试页面中对应每一个调试选项的数据模型定义
@objcMembers
public class SettingsPageEntryModel: DSObjcBridgeClass, SettingsIdentifiable {
    
    /// 调试选项的id
    public let id: String
    
    /// 调试选项图标
    public var icon: UIImage?
    
    /// 调试选项标题
    public var title: String
    
    /// 调试选项子标题
    public var subtitle: String?
    
    /// 调试选项详情
    public var detailDescription: String?
    
    /// 调试选项使用说明h5页面链接
    public var helpInfoUrl: String?
    
    /// 调试选项类型
    public let type: EntryType
    
    /// 开关类调试选项的开关状态
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
    
    /// 开关类型调试选项值变化时的处理事件
    public var switchValueChangeAction: SettingsEntrySwitchValueChangeAction?
    
    /// 开关类型调试选项被点击时的处理事件
    public var switchClickAction: SettingsEntrySwitchClickAction?
    
    /// 按钮类型调试选项点击处理事件
    public var buttonClickAction: SettingsEntryButtonAction?
    
    /// 子页面跳转类调试选项事件处理
    public var subpageJumpAction: SettingsEntrySubPageJumpAction?
    
    @discardableResult
    public init(
        id: String,
        icon: UIImage? = nil,
        title: String,
        subtitle: String? = nil,
        detailDescription: String? = nil,
        helpInfoUrl: String? = nil,
        type: EntryType,
        switchDefaultValue: Bool = false,
        sourceOfTruth: Bool? = nil,
        switchValueChangeAction: SettingsEntrySwitchValueChangeAction? = nil,
        switchClickAction: SettingsEntrySwitchClickAction? = nil,
        buttonClickAction: SettingsEntryButtonAction? = nil,
        subpageJumpAction: SettingsEntrySubPageJumpAction? = nil) {
            
            self.id = id
            self.icon = icon
            self.title = title
            self.subtitle = subtitle
            self.detailDescription = detailDescription
            self.helpInfoUrl = helpInfoUrl
            self.type = type
            self.switchValueChangeAction = switchValueChangeAction
            self.switchClickAction = switchClickAction
            self.buttonClickAction = buttonClickAction
            self.subpageJumpAction = subpageJumpAction
            super.init()
            if let sourceOfTruth = sourceOfTruth {
                Persistence.saveBoolValue(sourceOfTruth, for: self.id)
            }
            if self.isSwitchOn == nil {
                self.isSwitchOn = switchDefaultValue
            }
            else {
                self.isSwitchOn = self.isSwitchOn
            }
        }
}

/// 定义调试选项的类型，`开关类(switch)`、`按钮类(button)`、`子页面类(subpage)`
@objc
public enum EntryType: Int {
    
    /// 开关类型调试选项
    case `switch`
    
    /// 按钮类型调试选项
    case button
    
    /// 子页面类型调试选项
    case subpage
}

/// switch类调试选项开关状值变化时对应的类型
@objc
public enum SettingsEntrySwitchValueChangeActionType: Int {
    
    /// 值变化时，是赋初始值的情况
    case `init`
    
    /// 值变化时，新值和原值相同
    case old
    
    /// 值变化时，新值和原值不同
    case new
}

/// 处理switch类调试选项开关状态值变化事件的闭包定义
public typealias SettingsEntrySwitchValueChangeAction = (_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) -> Void

/// 处理switch类调试选项点击非开关区域事件的闭包定义
public typealias SettingsEntrySwitchClickAction = (_ entryItem: SettingsPageEntryModel) -> Void

/// 处理button类调试选项点击事件的闭包定义
public typealias SettingsEntryButtonAction = (_ entryItem: SettingsPageEntryModel) -> Void

/// 处理subpage类调试选项点击跳转事件的闭包定义
public typealias SettingsEntrySubPageJumpAction = (_ entryItem: SettingsPageEntryModel, _ from: UIViewController?) -> Void
