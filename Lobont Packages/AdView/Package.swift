// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdView",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AdView",
            targets: ["AdView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", .upToNextMajor(from: Version("11.0.0")))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AdView",
        dependencies: [.product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads")]
        ),
        .testTarget(
            name: "AdViewTests",
            dependencies: ["AdView"]),
    ]
)
