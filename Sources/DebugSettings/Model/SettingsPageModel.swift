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
    
    public init(id: String, title: String, navigationBarHeight: Int = 40, sections: () -> [SettingsPageSectionModel]) {
        self.id = id
        self.title = title
        self.sections = sections()
        self.navigationBarHeight = navigationBarHeight
    }
    
    let sections: [SettingsPageSectionModel]
}

