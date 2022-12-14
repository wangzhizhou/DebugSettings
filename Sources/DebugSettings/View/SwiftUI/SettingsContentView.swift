//
//  SwiftUIView.swift
//  
//
//  Created by joker on 2022/11/9.
//

#if canImport(SwiftUI)
import SwiftUI

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
        VStack {
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
                                if let title = item.title {
                                    Text(title)
                                        .font(.init(.system(size: 16)))
                                        .bold()
                                        .frame(height: 20)
                                }
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
                                }))
                                .frame(width: 64, height: 24)
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
                        }
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
            Spacer()
        }
        
    }
}
#endif
