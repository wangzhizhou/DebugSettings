//
//  UIViewController+Utils.swift
//  DebugSettings
//
//  Created by joker on 2023/3/31.
//

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
