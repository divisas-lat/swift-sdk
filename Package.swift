// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "divisas-swift-sdk",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "DivisasLat",
            targets: ["DivisasLat"]),
    ],
    targets: [
        .target(
            name: "DivisasLat"),
        .testTarget(
            name: "DivisasLatTests",
            dependencies: ["DivisasLat"]),
    ]
)
