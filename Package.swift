import Foundation
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftResultExt",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SwiftResultExt",
            targets: ["SwiftResultExt"]
        )
    ],
    targets: [
        .target(
            name: "SwiftResultExt"
        ),
        .testTarget(
            name: "SwiftResultExtTests",
            dependencies: ["SwiftResultExt"]
        )
    ],
    swiftLanguageModes: [.v6]
)
