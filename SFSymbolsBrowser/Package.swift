// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SFSymbolsBrowser",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SFSymbolsBrowser",
            targets: ["SFSymbolsBrowser"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", from: "5.3.0")
    ],
    targets: [
        .target(
            name: "SFSymbolsBrowser",
            dependencies: ["SFSafeSymbols"],
            path: "SFSymbolsBrowser"
        ),
        .testTarget(
            name: "SFSymbolsBrowserTests",
            dependencies: ["SFSymbolsBrowser"],
            path: "SFSymbolsBrowserTests"
        ),
    ]
)
