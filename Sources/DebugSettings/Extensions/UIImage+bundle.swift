//
//  File.swift
//  
//
//  Created by joker on 2022/11/25.
//

import UIKit

public extension UIImage {
    static func image(named name: String) -> UIImage? {
        let bundle = Bundle(for: SettingsUIKitPage.self)
        guard let resourceBundleUrl = bundle.url(forResource: "DebugSettings", withExtension: "bundle"), let resourceBundle = Bundle(url: resourceBundleUrl)
        else {
            return nil
        }
        return UIImage(named: name, in: resourceBundle, compatibleWith: nil)
    }
}
