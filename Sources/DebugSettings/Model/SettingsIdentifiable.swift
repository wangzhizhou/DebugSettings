//
//  File.swift
//  
//
//  Created by joker on 2022/10/27.
//

import Foundation
import ObjcBridge

public protocol SettingsIdentifiable: ObjcBridgeProtocol {
    var id: String { get }
}
