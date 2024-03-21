//
//  File.swift
//  
//
//  Created by joker on 2022/10/30.
//

import Foundation
#if canImport(Core)
import Core
#endif

/// 定义页面ID，在同一个枚举中定义，保证ID唯一
enum SettingsPage: String, CaseIterable, SettingsPageIdentifiable {
    
    case main
    case subpage
    case swiftui
    
    var id: String { self.rawValue }
}
