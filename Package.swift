// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sachista-chess-swift",
    products: [
        .library(
            name: "sachista-core",
            targets: ["SachistaCore"]),
        .executable(
            name: "sachista-perft",
            targets: ["SachistaPerft"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SachistaCore",
            dependencies: []),
        .testTarget(
            name: "SachistaCoreTests",
            dependencies: ["SachistaCore"]),
        .target(
    	    name: "SachistaPerft",
    	    dependencies: ["SachistaCore"]),
    ]
)
