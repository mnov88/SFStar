# SF Symbols Browser

iOS app for browsing, customizing, and exporting 6,900+ SF Symbols with code generation.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Features

### Current Features
- Browse 6,900+ SF Symbols in responsive grid
- Real-time text search
- Category filtering (15 categories)
- Symbol detail view with weight customization
- Export symbols as PNG (@2x)
- Copy symbol name to clipboard
- Favorites system with star toggle
- Collections - organize symbols into groups
- Tab bar navigation (iPhone)
- Sidebar navigation (iPad)
- Dark mode support
- Comprehensive settings with data management

### Coming in Next Release
- Multi-scale export (@1x/@2x/@3x)
- SVG export
- Code generation (SwiftUI/UIKit)
- Semantic search
- Batch export

## Project Structure

```
SFStar/
├── README.md               # This file
├── SFSymbolsBrowser/       # Swift Package
│   ├── Package.swift       # Package definition
│   ├── SFSymbolsBrowser/   # App source code
│   │   ├── App/            # App entry point
│   │   ├── Models/         # Data structures
│   │   ├── ViewModels/     # Business logic (@Observable)
│   │   ├── Views/          # SwiftUI views
│   │   ├── Services/       # Business services
│   │   └── Repositories/   # Data access
│   └── SFSymbolsBrowserTests/
└── docs/                   # Documentation
    ├── PRD.md              # Product requirements
    ├── BUILD-PLAN-AI-ASSISTED.md
    └── mustread/           # Reference materials
```

### App Architecture

```
SFSymbolsBrowser/SFSymbolsBrowser/
├── App/                    # App entry point
│   ├── SFSymbolsBrowserApp.swift
│   └── ContentView.swift
├── Models/                 # Data structures
│   ├── SymbolItem.swift
│   ├── SymbolCategory.swift
│   ├── ExportConfiguration.swift
│   └── AppSettings.swift
├── ViewModels/             # Business logic (@Observable)
│   ├── SymbolGridViewModel.swift
│   └── SymbolDetailViewModel.swift
├── Views/                  # SwiftUI views
│   ├── Navigation/        # Tab bar & sidebar navigation
│   ├── Grid/              # Symbol grid views
│   ├── Detail/            # Symbol detail views
│   ├── Components/        # Reusable components
│   ├── Favorites/         # Favorites & collections
│   └── Settings/          # Settings views
├── Services/              # Business services
│   ├── ExportService.swift
│   ├── PersistenceService.swift
│   └── ErrorHandling.swift
└── Repositories/          # Data access
    └── SymbolRepository.swift
```

## Dependencies

- **SFSafeSymbols** (5.3.0+): Type-safe SF Symbol access

## Setup

1. Clone the repository
2. Open `SFSymbolsBrowser/Package.swift` in Xcode
3. Xcode will fetch SFSafeSymbols automatically
4. Build and run on iOS 17+ device or simulator

## Usage

### Browsing Symbols
- Launch app to see symbol grid
- Scroll through 6,900+ symbols
- Use search bar to find specific symbols
- Tap filter button to browse by category

### Customizing
- Tap any symbol to view details
- Select from 9 font weights
- Preview updates in real-time

### Exporting
- Tap "Export PNG @2x" to save symbol
- Files saved to Documents/SF Symbols Export/
- Access via Files app

### Favorites
- Tap star icon to favorite symbols
- Long-press symbols for quick actions
- View favorites in dedicated section

## Testing

```bash
# Run tests via Xcode
# Cmd+U or Product > Test

# Test coverage targets:
# - Models: 90%+
# - ViewModels: 85%+
# - Repositories: 85%+
```

## Design Principles

Follows Apple Human Interface Guidelines:
- **Clarity**: Clean grid, clear labels
- **Deference**: Symbols are the star
- **Depth**: Simple navigation hierarchy

## License

MIT License

## Credits

- SF Symbols by Apple
- SFSafeSymbols by the open source community
