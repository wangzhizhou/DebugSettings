//
//  File.swift
//  
//
//  Created by joker on 2023/3/30.
//

import Foundation

public extension SettingsManager {
    /// 仅用来组件开发过程中测试使用，业务方不应该调用该方法
    static func defaultSetup() {
        // 业务方实现用户行为数据统计上报
        SettingsManager.setUserActionHandler { entryItem, actionType in
            print("entryItem: \(entryItem.type), actionType: \(actionType)")
        }
        
        // 业务方实现自定义的webView跳转逻辑, 返回false使用组件内部默认WebPage跳转逻辑
        SettingsManager.setBizWebPageJumpAction { pageURL, pageTitle in
            return false
        }
    }
}
