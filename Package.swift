// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIExt",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
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
