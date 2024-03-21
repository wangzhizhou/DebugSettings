//
//  SettingsPageModel.swift
//  
//
//  Created by joker on 2022/10/27.
//

import Foundation
#if canImport(ObjcBridge)
import ObjcBridge
#endif

/// 调试选项页面对应的数据模型
///
/// 可使用常规init方法创建，也可以使用DSL创建，参考：``SettingsPageBuilder``
@objcMembers
public class SettingsPageModel: DSObjcBridgeClass, SettingsIdentifiable {
    
    /// 页面Id
    public let id: String
    
    /// 页面标题
    public let title: String
    
    /// 页面导航栏的高度，在页面使用自定义导航栏时使用
    public var navigationBarHeight: Int
    
    /// 在发通知刷新页面时传userInfo时设置的page_id字段的Key名称
    public static let notificationUserInfoPageIdKey = "page_id"
    
    public convenience init(id: String, title: String, navigationBarHeight: Int = 0, sectionsBlock: () -> [SettingsPageSectionModel]) {
        self.init(id: id, title: title, navigationBarHeight: navigationBarHeight, sections: sectionsBlock())
    }
    
    /// 在当前的页面数据模型中取出指定Id对应的调试选项数据模型
    /// - Parameter id: 调试选项数据模型的id
    /// - Returns: 返回的调试选项数据模型数组
    public func entryModels(for id: String) -> [SettingsPageEntryModel] {
        return self.sections.flatMap { $0.items }.filter { $0.id == id }
    }

    init(id: String, title: String, navigationBarHeight: Int, sections: [SettingsPageSectionModel]) {
        self.id = id
        self.title = title
        self.sections = sections
        self.navigationBarHeight = navigationBarHeight
    }
    
    /// 调试页面内包含的各Section数据模型
    let sections: [SettingsPageSectionModel]
}
