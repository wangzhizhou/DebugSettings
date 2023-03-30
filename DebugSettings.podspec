#
#  Be sure to run `pod spec lint DebugSettings.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "DebugSettings"
  spec.version      = "0.0.1"
  spec.summary      = "这个组件用来简化添加调试开关的流程, 方便App快速添加各种调试工具。"
  spec.description  = <<-DESC
  这个组件用来简化添加调试开关的流程, 方便App快速添加各种调试工具。
                   DESC
  spec.homepage     = "https://github.com/wangzhizhou/DebugSettings"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "wangzhizhou" => "824219521@qq.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/wangzhizhou/DebugSettings.git", :tag => "#{spec.version}" }
  spec.module_name   = 'DebugSettings'
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  spec.requires_arc = true
  spec.swift_version = '5.0'
  spec.default_subspec = ['Core']
  
  swiftui_module_files = [
    "Sources/DebugSettings/Demo/**/DebugSettingsDemoSwiftUIPage.swift",
    "Sources/DebugSettings/View/SwiftUI/**/*.{swift}"
  ]
  
  spec.subspec 'Core' do |cs|
    cs.source_files  = "Sources/DebugSettings/**/*.{swift}"
    cs.exclude_files = swiftui_module_files
    cs.resource_bundles = {
      'DebugSettings' => ["Sources/DebugSettings/Resources/*.xcassets"]
    }
    cs.dependency "DebugSettings/DebugTools"
  end
  
  spec.subspec 'SwiftUI' do |swiftui|
    swiftui.source_files  = swiftui_module_files
    swiftui.dependency "DebugSettings/Core"
  end
  
  spec.subspec 'DebugTools' do |dt|
    dt.source_files = "Sources/DebugTools/**/*.{h,m,swift}"
    dt.dependency "DebugSettings/OCBridge"
    dt.dependency "DebugSettings/Utils"
    dt.dependency "Toast-Swift", "~> 5.0.1"
    dt.dependency "SnapKit", "~> 5.0.0"
  end
  
  spec.subspec 'OCBridge' do |oc|
    oc.source_files  = "Sources/ObjcBridge/**/*.{h,m}"
  end
  
  spec.subspec 'Utils' do |us|
    us.source_files = "Sources/Utils/**/*.{h,m,swift}"
  end
  
end
