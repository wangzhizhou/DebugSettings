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

@objcMembers
public class SettingsPageModel: ObjcBridgeClass, SettingsIdentifiable {
    
    public let id: String
    public let title: String
    public var navigationBarHeight: Int
    
    public static let notificationUserInfoPageIdKey = "page_id"
    
    public convenience init(id: String, title: String, navigationBarHeight: Int = 40, sectionsBlock: () -> [SettingsPageSectionModel]) {
        self.init(id: id, title: title, navigationBarHeight: navigationBarHeight, sections: sectionsBlock())
    }

    init(id: String, title: String, navigationBarHeight: Int, sections: [SettingsPageSectionModel]) {
        self.id = id
        self.title = title
        self.sections = sections
        self.navigationBarHeight = navigationBarHeight
    }
    let sections: [SettingsPageSectionModel]
}

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
    convenience init(id: String, name: String, navigationBarHeight: Int = 40, @SettingsPageBuilder content: () -> SettingsPageModel) {
        self.init(id: id, title: name, navigationBarHeight: navigationBarHeight, sections: content().sections)
    }
}
