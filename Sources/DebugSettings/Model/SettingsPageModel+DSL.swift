//
//  File.swift
//  
//
//  Created by joker on 2022/11/23.
//

import Foundation

@resultBuilder
public struct SettingsPageBuilder {
    
    public static func buildBlock(_ components: SettingsPageSectionModel...) -> [SettingsPageSectionModel] {
        return components
    }
    
    public static func buildFinalResult(_ component: [SettingsPageSectionModel]) -> SettingsPageModel  {
        return SettingsPageModel(id: "", title: "", navigationBarHeight: 0, sections: component)
    }
}

public extension SettingsPageModel {
    
    /// 为支持声明式DSL创建方式新增的初始化方法
    /// - Parameters:
    ///   - id: 页面Id
    ///   - name: 页面名称
    ///   - navigationBarHeight: 页面导航栏高度
    ///   - content: 页面内容，包含多个Section
    convenience init(id: String, name: String, navigationBarHeight: Int = 0, @SettingsPageBuilder content: () -> SettingsPageModel) {
        self.init(id: id, title: name, navigationBarHeight: navigationBarHeight, sections: content().sections)
    }
}
