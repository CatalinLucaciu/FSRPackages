// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ForesterServiceKit",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ForesterServiceKit",
            targets: ["ForesterServiceKit"]),
    ],
    dependencies: [
        .package(path: "../FirebaseAuthentication"),
        .package(path: "../FirebaseDatabaseHandler"),
        .package(path: "../ForesterDomainKit"),
        .package(path: "../HealthKitHandler")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ForesterServiceKit",
            dependencies: [
                .product(name: "FirebaseAuthentication", package: "FirebaseAuthentication"),
                .product(name: "FirebaseDatabaseHandler", package: "FirebaseDatabaseHandler"),
                .product(name: "ForesterDomainKit", package: "ForesterDomainKit"),
                .product(name: "HealthKitHandler", package: "HealthKitHandler")
            ]
        ),
        .testTarget(
            name: "ForesterServiceKitTests",
            dependencies: ["ForesterServiceKit"]),
    ]
)
