// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DebugSettings",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "DebugSettings", targets: ["DebugSettings"]),
        .library(name: "DemoPages", targets: ["DemoPages"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
        .package(url: "https://github.com/scalessec/Toast-Swift.git", from: "5.1.0"),

        // [SwiftDocCPlugin](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/)
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),

        // [LookIn Offical Website](https://lookin.work/)
        // [MacOS App](https://github.com/hughkli/Lookin/)
        // [LookInServer](https://github.com/QMUI/LookinServer)
        .package(url: "https://github.com/QMUI/LookinServer/", .upToNextMajor(from: "1.0.0")),

        // [FLEX](https://github.com/FLEXTool/FLEX)
        .package(url: "https://github.com/FLEXTool/FLEX.git", .upToNextMajor(from: "5.22.10")),

        // [atlantis with proxyman](https://github.com/ProxymanApp/atlantis.git)
        .package(url: "https://github.com/ProxymanApp/atlantis", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "DemoPages", dependencies: ["DebugSettings", "DebugTools"]),
        .target(name: "DebugSettings", dependencies: ["Persistence", "ObjcBridge"]),
        .target(name: "Persistence"),
        .testTarget(name: "DebugSettingsTests", dependencies: ["DebugSettings"]),
        .target(name: "DebugTools", dependencies: [
            "LookinServer", "Utils", "ObjcBridge", "FLEX",
            .product(name: "Atlantis", package: "Atlantis")
        ]),
        .target(name: "ObjcBridge"),
        .target(name: "Utils", dependencies: [
            .product(name: "Toast", package: "Toast-Swift"),
            .product(name: "SnapKit", package: "SnapKit")
        ])
    ],
    swiftLanguageVersions: [.v5]
)
