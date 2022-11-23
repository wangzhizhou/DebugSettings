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
    
    var id: String { get }
    
    var pageType: SwiftDebugSettingsPage.Type { get }
    
    func switchEntryModel(
        title: String,
        icon: UIImage?,
        subtitle: String?,
        detail:String?,
        isOn: Bool,
        default: Bool) -> SettingsPageEntryModel
    
    func buttonEntryModel(
        title: String,
        icon: UIImage?,
        subtitle: String?,
        detail:String?
    ) -> SettingsPageEntryModel
    
    func subPageEntryModel(
        title: String,
        icon: UIImage?,
        subtitle: String?,
        detail:String?
    ) -> SettingsPageEntryModel
    
}

public extension SettingsPageEntryProtocol {
    
    /// 确保页面内每一个选项的ID是唯一可标识的
    var entryId: String { "\(pageType.pageId).\(self.id)" }
    
    /// 创建开关类调试选项的辅助API
    func switchEntryModel(
        title: String,
        icon: UIImage? = nil,
        subtitle: String? = nil,
        detail:String? = nil,
        isOn: Bool = false,
        default: Bool = false) -> SettingsPageEntryModel {
            SettingsPageEntryModel(
                id: self.entryId,
                icon: icon,
                title: title,
                subtitle: subtitle,
                detailDescription: detail,
                type: .switch,
                isSwitchOn: isOn,
                switchDefaultValue: `default`,
                switchValueChangeAction: pageType.switchValueChangeAction,
                switchClickAction: pageType.switchClickAction
            )
        }
    
    /// 创建按钮类调试选项的辅助API
    func buttonEntryModel(
        title: String,
        icon: UIImage? = nil,
        subtitle: String? = nil,
        detail:String? = nil
    ) -> SettingsPageEntryModel {
        SettingsPageEntryModel(
            id: self.entryId,
            icon: icon,
            title: title,
            subtitle: subtitle,
            detailDescription: detail,
            type: .button,
            buttonClickAction: pageType.buttonClickAction)
    }
    
    /// 创建子页面类调试选项的辅助API
    func subPageEntryModel(
        title: String,
        icon: UIImage? = nil,
        subtitle: String? = nil,
        detail:String? = nil
    ) -> SettingsPageEntryModel {
        SettingsPageEntryModel(
            id: self.entryId,
            icon: icon,
            title: title,
            subtitle: subtitle,
            detailDescription: detail,
            type: .subpage,
            subpageJumpAction: pageType.subpageJumpAction)
    }
}
