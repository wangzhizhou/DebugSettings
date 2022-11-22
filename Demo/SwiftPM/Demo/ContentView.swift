//
//  ContentView.swift
//  Demo
//
//  Created by joker on 2022/11/9.
//
#if canImport(SwiftUI)
import SwiftUI
import DebugSettings

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
            .navigationBarItems(trailing:NavigationLink("SwiftUI") {
                SettingsContentView(model: DebugSettingsDemoSwiftUIPage.pageModel)
                    .navigationTitle("高级调试")
            })
            .navigationBarItems(leading:NavigationLink("UIKit") {
                DebugSettingsDemoUIKitPage()
            })
            .navigationTitle("SwiftUI Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DebugSettingsDemoUIKitPage: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let model = DebugSettingsDemoUIKitMainPage.pageModel
        let uikitVC = SettingsUIKitPage(pageModel: model)
        return uikitVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
