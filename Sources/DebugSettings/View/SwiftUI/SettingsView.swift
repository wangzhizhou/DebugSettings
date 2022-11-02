//
//  SettingsView.swift
//  
//
//  Created by joker on 2022/11/1.
//
#if canImport(SwiftUI)
import SwiftUI

public struct SettingsView: View {
    let model: SettingsPageModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    public var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitle(model.title)
        .colorInvert()
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            if let backImage = UIImage.image(named: "leftArrow") {
                Image(uiImage: backImage)
            }
        }))
    }
}

#endif
