//
//  File.swift
//  
//
//  Created by joker on 2022/10/27.
//

import UIKit

extension UIImage {
    static func image(named name: String) -> UIImage? {
#if canImport(ObjcBridge)
        return UIImage(named: name, in: Bundle.module, compatibleWith: nil)
#else
        return UIImage(named: name)
#endif
    }
}
