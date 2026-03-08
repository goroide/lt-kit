// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LTKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "LTKit", targets: ["LTKit"]),
    ],
    targets: [
        .target(
            name: "LTKit",
            path: "Sources/LTKit"
        ),
        .testTarget(
            name: "LTKitTests",
            dependencies: ["LTKit"],
            path: "Tests/LTKitTests"
        ),
    ]
)
