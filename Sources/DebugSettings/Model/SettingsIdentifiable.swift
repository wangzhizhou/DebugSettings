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

public protocol SettingsIdentifiable: ObjcBridgeProtocol {
    var id: SettingsIdentifier { get }
}
