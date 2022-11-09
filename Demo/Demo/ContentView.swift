//
//  ContentView.swift
//  Demo
//
//  Created by joker on 2022/11/9.
//

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
            .navigationBarItems(trailing: NavigationLink("调试工具") {
                SettingsContentView(model: DebugSettingsDemo.switfuiModel)
            })
            .navigationTitle("Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DebugSettingsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return DebugSettingsDemo.swiftUIPage()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
