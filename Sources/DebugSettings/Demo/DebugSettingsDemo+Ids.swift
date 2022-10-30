//
//  File.swift
//  
//
//  Created by joker on 2022/10/30.
//

import Foundation

/// 定义页面ID
enum SettingsPageId: String, CaseIterable {
    case main
    case subpage
}

/// 定义页面内部SectionID
enum SettingsSectionId: String, CaseIterable {
    case section1
    case section2
    case section3
    case section4
}

/// 定义开关类型的设置项ID
enum SettingsEntrySwitchId: String, CaseIterable {
    case switch1
    case switch2
    case switch3
    case switch4
    case switch5
}

/// 定义按钮类型的设置项ID
enum SettingsEntryButtonId: String, CaseIterable {
    case button1
    case button2
    case button3
    case button4
    case button5
}

/// 定义子页面类型的设置项ID
enum SettingsEntrySubPageId: String, CaseIterable {
    case page1
    case page2
    case page3
    case page4
}
