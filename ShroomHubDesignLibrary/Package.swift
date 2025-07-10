// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShroomHubDesignLibrary",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ShroomHubDesignLibrary",
            targets: ["ShroomHubDesignLibrary"]),
    ],
    dependencies: [
        .package(path: "../SHUtils"),
        .package(path: "../CSRNetworkService"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.1"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.1.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ShroomHubDesignLibrary",
            dependencies: [
                .product(name: "SHUtils", package: "SHUtils"),
                .product(name: "CSRNetworkService", package: "CSRNetworkService"),
                .product(name: "Lottie", package: "lottie-ios"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
            ],
            resources: [
                .process("Resources/Fonts"),
            ]
        ),
        .testTarget(
            name: "ShroomHubDesignLibraryTests",
            dependencies: ["ShroomHubDesignLibrary"]
        ),
    ]
)
