//
//  SettingsPageEntryModel+Help.swift
//  DebugSettings
//
//  Created by joker on 2023/3/30.
//

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
    
    func gotoHelpPage() {
        
        let title = "\(self.title) 使用说明"
        
        guard let pageURL = self.helpURL,  let webPageJumpAction = SettingsManager.shared.bizWebPageJumpAction, webPageJumpAction(pageURL, title) else {
            let helpPage = WebPage()
            helpPage.title = title
            helpPage.pageURL = self.helpURL
            helpPage.pushOnTopViewController()
            return
        }
    }
}
