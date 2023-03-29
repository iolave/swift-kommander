// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "CLIKommander",
    products: [
        .library(
            name: "CLIKommander",
            targets: ["CLIKommander"]
        ),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "CLIKommander",
            dependencies: []
        ),
        .testTarget(
            name: "CLIKommanderTests",
            dependencies: ["CLIKommander"]
        ),
    ]
)
