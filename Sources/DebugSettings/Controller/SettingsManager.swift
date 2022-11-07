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

extension SettingsManager {
    
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
    /// - Parameter id: 页面id
    static func refreshPage(for pageId: String) {
        guard !pageId.isEmpty
        else {
            return
        }
        NotificationCenter.default.post(name: .SettingsPageRefresh, object: nil, userInfo: [SettingsPageModel.notificationUserInfoPageIdKey: pageId])
    }
}

extension Notification.Name {
    static let SettingsPageRefresh = Notification.Name("com.debug.settings.page.refresh.notification")
}
