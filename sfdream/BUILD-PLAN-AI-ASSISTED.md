# SF Symbols Browser - AI-Assisted Build Plan
**Version:** 1.1
**Target:** iOS 17.0+ (iOS 26.0+ for Liquid Glass features)
**Approach:** AI-Assisted Development with Claude Code
**Last Updated:** November 2025

---

## Implementation Status

| Phase | Status | Completed |
|-------|--------|-----------|
| Phase 0 - Setup | COMPLETE | Project structure, Package.swift, SFSafeSymbols |
| Phase 1 - MVP Core | COMPLETE | All models, views, ViewModels, services |
| Phase 2 - MVP Polish | COMPLETE | Category filter, iPad layouts, tests, error handling |
| Phase 3 - Product Foundation | COMPLETE | Tab navigation, iPad sidebar, collections, settings |
| **Premium UI** | COMPLETE | Apple Design Award-worthy alternative UI with advanced animations |
| **Phase 4** | COMPLETE | Code generation, multi-scale export, color/rendering, semantic search |
| Phase 5-6 | PENDING | Batch export, SVG, polish |

### Phase 4 Components (Product Features)
- **CodeGenerationService.swift** - SwiftUI/UIKit code generation
- **CodeGenerationView.swift** - Framework picker, syntax display, copy
- **ExportOptionsSheet.swift** - Multi-scale PNG export (@1x/@2x/@3x)
- **SymbolColorPicker.swift** - 13 system colors + custom ColorPicker
- **RenderingModePicker.swift** - Mono/Hierarchical/Palette/Multicolor
- **KeywordRepository.swift** - Semantic search with 100+ keyword mappings
- **CompatibilityBadge.swift** - iOS version requirements display

### Premium UI Components (Toggleable via Settings)
- **DesignSystem.swift** - Animation presets, spacing, colors, HapticManager
- **PremiumSymbolCellView.swift** - PhaseAnimator micro-interactions
- **PremiumSymbolGridView.swift** - Animated mesh gradient backgrounds
- **PremiumSymbolDetailView.swift** - KeyframeAnimator symbol animations
- **PremiumMainTabView.swift** - Enhanced tab navigation with haptics
- **PremiumiPadSidebarView.swift** - Premium sidebar with gradients
- Glass morphism effects, breathing animations, shimmer loading

---

## Executive Summary

This build plan synthesizes requirements from all project documentation to create a coherent, phased development approach optimized for AI-assisted coding. The app enables browsing, customizing, and exporting 6,900+ SF Symbols with code generation capabilities.

**Key Acceleration Factor:** AI-assisted development allows parallel implementation of independent components and rapid iteration on complex features. Timeline estimates are compressed accordingly.

---

## Phase Overview

| Phase | Focus | Duration (AI-Assisted) | Key Deliverables | Status |
|-------|-------|------------------------|------------------|--------|
| **0 - Setup** | Project foundation | 1-2 hours | Xcode project, SFSafeSymbols, architecture | DONE |
| **1 - MVP Core** | Browse & basic export | 2-3 days | Symbol grid, search, detail view, PNG export | DONE |
| **2 - MVP Polish** | Complete MVP | 1-2 days | Categories, weights, copy name, iPad layouts | DONE |
| **3 - Product Foundation** | Tab navigation & data | 2-3 days | Tab bar, favorites, persistence | DONE |
| **4 - Product Features** | Advanced features | 3-4 days | Multi-scale export, code gen, semantic search | DONE |
| **5 - Product Complete** | Collections & batch | 2-3 days | Collections, batch export, SVG, settings | PENDING |
| **6 - Polish** | Final refinements | 1-2 days | Liquid Glass, animations, testing | PENDING |

**Total Estimated Time:** 12-18 days (vs 6-10 weeks traditional)

---

## Phase 0: Project Setup (1-2 hours)

### 0.1 Create Xcode Project
```
- New iOS App project
- Product Name: SFSymbolsBrowser
- Interface: SwiftUI
- Language: Swift
- Minimum Deployment: iOS 17.0
```

### 0.2 Add SFSafeSymbols Dependency
```swift
// Package.swift or Xcode SPM
.package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git",
         .upToNextMajor(from: "7.0.0"))
```

### 0.3 Project Structure
```
SFSymbolsBrowser/
├── App/
│   └── SFSymbolsBrowserApp.swift
├── Models/
│   ├── SymbolItem.swift
│   ├── SymbolCategory.swift
│   └── ExportConfiguration.swift
├── ViewModels/
│   ├── SymbolGridViewModel.swift
│   ├── SymbolDetailViewModel.swift
│   ├── FavoritesViewModel.swift
│   └── SettingsViewModel.swift
├── Views/
│   ├── Grid/
│   │   ├── SymbolGridView.swift
│   │   └── SymbolCellView.swift
│   ├── Detail/
│   │   ├── SymbolDetailView.swift
│   │   ├── WeightSelectorView.swift
│   │   ├── ColorPickerView.swift
│   │   └── RenderingModePicker.swift
│   ├── Export/
│   │   ├── ExportOptionsSheet.swift
│   │   └── CodeGenerationView.swift
│   ├── Favorites/
│   │   ├── FavoritesView.swift
│   │   └── CollectionsView.swift
│   └── Settings/
│       └── SettingsView.swift
├── Services/
│   ├── SymbolRenderingService.swift
│   ├── ExportService.swift
│   ├── CodeGenerationService.swift
│   └── PersistenceService.swift
├── Repositories/
│   ├── SymbolRepository.swift
│   └── KeywordRepository.swift
└── Resources/
    └── semantic-keywords.json
```

### 0.4 Base Configuration Files
- Create `CLAUDE-LEAN.md` reference in project
- Set up SwiftLint (optional)
- Configure build settings for iOS 17+

**AI Task:** "Create Xcode project structure with all folders and placeholder files following MVVM architecture for SF Symbols browser app"

---

## Phase 1: MVP Core (2-3 days)

### 1.1 Data Models (2-4 hours)

**SymbolItem.swift:**
```swift
import SFSafeSymbols

struct SymbolItem: Identifiable, Hashable {
    let id: String  // symbol name
    let symbol: SFSymbol
    var weight: Font.Weight = .regular

    var name: String { symbol.rawValue }
}
```

**SymbolCategory.swift:**
```swift
enum SymbolCategory: String, CaseIterable, Identifiable {
    case all = "All Symbols"
    case communication = "Communication"
    case weather = "Weather"
    case objectsTools = "Objects & Tools"
    case transportation = "Transportation"
    case nature = "Nature"
    case human = "Human & Body"
    case gaming = "Gaming"
    case health = "Health & Fitness"
    case commerce = "Commerce"
    case textMedia = "Text & Media"
    case editing = "Editing"
    case math = "Math & Science"
    case shapes = "Shapes"
    case arrows = "Arrows"

    var id: String { rawValue }
}
```

**AI Task:** "Create data models for SymbolItem wrapping SFSafeSymbols, SymbolCategory enum with 15 categories, and basic ExportConfiguration struct"

### 1.2 Symbol Repository (2-4 hours)

**SymbolRepository.swift:**
```swift
@Observable
final class SymbolRepository {
    private(set) var allSymbols: [SymbolItem] = []

    init() {
        loadSymbols()
    }

    private func loadSymbols() {
        // Generate from SFSafeSymbols enum
        // Map to SymbolItem with category assignment
    }

    func symbols(matching query: String,
                 category: SymbolCategory?) -> [SymbolItem] {
        // Filter logic
    }
}
```

**AI Task:** "Implement SymbolRepository that loads all SFSafeSymbols into SymbolItem array with category mapping and search filtering"

### 1.3 Symbol Grid View (3-5 hours)

**Layout Specifications:**
- iPhone: 3-5 columns (adaptive 64-80pt minimum)
- iPad: 6-10 columns (adaptive 72-96pt minimum)
- LazyVGrid for performance with 6,900+ symbols
- Tap → Detail view, Long press → Copy name

**SymbolGridView.swift:**
```swift
struct SymbolGridView: View {
    @State private var viewModel = SymbolGridViewModel()

    private let columns = [
        GridItem(.adaptive(minimum: 64, maximum: 80), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.filteredSymbols) { symbol in
                        NavigationLink(value: symbol) {
                            SymbolCellView(symbol: symbol)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("SF Symbols")
            .searchable(text: $viewModel.searchText)
            .navigationDestination(for: SymbolItem.self) { symbol in
                SymbolDetailView(symbol: symbol)
            }
        }
    }
}
```

**AI Task:** "Create SymbolGridView with LazyVGrid, .searchable modifier, NavigationStack, and adaptive columns for iPhone/iPad"

### 1.4 Symbol Cell View (1-2 hours)

**SymbolCellView.swift:**
```swift
struct SymbolCellView: View {
    let symbol: SymbolItem

    var body: some View {
        VStack {
            Image(systemSymbol: symbol.symbol)
                .font(.system(size: 32))
                .foregroundStyle(.primary)
        }
        .frame(width: 64, height: 64)
        .accessibilityLabel(symbol.name)
    }
}
```

**AI Task:** "Create SymbolCellView displaying SF Symbol with proper sizing, accessibility, and long-press gesture for copy"

### 1.5 Symbol Detail View (4-6 hours)

**Components:**
- Large symbol preview (128pt)
- Symbol name (monospace)
- Weight selector (9 weights)
- Export PNG button
- Copy name button

**SymbolDetailView.swift structure:**
```swift
struct SymbolDetailView: View {
    let symbol: SymbolItem
    @State private var selectedWeight: Font.Weight = .regular

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Large preview
                SymbolPreviewView(symbol: symbol, weight: selectedWeight)

                // Symbol name
                Text(symbol.name)
                    .font(.title3.monospaced())

                // Weight selector
                WeightSelectorView(selectedWeight: $selectedWeight)

                // Actions
                VStack(spacing: 12) {
                    ExportButton(symbol: symbol, weight: selectedWeight)
                    CopyNameButton(name: symbol.name)
                }
            }
            .padding()
        }
        .navigationTitle("Symbol")
        .navigationBarTitleDisplayMode(.inline)
    }
}
```

**AI Task:** "Create SymbolDetailView with large preview, monospace name, weight selector, export button, and copy name functionality"

### 1.6 Weight Selector (2-3 hours)

**WeightSelectorView.swift:**
```swift
struct WeightSelectorView: View {
    @Binding var selectedWeight: Font.Weight

    private let weights: [(Font.Weight, String)] = [
        (.ultraLight, "UL"),
        (.thin, "Th"),
        (.light, "Lt"),
        (.regular, "Rg"),
        (.medium, "Md"),
        (.semibold, "Sm"),
        (.bold, "Bd"),
        (.heavy, "Hv"),
        (.black, "Bl")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weight")
                .font(.headline)

            HStack(spacing: 8) {
                ForEach(weights, id: \.0) { weight, label in
                    WeightButton(
                        label: label,
                        isSelected: selectedWeight == weight,
                        action: { selectedWeight = weight }
                    )
                }
            }
        }
    }
}
```

**AI Task:** "Create WeightSelectorView with horizontal row of 9 weight options, radio-style selection, and abbreviated labels"

### 1.7 Basic Export Service (3-4 hours)

**ExportService.swift:**
```swift
actor ExportService {
    func exportPNG(
        symbol: SFSymbol,
        weight: Font.Weight,
        scale: CGFloat = 2.0,
        size: CGFloat = 64
    ) async throws -> URL {
        // Render symbol to UIImage
        // Convert to PNG data
        // Save to Files app via FileManager
        // Return file URL
    }
}
```

**AI Task:** "Create ExportService that renders SF Symbol to PNG with configurable weight and scale, saves to Files app using UIGraphicsImageRenderer"

### 1.8 Grid ViewModel (2-3 hours)

**SymbolGridViewModel.swift:**
```swift
@Observable
final class SymbolGridViewModel {
    var searchText: String = ""
    var selectedCategory: SymbolCategory? = nil

    private let repository = SymbolRepository()

    var filteredSymbols: [SymbolItem] {
        repository.symbols(matching: searchText, category: selectedCategory)
    }

    var symbolCount: Int {
        filteredSymbols.count
    }
}
```

**AI Task:** "Create SymbolGridViewModel with @Observable, search text binding, category filter, and computed filtered symbols array"

---

## Phase 2: MVP Polish (1-2 days)

### 2.1 Category Filter Sheet (2-3 hours)

**CategoryFilterView.swift:**
```swift
struct CategoryFilterView: View {
    @Binding var selectedCategory: SymbolCategory?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(SymbolCategory.allCases) { category in
                Button {
                    selectedCategory = category == .all ? nil : category
                    dismiss()
                } label: {
                    HStack {
                        Text(category.rawValue)
                        Spacer()
                        if isSelected(category) {
                            Image(systemSymbol: .checkmark)
                        }
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
```

**AI Task:** "Create CategoryFilterView sheet with list of 15 categories, checkmark selection indicator, and dismiss on selection"

### 2.2 Copy to Clipboard (1 hour)

**Implement throughout app:**
```swift
func copyToClipboard(_ text: String) {
    UIPasteboard.general.string = text
    // Trigger haptic feedback
    // Show toast notification
}
```

**AI Task:** "Add copy to clipboard functionality with haptic feedback and brief toast confirmation throughout the app"

### 2.3 iPad Layout Adaptation (3-4 hours)

**Responsive adjustments:**
- Larger grid cells (72-96pt)
- More columns (6-10)
- Larger detail preview (160pt)
- Full weight labels instead of abbreviated
- Side-by-side action buttons

**AI Task:** "Adapt all views for iPad with larger sizes, more columns, full labels, and horizontal layouts where appropriate using ViewThatFits or environment checks"

### 2.4 Dark Mode Support (1-2 hours)

**Ensure all views use:**
- `.systemBackground`
- `.label` / `.secondaryLabel`
- `.tintColor`
- System colors for all UI elements

**AI Task:** "Audit and fix all views to properly support dark mode using system colors and dynamic backgrounds"

### 2.5 Error Handling (2-3 hours)

**Result<T, E> pattern throughout:**
```swift
enum ExportError: LocalizedError {
    case renderingFailed
    case saveFailed
    case permissionDenied

    var errorDescription: String? {
        switch self {
        case .renderingFailed: return "Failed to render symbol"
        case .saveFailed: return "Failed to save file"
        case .permissionDenied: return "Permission denied"
        }
    }
}
```

**AI Task:** "Add comprehensive error handling with Result types, user-friendly error messages, and alert presentation"

### 2.6 MVP Testing (2-3 hours)

**Test coverage targets:**
- SymbolRepository: Search filtering, category filtering
- ExportService: PNG rendering, file saving
- ViewModels: State management, computed properties

**AI Task:** "Create XCTest unit tests for SymbolRepository, ExportService, and all ViewModels with 80% coverage target"

---

## Phase 3: Product Foundation (2-3 days)

### 3.1 Tab Bar Navigation (3-4 hours)

**MainTabView.swift:**
```swift
struct MainTabView: View {
    @State private var selectedTab: Tab = .search

    enum Tab {
        case search, favorites, settings
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                SymbolGridView()
            }
            .tabItem {
                Label("Search", systemSymbol: .magnifyingglass)
            }
            .tag(Tab.search)

            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label("Favorites", systemSymbol: .star)
            }
            .tag(Tab.favorites)

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemSymbol: .gear)
            }
            .tag(Tab.settings)
        }
    }
}
```

**AI Task:** "Create MainTabView with 3 tabs (Search, Favorites, Settings) using TabView, each wrapping NavigationStack"

### 3.2 iPad NavigationSplitView (4-5 hours)

**iPadMainView.swift:**
```swift
struct iPadMainView: View {
    @State private var selectedSection: SidebarSection? = .search
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    enum SidebarSection: Hashable {
        case search, favorites, collections(Collection), settings
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // Sidebar
            List(selection: $selectedSection) {
                Section {
                    Label("Search", systemSymbol: .magnifyingglass)
                        .tag(SidebarSection.search)
                    Label("Favorites", systemSymbol: .star)
                        .tag(SidebarSection.favorites)
                }

                Section("Collections") {
                    // Dynamic collection list
                }

                Section {
                    Label("Settings", systemSymbol: .gear)
                        .tag(SidebarSection.settings)
                }
            }
            .navigationTitle("SF Symbols")
        } detail: {
            // Detail content based on selection
        }
    }
}
```

**AI Task:** "Create iPadMainView with NavigationSplitView, sidebar sections for Search/Favorites/Collections/Settings, and detail area"

### 3.3 Persistence Service (3-4 hours)

**PersistenceService.swift:**
```swift
@Observable
final class PersistenceService {
    private let defaults = UserDefaults.standard

    var favoriteSymbolNames: Set<String> {
        didSet { saveFavorites() }
    }

    var collections: [SymbolCollection] {
        didSet { saveCollections() }
    }

    var settings: AppSettings {
        didSet { saveSettings() }
    }

    init() {
        favoriteSymbolNames = loadFavorites()
        collections = loadCollections()
        settings = loadSettings()
    }

    // MARK: - Favorites
    func toggleFavorite(_ symbol: SymbolItem) { /* ... */ }
    func isFavorite(_ symbol: SymbolItem) -> Bool { /* ... */ }

    // MARK: - Collections
    func createCollection(name: String) -> SymbolCollection { /* ... */ }
    func addToCollection(_ symbol: SymbolItem, collection: SymbolCollection) { /* ... */ }
}
```

**AI Task:** "Create PersistenceService with UserDefaults storage for favorites (Set<String>), collections, and app settings with automatic save/load"

### 3.4 Favorites View (3-4 hours)

**FavoritesView.swift:**
```swift
struct FavoritesView: View {
    @Environment(PersistenceService.self) private var persistence
    @State private var selectedSymbols: Set<String> = []
    @State private var isSelectionMode = false

    var body: some View {
        List {
            if persistence.favoriteSymbolNames.isEmpty {
                EmptyFavoritesView()
            } else {
                Section("Favorites") {
                    // Grid or list of favorited symbols
                }

                Section("Collections") {
                    ForEach(persistence.collections) { collection in
                        CollectionRow(collection: collection)
                    }

                    Button("New Collection") {
                        // Create collection
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button("Select Multiple") { isSelectionMode.toggle() }
                    Button("Export All") { /* ... */ }
                } label: {
                    Image(systemSymbol: .ellipsisCircle)
                }
            }
        }
    }
}
```

**AI Task:** "Create FavoritesView with favorited symbols grid, collections list, empty state, and batch action menu"

### 3.5 Favorite Toggle Integration (2 hours)

**Add to SymbolDetailView:**
```swift
.toolbar {
    ToolbarItem(placement: .primaryAction) {
        Button {
            persistence.toggleFavorite(symbol)
        } label: {
            Image(systemSymbol: persistence.isFavorite(symbol) ? .starFill : .star)
        }
    }
}
```

**AI Task:** "Integrate favorite toggle button into SymbolDetailView toolbar with filled/unfilled star icon and haptic feedback"

---

## Phase 4: Product Features (3-4 days)

### 4.1 Color Picker (3-4 hours)

**ColorPickerView.swift:**
```swift
struct SymbolColorPicker: View {
    @Binding var selectedColor: Color

    private let systemColors: [Color] = [
        .primary, .red, .orange, .yellow, .green,
        .mint, .teal, .cyan, .blue, .indigo,
        .purple, .pink, .brown
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Color")
                .font(.headline)

            // System colors grid
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 44))], spacing: 8) {
                ForEach(systemColors, id: \.self) { color in
                    ColorButton(color: color, isSelected: selectedColor == color) {
                        selectedColor = color
                    }
                }
            }

            // Custom color picker
            ColorPicker("Custom", selection: $selectedColor)
        }
    }
}
```

**AI Task:** "Create SymbolColorPicker with system colors grid and custom ColorPicker, integrate into SymbolDetailView"

### 4.2 Rendering Mode Picker (2-3 hours)

**RenderingModePicker.swift:**
```swift
struct RenderingModePicker: View {
    @Binding var selectedMode: SymbolRenderingMode

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rendering Mode")
                .font(.headline)

            Picker("Mode", selection: $selectedMode) {
                Text("Monochrome").tag(SymbolRenderingMode.monochrome)
                Text("Hierarchical").tag(SymbolRenderingMode.hierarchical)
                Text("Palette").tag(SymbolRenderingMode.palette)
                Text("Multicolor").tag(SymbolRenderingMode.multicolor)
            }
            .pickerStyle(.segmented)
        }
    }
}
```

**AI Task:** "Create RenderingModePicker with segmented control for 4 rendering modes, integrate into SymbolDetailView with live preview"

### 4.3 Multi-Scale Export (4-5 hours)

**Enhanced ExportOptionsSheet.swift:**
```swift
struct ExportOptionsSheet: View {
    let symbol: SymbolItem
    let configuration: SymbolConfiguration

    @State private var selectedFormat: ExportFormat = .png
    @State private var selectedScales: Set<ExportScale> = [.x2]

    enum ExportFormat: String, CaseIterable {
        case png = "PNG"
        case svg = "SVG"
    }

    enum ExportScale: Int, CaseIterable {
        case x1 = 1, x2 = 2, x3 = 3

        var label: String { "@\(rawValue)x" }
        var pixelSize: Int { 64 * rawValue }
    }

    var body: some View {
        NavigationStack {
            Form {
                // Format section
                Section("Format") {
                    Picker("Format", selection: $selectedFormat) {
                        ForEach(ExportFormat.allCases, id: \.self) { format in
                            Text(format.rawValue).tag(format)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Scales section (PNG only)
                if selectedFormat == .png {
                    Section("Scales") {
                        ForEach(ExportScale.allCases, id: \.self) { scale in
                            Toggle(scale.label, isOn: scaleBinding(for: scale))
                        }
                    }
                }

                // Preview section
                Section("Preview") {
                    ExportPreviewView(symbol: symbol, scales: selectedScales)
                }

                // Export button
                Section {
                    Button("Export \(exportCount) File\(exportCount == 1 ? "" : "s")") {
                        performExport()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Export Options")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
```

**AI Task:** "Create ExportOptionsSheet with format picker (PNG/SVG), multi-select scale toggles, preview, and export action"

### 4.4 Code Generation Service (4-5 hours)

**CodeGenerationService.swift:**
```swift
struct CodeGenerationService {
    enum Framework {
        case swiftUI, uiKit
    }

    func generateCode(
        symbol: SFSymbol,
        weight: Font.Weight,
        color: Color,
        renderingMode: SymbolRenderingMode,
        framework: Framework
    ) -> String {
        switch framework {
        case .swiftUI:
            return generateSwiftUICode(symbol: symbol, weight: weight,
                                       color: color, renderingMode: renderingMode)
        case .uiKit:
            return generateUIKitCode(symbol: symbol, weight: weight,
                                     color: color, renderingMode: renderingMode)
        }
    }

    private func generateSwiftUICode(/* ... */) -> String {
        """
        Image(systemName: "\(symbol.rawValue)")
            .symbolRenderingMode(.\(renderingMode))
            .foregroundStyle(\(colorCode))
            .font(.system(size: 32, weight: .\(weightName)))
        """
    }

    private func generateUIKitCode(/* ... */) -> String {
        // UIKit equivalent code
    }
}
```

**AI Task:** "Create CodeGenerationService that generates properly formatted SwiftUI and UIKit code for symbol with all customizations"

### 4.5 Code Generation View (3-4 hours)

**CodeGenerationView.swift:**
```swift
struct CodeGenerationView: View {
    let symbol: SymbolItem
    let configuration: SymbolConfiguration

    @State private var selectedFramework: CodeGenerationService.Framework = .swiftUI

    private var generatedCode: String {
        CodeGenerationService().generateCode(
            symbol: symbol.symbol,
            weight: configuration.weight,
            color: configuration.color,
            renderingMode: configuration.renderingMode,
            framework: selectedFramework
        )
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Framework picker
                Picker("Framework", selection: $selectedFramework) {
                    Text("SwiftUI").tag(CodeGenerationService.Framework.swiftUI)
                    Text("UIKit").tag(CodeGenerationService.Framework.uiKit)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Code display
                ScrollView {
                    Text(generatedCode)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)

                // Copy button
                Button {
                    UIPasteboard.general.string = generatedCode
                } label: {
                    Label("Copy Code", systemSymbol: .docOnDoc)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Generate Code")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
```

**AI Task:** "Create CodeGenerationView with framework picker, syntax-highlighted code display, and copy to clipboard functionality"

### 4.6 Semantic Search (4-5 hours)

**KeywordRepository.swift:**
```swift
@Observable
final class KeywordRepository {
    private var keywordMap: [String: Set<String>] = [:]

    init() {
        loadKeywords()
    }

    private func loadKeywords() {
        // Load from semantic-keywords.json
        // Map: keyword -> [symbol names]
        // Example: "upload" -> ["arrow.up", "square.and.arrow.up", "icloud.and.arrow.up"]
    }

    func symbols(forKeyword keyword: String) -> Set<String> {
        let lowercased = keyword.lowercased()
        var results: Set<String> = []

        for (key, symbols) in keywordMap {
            if key.contains(lowercased) {
                results.formUnion(symbols)
            }
        }

        return results
    }
}
```

**semantic-keywords.json structure:**
```json
{
  "upload": ["arrow.up", "square.and.arrow.up", "icloud.and.arrow.up"],
  "download": ["arrow.down", "square.and.arrow.down", "icloud.and.arrow.down"],
  "love": ["heart", "heart.fill", "heart.circle"],
  "warning": ["exclamationmark.triangle", "exclamationmark.circle"],
  "settings": ["gear", "gearshape", "slider.horizontal.3"]
}
```

**AI Task:** "Create KeywordRepository with JSON-based keyword-to-symbols mapping for semantic search, integrate with SymbolRepository"

### 4.7 iOS Compatibility Badges (2-3 hours)

**CompatibilityBadge.swift:**
```swift
struct CompatibilityBadge: View {
    let symbol: SFSymbol
    let targetVersion: Double  // From settings

    private var minimumVersion: Double {
        // Derive from SFSafeSymbols @available attributes
        // or embedded metadata
    }

    private var isCompatible: Bool {
        minimumVersion <= targetVersion
    }

    var body: some View {
        HStack(spacing: 4) {
            if isCompatible {
                Image(systemSymbol: .checkmarkCircleFill)
                    .foregroundStyle(.green)
            } else {
                Image(systemSymbol: .exclamationmarkTriangleFill)
                    .foregroundStyle(.orange)
            }
            Text("iOS \(String(format: "%.1f", minimumVersion))+")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
```

**AI Task:** "Create CompatibilityBadge view showing iOS version requirement with checkmark/warning icons based on user's target version"

---

## Phase 5: Product Complete (2-3 days)

### 5.1 Collections Management (4-5 hours)

**SymbolCollection.swift:**
```swift
struct SymbolCollection: Identifiable, Codable {
    let id: UUID
    var name: String
    var symbolNames: [String]
    var createdAt: Date

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.symbolNames = []
        self.createdAt = Date()
    }
}
```

**CollectionDetailView.swift:**
```swift
struct CollectionDetailView: View {
    @Bindable var collection: SymbolCollection
    @Environment(PersistenceService.self) private var persistence

    var body: some View {
        // Grid of symbols in collection
        // Export all button
        // Edit/delete collection
    }
}
```

**AI Task:** "Create Collections data model, CollectionDetailView, and management UI (create, rename, delete, add/remove symbols)"

### 5.2 Batch Export (4-5 hours)

**BatchExportService.swift:**
```swift
actor BatchExportService {
    func exportMultiple(
        symbols: [SymbolItem],
        configuration: ExportConfiguration,
        progressHandler: @escaping (Double) -> Void
    ) async throws -> URL {
        // Export in batches of 10 with autoreleasepool
        // Show progress
        // Create ZIP archive if multiple files
        // Return final URL
    }
}
```

**BatchSelectionView.swift:**
```swift
// Multi-select mode in grid
// Floating toolbar with selection count
// Export selected button
```

**AI Task:** "Create BatchExportService with progress tracking and ZIP creation, add multi-select mode to grid view with floating toolbar"

### 5.3 SVG Export (3-4 hours)

**SVGExportService.swift:**
```swift
struct SVGExportService {
    func exportSVG(
        symbol: SFSymbol,
        weight: Font.Weight,
        color: Color
    ) throws -> Data {
        // Convert symbol to SVG format
        // Use vector paths
        // Include metadata
    }
}
```

**AI Task:** "Create SVGExportService that exports SF Symbol as SVG vector format with proper path data and styling"

### 5.4 Settings View (3-4 hours)

**SettingsView.swift:**
```swift
struct SettingsView: View {
    @Environment(PersistenceService.self) private var persistence

    var body: some View {
        Form {
            Section("Export Defaults") {
                Picker("Format", selection: $persistence.settings.defaultExportFormat) {
                    Text("PNG").tag(ExportFormat.png)
                    Text("SVG").tag(ExportFormat.svg)
                }

                // Scale toggles
                // Default weight picker
            }

            Section("Compatibility") {
                Picker("Target iOS", selection: $persistence.settings.targetIOSVersion) {
                    ForEach(iOSVersions, id: \.self) { version in
                        Text("iOS \(version)").tag(version)
                    }
                }

                Toggle("Show Compatibility Badge", isOn: $persistence.settings.showCompatibilityBadge)
            }

            Section("Appearance") {
                Picker("Grid Columns", selection: $persistence.settings.gridColumns) {
                    Text("Auto").tag(0)
                    ForEach(3...6, id: \.self) { count in
                        Text("\(count)").tag(count)
                    }
                }

                Picker("Symbol Size", selection: $persistence.settings.symbolSize) {
                    Text("Small").tag(SymbolSize.small)
                    Text("Medium").tag(SymbolSize.medium)
                    Text("Large").tag(SymbolSize.large)
                }
            }

            Section("About") {
                LabeledContent("Version", value: "1.0")
                LabeledContent("SF Symbols", value: "7.0")

                Link("Send Feedback", destination: feedbackURL)
                Link("Rate App", destination: appStoreURL)
            }
        }
        .navigationTitle("Settings")
    }
}
```

**AI Task:** "Create SettingsView with Form layout, export defaults, compatibility filter, appearance options, and about section"

### 5.5 Enhanced Detail View (2-3 hours)

**Integrate all Product features into SymbolDetailView:**
- Color picker
- Rendering mode picker
- Compatibility badge
- Favorite toggle
- Export menu (multi-scale)
- Code generation button

**AI Task:** "Update SymbolDetailView to integrate color picker, rendering mode, compatibility badge, and enhanced export/code generation buttons"

---

## Phase 6: Polish (1-2 days)

### 6.1 Liquid Glass Integration (iOS 26+) (2-3 hours)

```swift
// Tab bar gets Liquid Glass automatically
// Navigation bar gets Liquid Glass automatically

// Custom glass effects for:
// - Batch selection toolbar
.glassEffect()

// - Export sheets
.presentationBackground(.ultraThinMaterial)

// - Custom floating controls
.background(.ultraThinMaterial)
```

**AI Task:** "Add Liquid Glass effects to custom UI elements (batch toolbar, sheets) using .glassEffect() and materials for iOS 26+"

### 6.2 Animations (2-3 hours)

**Add subtle animations:**
```swift
// Symbol tap
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.spring(response: 0.3), value: isPressed)

// Favorite toggle
.symbolEffect(.bounce, value: isFavorite)

// Export success
.symbolEffect(.pulse.byLayer, value: exportSuccess)
```

**AI Task:** "Add spring animations for taps, SF Symbol effects for state changes, and smooth transitions throughout the app"

### 6.3 Haptic Feedback (1-2 hours)

```swift
// Success haptics
UIImpactFeedbackGenerator(style: .medium).impactOccurred()

// Selection haptics
UISelectionFeedbackGenerator().selectionChanged()

// Error haptics
UINotificationFeedbackGenerator().notificationOccurred(.error)
```

**AI Task:** "Add appropriate haptic feedback for copy actions, favorites, exports, and selections"

### 6.4 Accessibility (2-3 hours)

**Ensure compliance:**
```swift
// All symbols have accessibility labels
.accessibilityLabel(symbol.name)

// Actions are labeled
.accessibilityLabel("Export symbol as PNG")

// Dynamic Type support
.dynamicTypeSize(...DynamicTypeSize.accessibility5)

// VoiceOver hints
.accessibilityHint("Double tap to view details")
```

**AI Task:** "Audit and enhance accessibility: add labels, hints, Dynamic Type support, VoiceOver optimization, and keyboard navigation for iPad"

### 6.5 Performance Optimization (2-3 hours)

**Ensure 60fps scrolling:**
```swift
// Use LazyVGrid (already done)
// Cache rendered images
let imageCache = NSCache<NSString, UIImage>()

// Debounce search if needed
.onChange(of: searchText, debounceTime: 0.3) { /* ... */ }

// Batch exports with autoreleasepool
for batch in symbols.chunked(into: 10) {
    autoreleasepool {
        // Export batch
    }
}
```

**AI Task:** "Optimize performance: add NSCache for rendered symbols, debounce search, ensure 60fps scrolling with 6,900+ symbols"

### 6.6 Final Testing (2-3 hours)

**Test scenarios:**
- Search with 0 results
- Export with permission denied
- Dark mode switching
- iPad rotation
- Large content size (accessibility)
- Multi-select with 100+ symbols
- Batch export memory usage
- Collection sync across launches

**AI Task:** "Create comprehensive test suite covering edge cases, performance, and accessibility scenarios"

---

## AI-Assisted Development Guidelines

### Parallel Tasks

The following tasks can be developed in parallel by AI:

**Parallel Set 1 (Phase 1):**
- Data Models
- Symbol Repository
- Grid ViewModel

**Parallel Set 2 (Phase 1-2):**
- SymbolCellView
- WeightSelectorView
- Category Filter

**Parallel Set 3 (Phase 4):**
- Color Picker
- Rendering Mode Picker
- Code Generation Service

**Parallel Set 4 (Phase 5):**
- Collections Management
- SVG Export
- Settings View

### AI Prompting Strategy

1. **Component-by-component:** Ask AI to build one complete component at a time
2. **Include context:** Reference the CLAUDE-LEAN.md rules in prompts
3. **Test after each component:** Verify functionality before moving on
4. **Iterate on feedback:** If something doesn't work, provide error messages

### Quality Gates

Before moving to next phase:
- [ ] All views render without crashes
- [ ] Navigation works correctly
- [ ] Data persists across app launches
- [ ] Dark mode works throughout
- [ ] iPad layouts are functional
- [ ] No force unwrapping in code
- [ ] 80% test coverage on business logic

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| SFSafeSymbols API changes | Pin to specific version (7.0.0) |
| Export permissions | Handle denial gracefully with user guidance |
| Performance with 6,900 symbols | Use LazyVGrid, image caching, pagination |
| iOS 26 Liquid Glass unavailable | Graceful degradation to standard UI |
| SVG export complexity | Consider third-party library if needed |

---

## Success Criteria

### MVP Success (End of Phase 2)
- [ ] Browse 6,900+ symbols at 60fps
- [ ] Search finds symbols in <1 second
- [ ] Export produces valid PNG file
- [ ] Copy name works correctly
- [ ] Works on iPhone and iPad
- [ ] No crashes

### Product Success (End of Phase 6)
- [ ] Multi-scale export produces production-ready assets
- [ ] Code generation produces valid SwiftUI/UIKit code
- [ ] Semantic search finds relevant symbols
- [ ] Collections organize user workflows
- [ ] Batch export handles 100+ symbols efficiently
- [ ] Liquid Glass looks native on iOS 26
- [ ] 80% test coverage
- [ ] App Store ready

---

## Appendix: File Checklist

### Models
- [ ] SymbolItem.swift
- [ ] SymbolCategory.swift
- [ ] SymbolCollection.swift
- [ ] ExportConfiguration.swift
- [ ] AppSettings.swift

### ViewModels
- [ ] SymbolGridViewModel.swift
- [ ] SymbolDetailViewModel.swift
- [ ] FavoritesViewModel.swift
- [ ] SettingsViewModel.swift

### Views
- [ ] MainTabView.swift
- [ ] SymbolGridView.swift
- [ ] SymbolCellView.swift
- [ ] SymbolDetailView.swift
- [ ] WeightSelectorView.swift
- [ ] ColorPickerView.swift
- [ ] RenderingModePicker.swift
- [ ] CategoryFilterView.swift
- [ ] ExportOptionsSheet.swift
- [ ] CodeGenerationView.swift
- [ ] FavoritesView.swift
- [ ] CollectionDetailView.swift
- [ ] SettingsView.swift
- [ ] iPadMainView.swift

### Services
- [ ] ExportService.swift
- [ ] BatchExportService.swift
- [ ] SVGExportService.swift
- [ ] CodeGenerationService.swift
- [ ] PersistenceService.swift

### Repositories
- [ ] SymbolRepository.swift
- [ ] KeywordRepository.swift

### Resources
- [ ] semantic-keywords.json

---

*This build plan is optimized for AI-assisted development with Claude Code. Each task includes specific AI prompts and can be executed in a single coding session.*
