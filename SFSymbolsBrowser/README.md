# SFSymbolsBrowser

A SwiftUI iOS 17 app for exploring SF Symbols with premium-style navigation, rich previews, and export tools. The repository now tracks a single canonical app after earlier experiments left multiple structures.

## Repository layout
- `SFSymbolsBrowser/` – app source, assets, services, view models, and views used by both the SwiftPM package and the Xcode project.
- `SFSymbolsBrowser/SFSymbolsBrowser.xcodeproj` – Xcode project referencing the same sources so the app can be opened directly in Xcode.
- `SFSymbolsBrowserTests/` – unit tests for repositories and view models.
- `Package.swift` – Swift Package manifest shared with Xcode for dependency resolution.

## What changed from the duplicate app history?
- Earlier commits contained two parallel app folders and missing Xcode metadata. The latest history consolidates everything into the `SFSymbolsBrowser` module above, with the Xcode project pointing at the same files.
- User-specific workspace state and stray `.DS_Store` files have been removed so the repo reflects only the shared project structure.
- SwiftLint/SwiftFormat are now configured for repeatable linting and formatting via Swift Package plugins or Mint.

## Tooling
- **SwiftLint**: Configured via `.swiftlint.yml`. Run with `swift package plugin --allow-writing-to-package-directory swiftlint` or `mint run realm/SwiftLint` once Mint is installed.
- **SwiftFormat**: Available through the Swift Package plugin or `mint run nicklockwood/SwiftFormat`.

## Building
The project targets iOS 17 with SwiftUI. On macOS, open `SFSymbolsBrowser/SFSymbolsBrowser.xcodeproj` or run `xcodebuild -scheme SFSymbolsBrowser -destination 'platform=iOS Simulator,name=iPhone 15'`.
