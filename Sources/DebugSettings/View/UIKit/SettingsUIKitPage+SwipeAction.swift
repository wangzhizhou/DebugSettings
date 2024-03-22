//
//  SettingsUIKitPage+SwipeAction.swift
//  DebugSettings
//
//  Created by joker on 2023/3/30.
//

import UIKit

extension SettingsUIKitPage {
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions = [UIContextualAction]()
        let entryItem = pageModel.sections[indexPath.section].items[indexPath.row]
        if entryItem.hasHelpInfo {
            let helpInfoAction = UIContextualAction(style: .normal, title: "使用说明") { action, view, completionHandler in
                entryItem.gotoHelpPage(navigationBarHeight: self.pageModel.navigationBarHeight)
                completionHandler(true)
            }
            helpInfoAction.backgroundColor = .systemTeal
            actions.append(helpInfoAction)
        }
        return  UISwipeActionsConfiguration(actions: actions)
    }
}
