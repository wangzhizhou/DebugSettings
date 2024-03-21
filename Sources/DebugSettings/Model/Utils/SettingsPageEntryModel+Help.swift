//
//  SettingsPageEntryModel+Help.swift
//  DebugSettings
//
//  Created by joker on 2023/3/30.
//

import Foundation

#if canImport(Utils)
import Utils
#endif

extension SettingsPageEntryModel {
    
    var hasHelpInfo: Bool {
        return helpURL != nil
    }
    
    var helpURL: URL? {
        guard let url = self.helpInfoUrl, let URL = URL(string: url) else {
            return nil
        }
        return URL
    }
    
    func gotoHelpPage(navigationBarHeight: Int = 0) {
        
        let title = "\(self.title) 使用说明"
        
        guard let pageURL = self.helpURL,  let webPageJumpAction = SettingsManager.shared.bizWebPageJumpAction, webPageJumpAction(pageURL, title) else {
            let helpPage = WebPage()
            helpPage.title = title
            helpPage.pageURL = self.helpURL
            helpPage.navigationBarHeight = navigationBarHeight
            helpPage.pushOnTopViewController()
            // 走组件默认跳转逻辑事件回调业务方
            if let userActionHandler = SettingsManager.shared.userActionHandler {
                userActionHandler(self, .gotoHelpPageDefault)
            }
            
            return
        }
        
        // 走业务侧自定义跳转逻辑事件回调业务方
        if let userActionHandler = SettingsManager.shared.userActionHandler {
            userActionHandler(self, .gotoHelpPageBizCustom)
        }
    }
}
