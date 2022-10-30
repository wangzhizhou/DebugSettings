//
//  File.swift
//  
//
//  Created by joker on 2022/10/29.
//

import Foundation

class Persistence {

    // MARK: 持久化
    static let settingsStore = UserDefaults(suiteName: "com.joker.settings.entries")
    static func boolValueForId(_ identifier: String) -> Bool? {
        guard let obj = settingsStore?.object(forKey: identifier) else {
            return nil
        }
        return obj as? Bool
    }
    
    static func saveBoolValue(_ value: Bool, for id: String) {
        settingsStore?.set(value, forKey: id)
    }
    
    static func clearAll() {
        
    }
}