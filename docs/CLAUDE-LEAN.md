# SF Symbols Browser

iOS app for browsing and exporting 6,900+ SF Symbols.

## Tech Stack

- **Language:** Swift 5.9+
- **Framework:** SwiftUI
- **Min iOS:** 17.0
- **Architecture:** MVVM
- **Dependencies:** None (avoid adding)

## Project Rules

### What We're Building
Browse SF Symbols. Customize (weight, color). Export (PNG/SVG). Generate code (SwiftUI/UIKit).

### Critical Constraints
- iOS 17+ ONLY - Use @Observable, not @StateObject
- Pure SwiftUI - No UIKit unless absolutely necessary
- No external dependencies except symbol type-safety if needed
- Symbol data embedded in app (no API)
- Export to Files app (not Photos)

### File Organization
```
Models/       - Data structures only
Views/        - SwiftUI views only  
ViewModels/   - Business logic with @Observable
Repositories/ - Data access layer
Services/     - Utilities (rendering, export)
Resources/    - JSON data files
```

### Naming Conventions
- Types: PascalCase
- Functions: camelCase  
- Files match type names
- No abbreviated names

### Patterns to ALWAYS Use
- Structs over classes
- @Observable for ViewModels (iOS 17+)
- NavigationStack (not NavigationView)
- Result<T,E> for error handling
- Guard for early returns

### Patterns to NEVER Use
- Force unwrapping (!)
- Any type without comment
- Default exports
- @StateObject or @ObservedObject
- localStorage/sessionStorage (doesn't work in sandbox)

### Symbol Handling
- Symbol names always snake_case: "heart.fill"
- Check iOS compatibility before using
- Cache rendered images
- Never hardcode symbol strings

## Common Commands

```bash
# Open project
open SFSymbolsBrowser.xcodeproj

# Run tests
Cmd+U in Xcode

# Build
Cmd+B in Xcode
```

## Current Gotchas

**None yet - document as discovered**

## Testing
- XCTest framework
- 80% coverage minimum
- Test ViewModels and Repositories
- Name: test_method_condition_result