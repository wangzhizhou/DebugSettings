//
//  File.swift
//  
//
//  Created by joker on 2022/11/3.
//

#if canImport(SwiftUI)
import SwiftUI

/// UIKit类App中用来承载SwiftUI视图的UIKit视图容器页面，用来支持在UIKit中使用SwiftUI页面视图
@available(iOS 13, *)
public class SettingsSwiftUIPage<Content>: UIHostingController<Content> where Content : View {
}
#endif

public func show(with pageModel: SettingsPageModel) {
    if #available(iOS 13, *) {
        let rootView = SettingsContentView(model: pageModel).navigationBarTitle(pageModel.title)
        SettingsSwiftUIPage(rootView: rootView).pushOnTopViewController()
    }
}
