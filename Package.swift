// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Bottomify",
    products: [
        .library(
            name: "Bottomify",
            targets: ["Bottomify"]),
        .executable(name: "bottomify", targets: ["BottomifyCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.2"),
        .package(url: "https://github.com/JohnSundell/Files", from: "4.2.0"),
    ],
    targets: [
        .target(
            name: "Bottomify",
            dependencies: []),
        .target(
            name: "BottomifyCLI",
            dependencies: ["Bottomify", "SwiftCLI", "Files"]),
        .testTarget(
            name: "BottomifyTests",
            dependencies: ["Bottomify"]),
    ]
)
