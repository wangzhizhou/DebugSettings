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
            .navigationBarItems(trailing:NavigationLink("高级调试") {
                SettingsContentView(model: DebugSettingsDemoSwiftUIPage.pageModel)
                    .navigationTitle("高级调试")
            })
            .navigationTitle("SwiftUI Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
