//
//  BasePage.swift
//  DebugSettings
//
//  Created by joker on 2023/3/31.
//

import UIKit
import SnapKit

open class BasePage: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            self.view.backgroundColor = UIColor(dynamicProvider: { trait in
                if trait.userInterfaceStyle == .light {
                    return .white
                } else {
                    return .clear
                }
            })
        } else {
            self.view.backgroundColor = .white
        }
    }

    public var navigationBarHeight: Int = 0
    public func adjustFullPageView(_ fullPageView: UIView) {
        
        guard fullPageView.superview == self.view else {
            return
        }
        
        fullPageView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(navigationBarHeight)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            }
        }
    }
}
