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
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}
