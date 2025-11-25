// swift-tools-version: 5.9
import PackageDescription

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/Rspoon3/SFSymbols.git", from: "5.0.0")
]

#if os(macOS)
dependencies.append(contentsOf: [
    .package(url: "https://github.com/realm/SwiftLint.git", from: "0.55.1"),
    .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.52.17")
])
#endif

#if os(macOS)
let lintPlugins: [Target.PluginUsage] = [
    .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint"),
    .plugin(name: "SwiftFormatPlugin", package: "SwiftFormat")
]
#else
let lintPlugins: [Target.PluginUsage] = []
#endif

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
    dependencies: dependencies,
    targets: [
        .target(
            name: "SFSymbolsBrowser",
            dependencies: ["SFSymbols"],
            path: "SFSymbolsBrowser",
            plugins: lintPlugins
        ),
        .testTarget(
            name: "SFSymbolsBrowserTests",
            dependencies: ["SFSymbolsBrowser"],
            path: "SFSymbolsBrowserTests"
        ),
    ]
)
