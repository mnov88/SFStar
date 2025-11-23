# SF Symbols Browser - Product Requirements Document
**Version:** 2.0 (AI-Assisted Development)
**Last Updated:** November 2025

---

## Overview

iOS app for browsing, customizing, and exporting 6,900+ SF Symbols with code generation capabilities. Built using AI-assisted development with Claude Code for rapid, high-quality implementation.

---

## Technical Foundation

### Platform & Language
| Requirement | Specification |
|-------------|---------------|
| **Platform** | iOS 17.0+ (iOS 26.0+ for Liquid Glass) |
| **Language** | Swift 5.9+ |
| **Framework** | SwiftUI |
| **Architecture** | MVVM with @Observable |
| **Dependencies** | SFSafeSymbols 7.0+ (type-safe symbol access) |

### AI-Assisted Development Approach

**Development Tool:** Claude Code

**Key Benefits:**
- Rapid component generation with consistent patterns
- Parallel development of independent modules
- Automated boilerplate and repetitive code
- Quick iteration on complex features
- Built-in best practices enforcement

**Timeline Compression:**
| Traditional | AI-Assisted | Reduction |
|-------------|-------------|-----------|
| 6-10 weeks | 12-18 days | ~70% |

### Design System
Follow `apple-design-principles-2025.md` for:
- Liquid Glass integration (iOS 26+)
- Navigation patterns (Tab bars, NavigationSplitView)
- Typography hierarchy (SF Pro)
- Spacing system (8pt grid)
- Color system (system dynamic colors)

---

## Core Features

### 1. Browse & Search

#### Symbol Grid
- Display all 6,900+ SF Symbols in responsive grid
- **iPhone:** 3-5 columns (adaptive 64-80pt)
- **iPad:** 6-10 columns (adaptive 72-96pt)
- LazyVGrid for 60fps scrolling performance
- Tap → Detail view
- Long press → Quick copy name

#### Text Search
- Real-time filtering via `.searchable()` modifier
- Case-insensitive substring matching
- Result count display
- Clear button to reset

#### Semantic Search (Product Stage)
- Keyword-based intent matching
- "upload" → arrow.up, square.and.arrow.up, etc.
- "love" → heart, heart.fill, heart.circle, etc.
- JSON-based keyword database

#### Category Filtering
- 15 categories: Communication, Weather, Objects & Tools, Transportation, Nature, Human & Body, Gaming, Health & Fitness, Commerce, Text & Media, Editing, Math & Science, Shapes, Arrows, All Symbols
- Sheet presentation on iPhone
- Sidebar section on iPad

#### iOS Version Compatibility
- Filter symbols by target iOS version
- Compatibility badges on symbol details
- Configurable in Settings

---

### 2. Customize

#### Weight Selection
- 9 font weights: Ultralight, Thin, Light, Regular, Medium, Semibold, Bold, Heavy, Black
- Horizontal selector with visual indication
- Live preview updates

#### Color Picker (Product Stage)
- System colors palette (13 colors)
- Custom color via ColorPicker
- HEX code display
- Live preview with selected color

#### Rendering Modes (Product Stage)
- **Monochrome:** Single color
- **Hierarchical:** Opacity variation for depth
- **Palette:** Multiple explicit colors
- **Multicolor:** Full color (where available)
- Segmented picker UI

#### Live Preview
- Large symbol display (128pt iPhone, 160pt iPad)
- Updates immediately with customization changes
- Shows actual export appearance

---

### 3. Export

#### PNG Export
- Scales: @1x (64px), @2x (128px), @3x (192px)
- MVP: Single @2x export
- Product: Multi-select scales
- Transparent background
- Current customizations applied

#### SVG Export (Product Stage)
- Vector format for designers
- Preserves styling
- Single file output

#### Batch Export (Product Stage)
- Multi-select symbols in grid
- Export entire collections
- ZIP archive for multiple files
- Progress indicator
- Memory-efficient (batches of 10 with autoreleasepool)

#### Export Destination
- Save to Files app (not Photos)
- File naming: `symbol-name@{scale}x.{format}`
- Success confirmation with haptic feedback

---

### 4. Code Generation (Product Stage)

#### SwiftUI Output
```swift
Image(systemName: "heart.fill")
    .symbolRenderingMode(.hierarchical)
    .foregroundStyle(.red)
    .font(.system(size: 32, weight: .regular))
```

#### UIKit Output
```swift
let config = UIImage.SymbolConfiguration(
    pointSize: 32,
    weight: .regular
)
let image = UIImage(
    systemName: "heart.fill",
    withConfiguration: config
)?
    .withTintColor(.systemRed)
    .applyingSymbolConfiguration(
        .preferringHierarchical()
    )
```

#### Features
- Framework picker (SwiftUI/UIKit)
- Copy to clipboard
- Share via system sheet
- All customizations included

---

### 5. Organization (Product Stage)

#### Favorites System
- Star toggle on detail view
- Dedicated Favorites tab
- Auto-grouping by recency
- Persistent storage (UserDefaults)

#### Collections
- User-created groups
- Add symbols via drag or action
- Rename and delete collections
- Export entire collection

---

### 6. Settings (Product Stage)

#### Export Defaults
- Default format (PNG/SVG)
- Default scales (@1x/@2x/@3x)
- Default weight

#### Compatibility
- Target iOS version selector
- Show/hide compatibility badges

#### Appearance
- Grid columns (Auto, 3-6)
- Symbol size (Small, Medium, Large)

#### About
- App version
- SF Symbols version
- Feedback link
- App Store rating link

---

## Navigation Structure

### iPhone
```
TabView (3 tabs)
├── Search Tab
│   └── NavigationStack
│       ├── SymbolGridView (root)
│       └── SymbolDetailView (push)
├── Favorites Tab
│   └── NavigationStack
│       ├── FavoritesView (root)
│       └── CollectionDetailView (push)
└── Settings Tab
    └── NavigationStack
        └── SettingsView (root)
```

### iPad
```
NavigationSplitView
├── Sidebar
│   ├── Search
│   ├── Favorites
│   ├── Collections (expandable)
│   └── Settings
└── Detail
    ├── SymbolGridView
    ├── SymbolDetailView
    ├── CollectionDetailView
    └── SettingsView
```

---

## Data Architecture

### SFSafeSymbols Integration
- **Package:** https://github.com/SFSafeSymbols/SFSafeSymbols
- **Version:** 7.0.0+
- **Purpose:** Type-safe symbol access, compile-time checking, availability annotations

**Usage:**
```swift
// Type-safe (preferred)
Image(systemSymbol: .heartFill)

// Instead of unsafe strings
Image(systemName: "heart.fill")  // Avoid
```

### Data Models
```swift
// Core symbol representation
struct SymbolItem: Identifiable, Hashable {
    let id: String
    let symbol: SFSymbol
    var category: SymbolCategory
}

// User collection
struct SymbolCollection: Identifiable, Codable {
    let id: UUID
    var name: String
    var symbolNames: [String]
    var createdAt: Date
}

// Export configuration
struct ExportConfiguration {
    var format: ExportFormat
    var scales: Set<ExportScale>
    var weight: Font.Weight
    var color: Color
    var renderingMode: SymbolRenderingMode
}

// App settings
struct AppSettings: Codable {
    var defaultExportFormat: ExportFormat
    var defaultScales: Set<ExportScale>
    var targetIOSVersion: Double
    var showCompatibilityBadge: Bool
    var gridColumns: Int
    var symbolSize: SymbolSize
}
```

### Symbol Metadata
- **Names:** From SFSafeSymbols enum
- **Categories:** Manual categorization (15 groups)
- **Keywords:** JSON mapping file for semantic search
- **iOS Compatibility:** From SFSafeSymbols @available attributes

---

## Performance Requirements

### Rendering
- 60fps scrolling with 6,900+ symbols
- LazyVGrid for virtualized rendering
- NSCache for rendered symbol images

### Search
- Real-time filtering (<100ms)
- Optional debounce (300ms) for complex queries
- In-memory symbol list for instant access

### Export
- Background thread rendering
- Batch processing (groups of 10)
- autoreleasepool for memory management
- Progress indication for large exports

### Memory
- Efficient image caching
- Lazy loading of symbol metadata
- Collection cleanup on low memory

---

## Accessibility Requirements

### VoiceOver
- All symbols have accessibility labels
- Custom actions for export/copy
- Meaningful hints for interactions

### Dynamic Type
- Support all text sizes including accessibility sizes
- Minimum touch targets (44x44pt)

### Keyboard Navigation (iPad)
- Full keyboard support
- Cmd+F for search focus
- Arrow keys for grid navigation
- Enter for selection

### Color Contrast
- Meet WCAG 2.1 AA standards
- Test in Light and Dark modes
- Test with Increased Contrast setting

---

## Quality Requirements

### Testing
- 80% code coverage minimum
- Unit tests for ViewModels and Services
- UI tests for critical flows
- Performance tests for scrolling and export

### Code Quality
- No force unwrapping (!)
- Result<T, E> for error handling
- Guard for early returns
- Structs over classes where possible
- @Observable for ViewModels (iOS 17+)

### SwiftUI Best Practices
- NavigationStack (not NavigationView)
- .searchable() for search
- LazyVGrid for performance
- Environment objects for shared state

---

## Non-Goals

The following are explicitly out of scope:
- Custom symbol creation or editing
- Animation preview/export
- Cloud sync (local storage only)
- In-app purchases (free app)
- macOS version (iOS/iPadOS only)
- watchOS/tvOS versions

---

## Phased Delivery

### MVP (Phase 1-2)
**Duration:** 3-5 days with AI assistance

**Deliverables:**
- Symbol grid with 6,900+ symbols
- Text search
- Category filter
- Symbol detail view
- Weight selector
- Copy symbol name
- Export single PNG (@2x)
- Dark mode support
- iPhone + iPad layouts

**Success Criteria:**
- Find any symbol in <10 seconds
- Export produces usable PNG
- 60fps scrolling
- No crashes

### Product (Phase 3-6)
**Duration:** 7-13 days with AI assistance

**Deliverables:**
- Tab bar navigation (iPhone)
- NavigationSplitView (iPad)
- Color picker
- Rendering mode picker
- Multi-scale export (@1x/@2x/@3x)
- SVG export
- Code generation (SwiftUI/UIKit)
- Semantic search
- Favorites system
- Collections
- Batch export
- iOS compatibility badges
- Settings screen
- Liquid Glass integration

**Success Criteria:**
- Production-ready multi-scale exports
- Valid code generation
- Semantic search finds relevant symbols
- Collections organize workflow
- Batch export handles 100+ symbols
- 80% test coverage

---

## Technical References

### Project Documentation
- Design patterns: `apple-design-principles-2025.md`
- Build plan: `BUILD-PLAN-AI-ASSISTED.md`
- MVP flow: `mvp-user-flow.md`
- Product flow: `product-user-flow.md`
- Design summary: `design-summary-complete.md`
- Development rules: `CLAUDE-LEAN.md`

### External Resources
- SFSafeSymbols: https://github.com/SFSafeSymbols/SFSafeSymbols
- SF Symbols 7: 6,900+ symbols
- Apple HIG: https://developer.apple.com/design/human-interface-guidelines/
- WWDC 2025: "Meet Liquid Glass", "Get to know the new design system"

---

## AI-Assisted Development Notes

### Optimal AI Task Sizing
- One complete component per prompt
- Include context from CLAUDE-LEAN.md
- Verify output before proceeding
- Iterate with error messages

### Parallel Development Opportunities
- Data Models + Repository (independent)
- Cell View + Weight Selector (UI components)
- Color Picker + Rendering Picker (customization)
- Code Generation + Export Service (output features)

### Quality Gates
Before each phase completion:
- [ ] All views render without crashes
- [ ] Navigation works correctly
- [ ] Data persists across launches
- [ ] Dark mode works throughout
- [ ] iPad layouts functional
- [ ] No force unwrapping
- [ ] Tests pass

---

*This PRD is optimized for AI-assisted development. Each requirement is specific enough for AI code generation while maintaining flexibility for implementation details.*
