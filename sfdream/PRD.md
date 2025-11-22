# SF Symbols Browser - Product Requirements

## Overview
iOS app for browsing, customizing, and exporting SF Symbols with code generation.

## Technical Foundation
- **Platform:** iOS 25.0+ (NOT iOS 17)
- **Language:** Swift 5.9+
- **Framework:** SwiftUI
- **Dependencies:** SFSafeSymbols (type-safe symbol access)
- **Architecture:** MVVM
- **Design System:** Follow `apple-design-principles-2025.md`

## Core Features

### Browse & Search
- Display all SF Symbols in grid (6,900+ symbols)
- Real-time text search
- Semantic keyword search (e.g., "upload" finds arrow.up symbols)
- Category filtering
- iOS version compatibility filtering

### Customize
- Weight selection (9 weights: Ultralight → Black)
- Color picker with custom colors
- Rendering mode (Monochrome, Hierarchical, Palette, Multicolor)
- Live preview of customizations

### Export
- PNG export (@1x, @2x, @3x - multi-select)
- SVG export (vector format)
- Batch export (multiple symbols at once)
- Save to Files app

### Code Generation
- SwiftUI code generation
- UIKit code generation
- Copy to clipboard
- Includes all customizations (weight, color, rendering mode)

### Organization
- Favorites system
- User-created collections
- Persistent storage (UserDefaults)

### Settings
- Default export format
- Default export scales
- Target iOS version for compatibility filtering
- Grid display options

## Navigation Structure

**iPhone:**
- Tab bar with 3 tabs: Search, Favorites, Settings
- NavigationStack within each tab

**iPad:**
- NavigationSplitView with sidebar
- Sidebar: Search, Favorites, Collections, Settings
- Multi-pane detail view
- Keyboard shortcuts
- Drag & drop support

## Data Source

### SFSafeSymbols Package
- **Purpose:** Type-safe symbol access, compile-time checking
- **Usage:** 
  - `Image(systemSymbol: .heartFill)` instead of `Image(systemName: "heart.fill")`
  - Automatic iOS version availability checking via @available
  - Enum-based access prevents typos
- **Documentation:** https://github.com/SFSafeSymbols/SFSafeSymbols
- **Version:** Latest (6.2+)

### Symbol Metadata
- Symbol names from SFSafeSymbols enum
- Categories: Manual categorization (15 groups)
- Keywords: JSON mapping file for semantic search
- iOS compatibility: From SFSafeSymbols @available attributes

## Key Requirements

### Performance
- Lazy loading for 6,900+ symbols
- Image caching (NSCache)
- Batch processing for exports (groups of 10 with autoreleasepool)
- 60fps scrolling

### Accessibility
- VoiceOver support
- Dynamic Type support
- Keyboard navigation (iPad)
- Sufficient color contrast

### Quality
- 80% test coverage minimum
- SwiftUI previews for all views
- XCTest for business logic
- No force unwrapping (!)

## Non-Goals
- Custom symbol creation
- Symbol editing
- Animation preview (future consideration)
- Cloud sync (local storage only)
- In-app purchases (free app)

## References
- Design patterns: `apple-design-principles-2025.md`
- SFSafeSymbols docs: https://github.com/SFSafeSymbols/SFSafeSymbols ALSO LOCLLY STORED VITAL TO CONSULT
- SF Symbols 7: 6,900+ symbols available
 
