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
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
//        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "SwiftBrick",
//                dependencies: ["SnapKit"],
                resources: [.process("Resources"),],
//                cSettings: [.define("CAN_COMPILE", .when(configuration: .debug)),],
                swiftSettings: [.define("ENABLE_SPM"),]
               ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
