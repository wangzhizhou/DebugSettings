//
//  File.swift
//  
//
//  Created by joker on 2022/10/30.
//

import Foundation

/// 定义页面ID
enum SettingsPage: String, CaseIterable {
    case main
    case subpage
    case swiftui
    
    /// 获取页面内设置项Id
    /// - Parameter entry: 设置项Id枚举定义
    /// - Returns: 设置项Id
    func entryId(for entry: SettingPageEntry) -> String {
        return "\(self.rawValue).\(entry.rawValue)"
    }
}

/// 定义页面页Settings项目Id，同一个枚举中可以保持读写时的唯一性
enum SettingPageEntry: String, CaseIterable {
    // 开关类
    case switch1
    case switch2

    // 按钮类
    case button1
    case button2

    // 子页面类
    case subpage1
    case subpage2

}
