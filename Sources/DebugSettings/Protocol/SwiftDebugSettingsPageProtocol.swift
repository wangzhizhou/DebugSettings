//
//  SwiftDebugSettingsPageProtocol.swift
//  DebugSettings
//
//  Created by joker on 2022/11/16.
//

import Foundation
#if canImport(ObjcBridge)
import ObjcBridge
#endif

/// 调试页面需要遵循的协议
@objc
public protocol SwiftDebugSettingsPageProtocol: DSObjcBridgeProtocol {
    static var pageId: String { get }
    static var pageModel: SettingsPageModel { get }
    static weak var weakPage: SettingsUIKitPage? { get set }
    static func setup()
    static func show()
    static func showToast(_ message: String)
}
