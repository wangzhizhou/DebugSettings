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
    
    @Environment(\.scenePhase) var scenePhase: ScenePhase
    
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
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                SettingsManager.defaultSetup()
            default:
                break
            }
        }
    }
}

struct DebugSettingsDemoUIKitPage: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let uikitVC = SettingsUIKitPage(pageModel: DebugSettingsDemoUIKitMainPage.pageModel)
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
