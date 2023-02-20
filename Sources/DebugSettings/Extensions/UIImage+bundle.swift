//
//  File.swift
//  
//
//  Created by joker on 2022/11/25.
//

import UIKit
import Foundation

public extension UIImage {
    static func image(named name: String) -> UIImage? {
        let bundle = Bundle(for: SettingsUIKitPage.self)
        guard let resourceBundleUrl = bundle.url(forResource: "DebugSettings", withExtension: "bundle"), let resourceBundle = Bundle(url: resourceBundleUrl)
        else {
#if canImport(ObjcBridge)
            return UIImage(named: name, in: Bundle.module, compatibleWith: nil)
#else
            return nil
#endif
        }
        return UIImage(named: name, in: resourceBundle, compatibleWith: nil)
    }
}
