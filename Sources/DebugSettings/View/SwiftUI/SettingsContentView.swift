//
//  SwiftUIView.swift
//  
//
//  Created by joker on 2022/11/9.
//

#if canImport(SwiftUI)
import SwiftUI

#if canImport(Utils)
import Utils
#endif

extension SettingsPageSectionModel: Identifiable {
    public var id: String { UUID().uuidString }
}
extension SettingsPageEntryModel: Identifiable {}

/// SwiftUI版调试页面对应的视图，不带页面导航
@available(iOS 13, *)
public struct SettingsContentView: View {
    public let model: SettingsPageModel
    public init(model: SettingsPageModel) {
        self.model = model
    }
    public var body: some View {
        List {
            ForEach(model.sections) { section in
                VStack {
                    HStack {
                        Text("\(section.title)")
                            .font(.init(.system(size: 18)))
                            .bold()
                        Spacer()
                    }
                    ForEach(section.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                if let iconImage = item.icon {
                                    Image(uiImage: iconImage)
                                }
                                Text(item.title)
                                    .font(.init(.system(size: 16)))
                                    .bold()
                                    .frame(height: 20)
                                if let subtitle = item.subtitle {
                                    Text(subtitle)
                                        .foregroundColor(.gray)
                                        .font(.init(.system(size: 12)))
                                }
                                if let detailDescription = item.detailDescription {
                                    Text(detailDescription)
                                        .foregroundColor(.gray)
                                        .font(.init(.system(size: 8)))
                                }
                            }
                            Spacer()
                            if item.type == .switch {
                                Toggle("", isOn: Binding<Bool>(get: {
                                    item.isSwitchOn ?? false
                                }, set: { newValue in
                                    item.isSwitchOn = newValue
                                    
                                    // 开关值变化事件上抛
                                    if let userActionHandler = SettingsManager.shared.userActionHandler {
                                        userActionHandler(item, .valueChanged)
                                    }
                                }))
                                .frame(width: 64, height: 24)
                            }
                            if item.type == .subpage, let uiImage = UIImage.rightArrowImage {
                                Image(uiImage: uiImage)
                            }
                        }
                        .onTapGesture {
                            UIImpactFeedbackGenerator().impactOccurred()
                            switch item.type {
                            case .switch:
                                if let switchClickAction = item.switchClickAction {
                                    switchClickAction(item)
                                }
                            case .button:
                                if let buttonClickAction = item.buttonClickAction {
                                    buttonClickAction(item)
                                }
                            case .subpage:
                                if let subPageJumpAction = item.subpageJumpAction {
                                    subPageJumpAction(item, nil)
                                }
                            }
                            
                            // 统计用户点击行为
                            if let userActionHandler = SettingsManager.shared.userActionHandler {
                                userActionHandler(item, .click)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
        }
        .listStyle(PlainListStyle())
        
    }
}
#endif
