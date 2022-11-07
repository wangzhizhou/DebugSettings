//
//  Utils.swift
//  
//
//  Created by joker on 2022/10/27.
//

import UIKit

public extension UIImage {
    static func image(named name: String) -> UIImage? {
#if canImport(ObjcBridge)
        return UIImage(named: name, in: Bundle.module, compatibleWith: nil)
#else
        return UIImage(named: name)
#endif
    }
}


public extension String {
    func toJSONObject() -> Any? {
        guard let jsonData = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    }
    
    func toJsonDictionary() -> [String: Any]? {
        return self.toJSONObject() as? Dictionary<String,Any>
    }
    
    func toJsonArray() -> Array<Any>?{
        return self.toJSONObject() as? Array<Any>
    }
}

public extension UIViewController {
    
    func pushOnTopViewController() {
        UIViewController.topViewController()?.navigationController?.pushViewController(self, animated: true)
    }
        
    static func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? UIApplication.shared.keyWindow?.subviews.compactMap{ $0.next as? UIViewController }.last ?? UIApplication.shared.keyWindow?.rootViewController
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
