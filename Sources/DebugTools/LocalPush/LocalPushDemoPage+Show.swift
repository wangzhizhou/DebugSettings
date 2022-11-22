//
//  LocalPushDemoPage+Show.swift
//  Debugger
//
//  Created by joker on 2022/11/4.
//

import Foundation
import UIKit
#if canImport(Utils)
import Utils
#endif

@available(iOS 10.0, *)
public extension LocalPushDemoPage {
    static func show() {
        let page = LocalPushDemoPage()
        page.pushOnTopViewController()
    }
}
