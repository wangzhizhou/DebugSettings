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

    /// 调试页面唯一标识符
    static var pageId: String { get }

    /// 调试页数据模型
    static var pageModel: SettingsPageModel { get }

    static weak var weakPage: SettingsUIKitPage? { get set }

    /// 调试页设置
    static func setup()

    /// 调试页展示
    static func show()

    /// 调试页内部展示Toast提示
    /// - Parameter message: toast内容
    static func showToast(_ message: String)
}
