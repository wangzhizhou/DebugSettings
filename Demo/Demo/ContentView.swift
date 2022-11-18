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
                SettingsContentView(model: DebugSettingsDemo.switfuiModel)
                    .navigationTitle("SwiftUI调试页面")
            })
            .navigationBarItems(leading: NavigationLink("UIKit"){
                DebugSettingsUIKitPage()
            })
            .navigationTitle("Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DebugSettingsUIKitPage: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let uikitPage = DebugSettingsDemo.mainPage()
        return uikitPage
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
