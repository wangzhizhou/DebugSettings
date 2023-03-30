//
//  SettingsPageEntry+Utils.swift
//  FHDebug
//
//  Created by joker on 2022/11/11.
//

import Foundation
import UIKit


/// 页面调试选项定义需要遵循的协议
public protocol SettingsPageEntryProtocol {
    
    /// 当前调试页面内部调试选项的Id，全局唯一Id使用self.entryId属性获取。
    var id: String { get }
    
    /// 绑定调试选项所在的页面类型，用于生成调试选项的全局唯一Id，从而支持开关类调试选项开关值的持久化存储
    var pageType: SwiftDebugSettingsPage.Type { get }
    
    func switchEntryModel(
        title: String,
        icon: UIImage?,
        subtitle: String?,
        detail:String?,
        helpInfoUrl: String?,
        default: Bool,
        sourceOfTruth: Bool?
    ) -> SettingsPageEntryModel
    
    func buttonEntryModel(
        title: String,
        icon: UIImage?,
        subtitle: String?,
        detail:String?,
        helpInfoUrl: String?
    ) -> SettingsPageEntryModel
    
    func subPageEntryModel(
        title: String,
        icon: UIImage?,
        subtitle: String?,
        detail:String?,
        helpInfoUrl: String?
    ) -> SettingsPageEntryModel
    
}

public extension SettingsPageEntryProtocol {
    
    /// 确保页面内每一个选项的ID是全局唯一可标识的，默认拼接格式为“<页面Id>.<调试选项Id>”
    var entryId: String { "\(pageType.pageId).\(self.id)" }
    
    /// 创建开关类调试选项的辅助API
    func switchEntryModel(
        title: String,
        icon: UIImage? = nil,
        subtitle: String? = nil,
        detail:String? = nil,
        helpInfoUrl: String? = nil,
        default: Bool = false,
        sourceOfTruth: Bool? = nil
    ) -> SettingsPageEntryModel {
            SettingsPageEntryModel(
                id: self.entryId,
                icon: icon,
                title: title,
                subtitle: subtitle,
                detailDescription: detail,
                helpInfoUrl: helpInfoUrl,
                type: .switch,
                switchDefaultValue: `default`,
                sourceOfTruth: sourceOfTruth,
                switchValueChangeAction: pageType.switchValueChangeAction,
                switchClickAction: pageType.switchClickAction
            )
        }
    
    /// 创建按钮类调试选项的辅助API
    func buttonEntryModel(
        title: String,
        icon: UIImage? = nil,
        subtitle: String? = nil,
        detail:String? = nil,
        helpInfoUrl: String? = nil
    ) -> SettingsPageEntryModel {
        SettingsPageEntryModel(
            id: self.entryId,
            icon: icon,
            title: title,
            subtitle: subtitle,
            detailDescription: detail,
            helpInfoUrl: helpInfoUrl,
            type: .button,
            buttonClickAction: pageType.buttonClickAction)
    }
    
    /// 创建子页面类调试选项的辅助API
    func subPageEntryModel(
        title: String,
        icon: UIImage? = nil,
        subtitle: String? = nil,
        detail:String? = nil,
        helpInfoUrl: String? = nil
    ) -> SettingsPageEntryModel {
        SettingsPageEntryModel(
            id: self.entryId,
            icon: icon,
            title: title,
            subtitle: subtitle,
            detailDescription: detail,
            helpInfoUrl: helpInfoUrl,
            type: .subpage,
            subpageJumpAction: pageType.subpageJumpAction)
    }
}
