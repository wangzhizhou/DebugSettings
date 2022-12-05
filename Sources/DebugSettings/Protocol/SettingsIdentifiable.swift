//
//  File.swift
//  
//
//  Created by joker on 2022/10/27.
//

import Foundation
#if canImport(ObjcBridge)
import ObjcBridge
#endif

/// 用于支持Swift/OC混编的类型遵循的ID协议
public protocol SettingsIdentifiable: DSObjcBridgeProtocol {
    var id: String { get }
}

/// 用于仅在Swift环境下使用类型遵循的ID协议
public protocol SettingsPageIdentifiable {
    var id: String { get }
}
