# SF Symbols Browser

iOS app for browsing, customizing, and exporting 6,900+ SF Symbols with code generation.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Features

### MVP (Current)
- Browse 6,900+ SF Symbols in responsive grid
- Real-time text search
- Category filtering (15 categories)
- Symbol detail view with weight customization
- Export symbols as PNG (@2x)
- Copy symbol name to clipboard
- Favorites system
- Dark mode support
- iPhone and iPad layouts

### Coming in Product Release
- Multi-scale export (@1x/@2x/@3x)
- SVG export
- Code generation (SwiftUI/UIKit)
- Semantic search
- Collections
- Batch export

## Architecture

```
SFSymbolsBrowser/
├── App/                    # App entry point
├── Models/                 # Data structures
│   ├── SymbolItem.swift
│   ├── SymbolCategory.swift
│   ├── ExportConfiguration.swift
│   └── AppSettings.swift
├── ViewModels/             # Business logic (@Observable)
│   ├── SymbolGridViewModel.swift
│   └── SymbolDetailViewModel.swift
├── Views/                  # SwiftUI views
│   ├── Grid/              # Symbol grid views
│   ├── Detail/            # Symbol detail views
│   ├── Components/        # Reusable components
│   ├── Favorites/         # Favorites views
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
2. Open `Package.swift` in Xcode or run `swift build`
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
