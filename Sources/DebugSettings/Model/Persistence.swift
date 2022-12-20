//
//  File.swift
//  
//
//  Created by joker on 2022/10/29.
//

import Foundation

/// 处理数据持久化相关的逻辑
public class Persistence {

    static let settingsStore = UserDefaults(suiteName: "com.joker.settings.entries")
    
    /// 获取指定id对应的存储布尔值
    /// - Parameter identifier: 存储Id
    /// - Returns: 存储id对应的布尔值
    static func boolValueForId(_ identifier: String) -> Bool? {
        guard let obj = settingsStore?.object(forKey: identifier) else {
            return nil
        }
        return obj as? Bool
    }
    
    /// 保存指定ID对应的布尔值
    /// - Parameters:
    ///   - value: 需要存储的布尔值
    ///   - id: 对应的Id
    static func saveBoolValue(_ value: Bool, for id: String) {
        settingsStore?.set(value, forKey: id)
    }
    
    
    /// 移除指定ID对应的布尔值
    /// - Parameter id: 对应的ID
    static func removeBoolValue(for id: String) {
        settingsStore?.removeObject(forKey: id)
        settingsStore?.synchronize()
    }
    
    /// 清除所有存储的Key
    static func clearAll() {
        settingsStore?.dictionaryRepresentation().keys.forEach {
            settingsStore?.removeObject(forKey: $0)
        }
        settingsStore?.synchronize()
    }
    
}
