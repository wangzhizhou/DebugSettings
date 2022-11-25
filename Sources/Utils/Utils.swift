//
//  Utils.swift
//  
//
//  Created by joker on 2022/10/27.
//

import UIKit

public extension UIImage {
    static func image(named name: String) -> UIImage? {
#if !canImport(ObjcBridge)
        let bundle = Bundle(for: SettingsUIKitPage.self)
        return UIImage(named: name, in: bundle, compatibleWith: nil)
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
    
    @objc func pushOnTopViewController() {
        UIViewController.topViewController()?.navigationController?.pushViewController(self, animated: true)
    }
    
    @objc static func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        var keyWindow: UIWindow?
        if #available(iOS 13, *) {
            keyWindow = UIApplication
                .shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        
        let base = base ?? keyWindow?.subviews.compactMap{ $0.next as? UIViewController }.last ?? keyWindow?.rootViewController
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
