// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CypherBuilder",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(name: "CypherBuilder", targets: ["CypherBuilder"]),
    ],
    targets: [
        .target(name: "CypherBuilder"),
        .testTarget(
            name: "CypherBuilderTests",
            dependencies: [
                "CypherBuilder",
            ]
        ),
    ]
)
