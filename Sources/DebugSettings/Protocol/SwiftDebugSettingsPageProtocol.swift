//
//  SwiftDebugSettingsPageProtocol.swift
//  DebugSettings
//
//  Created by joker on 2022/11/16.
//

import Foundation

@objc
public protocol SwiftDebugSettingsPageProtocol: ObjcBridgeProtocol {
    static var pageId: String { get }
    static var pageModel: SettingsPageModel { get }
    static weak var weakPage: SettingsUIKitPage? { get set }
    static func setup()
    static func show()
    static func showToast(_ message: String)
}