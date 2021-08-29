// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIExt",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_12),
        .tvOS(.v10),
        .watchOS(.v3),
    ],
    products: [
        .library(
            name: "SwiftUIExt",
            targets: ["SwiftUIExt"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUIExt",
            dependencies: [
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
