// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClendarTheme",
    platforms: [
        .iOS(.v13),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "ClendarTheme",
            targets: ["ClendarTheme"])
    ],
    targets: [
        .target(
            name: "ClendarTheme",
            dependencies: [])
    ]
)
