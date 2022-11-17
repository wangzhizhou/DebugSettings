//
//  SettingsManager.swift
//  
//
//  Created by joker on 2022/10/27.
//

import Foundation
#if canImport(ObjcBridge)
import ObjcBridge
#endif

public class SettingsManager: ObjcBridgeClass {
    static let shared = SettingsManager()
    private override init() {}
}

public extension SettingsManager {
    
    /// 获取开关项是否打开状态值
    /// - Parameter id: 开关项的Id
    /// - Returns: 开关的打开关闭状态
    static func switchEnable(for id: String) -> Bool {
        guard !id.isEmpty
        else {
            return false
        }
        return Persistence.boolValueForId(id) ?? false
    }
    
    /// 刷新指定页面
    /// - Parameters:
    ///   - pageId: 页面id
    ///   - throttleInterval: throttle间隔
    static func refreshPage(for pageId: String, throttleInterval: DispatchTimeInterval = .milliseconds(250)) {
        guard !pageId.isEmpty
        else {
            return
        }
        if !refreshThrottling {
            refreshThrottling = true
            NotificationCenter.default.post(name: .SettingsPageRefresh, object: nil, userInfo: [SettingsPageModel.notificationUserInfoPageIdKey: pageId])
            DispatchQueue.main.asyncAfter(deadline: .now() + throttleInterval) {
                refreshThrottling = false
            }
        }
    }
    
    private static var refreshThrottling = false
}

extension Notification.Name {
    static let SettingsPageRefresh = Notification.Name("com.debug.settings.page.refresh.notification")
}
