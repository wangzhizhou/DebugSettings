//
//  LocalPushDemoPage+Show.swift
//  Debugger
//
//  Created by joker on 2022/11/4.
//

import Foundation

@available(iOS 10.0, *)
extension LocalPushDemoPage {
    static func show() {
        LocalPushDemoPage().pushOnTopViewController()
    }
}
