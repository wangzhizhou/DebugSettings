// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DebugSettings",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DebugSettings",
            targets: ["DebugSettings"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0"),
        .package(url: "https://github.com/scalessec/Toast-Swift.git", from: "5.0.1"),
        // [SwiftDocCPlugin](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/)
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DebugSettings",
            dependencies: [
                "DebugTools",
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Toast", package: "Toast-Swift")
            ]),
        .testTarget(
            name: "DebugSettingsTests",
            dependencies: ["DebugSettings"]),
        .target(name: "DebugTools", dependencies: ["Utils"]),
        .target(name: "Utils", dependencies: [
            "ObjcBridge",
            .product(name: "Toast", package: "Toast-Swift"),
            .product(name: "SnapKit", package: "SnapKit"),
        ]),
        .target(name: "ObjcBridge")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
