// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftBrick",
    platforms: [
      .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftBrick",
            targets: ["SwiftBrick"])
    ],
    targets: [
        .target(name: "SwiftBrick",
                resources: [.process("Resources"),],
                swiftSettings: [.define("ENABLE_SPM"),]
               ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
