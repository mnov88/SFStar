# SF Symbols App - Product User Flow
**Stage: Professional Product (1-2 months)**
**Goal: Pro-level tool competing with San Fransymbols + unique advantages**

---

## 🎯 Core User Journey

```
Launch → Browse/Search → Customize (weight/color/mode) → Export Multi-Scale/Generate Code → Organize Collections → Done
```

**New Capabilities:**
- Multi-scale export (@1x/@2x/@3x)
- Semantic search (keyword matching)
- Code generation (SwiftUI + UIKit)
- Color customization + preview
- Rendering modes (4 types)
- Batch export
- Favorites & Collections
- iOS version compatibility
- SVG export

---

## 📱 Navigation Structure (UPGRADED)

### Tab Bar Navigation (NEW)

#### **iPhone:**
```
┌─────────────────────┐
│                     │
│   Main Content      │ ← Active tab content
│                     │
│                     │
├─────────────────────┤
│ 🔍  ⭐  ⚙️         │ ← Tab bar (3 tabs)
│Search Fav Settings  │
└─────────────────────┘
```

**3 Tabs:**
1. **Search** (Primary) - Browse & search all symbols
2. **Favorites** - Quick access to saved symbols
3. **Settings** - App preferences

**Why Tabs Now:**
- Clear separation of Browse vs Saved content
- Persistent access to favorites
- Settings need dedicated space for new features

#### **iPad:**
```
┌─────────────────────────────────────┐
│  ⚙️  SF Symbols  ⭐  📋            │ ← Toolbar (actions in nav bar)
├──────┬──────────────────────────────┤
│      │                              │
│ 🔍   │     Main Content Area        │ ← Sidebar + Detail
│      │                              │
│ Coll │                              │
│      │                              │
│ Sett │                              │
└──────┴──────────────────────────────┘
```

**iPad uses NavigationSplitView:**
- Sidebar: Search, Collections, Settings
- Detail: Symbol grid or detail view
- Toolbar: Quick actions (batch operations)

---

## 🔍 Screen-by-Screen Flows

### Tab 1: Search (Enhanced)

#### **1. Symbol Grid with Advanced Search**

```
┌─────────────────────┐
│  🔍 [upload______] ✕│ ← Semantic search
├─────────────────────┤
│  Suggested:         │ ← NEW: Keyword suggestions
│  "upload, cloud"    │
├─────────────────────┤
│                     │
│  ↗️  ☁️↗  📤  📮   │ ← Semantic results
│  "These match       │
│   'upload' intent"  │
│                     │
│  123 symbols found  │ ← Result count
│                     │
│  [🎨 Color] [⚙️ iOS]│ ← NEW: Quick filters
└─────────────────────┘
```

**Semantic Search:**
- Type "upload" → Shows upload-related symbols
- Type "love" → Shows heart symbols
- Type "warning" → Shows alert/exclamation symbols
- Keyword database maps common terms to symbol groups

**Quick Filters (NEW):**
- Color button → Open color picker
- iOS button → Filter by compatibility

#### **2. Symbol Detail (Enhanced)**

```
┌─────────────────────┐
│  ← ⭐ ⚙️  Copy Code│ ← Star to favorite + gear menu
├─────────────────────┤
│                     │
│        ❤️           │ ← Large preview (updates live)
│                     │
│    heart.fill       │
│    iOS 13.0+  ✓    │ ← NEW: Compatibility badge
│                     │
├─────────────────────┤
│  Weight    Regular  │ ← Weight selector
│  ○○○●○○○○○          │
│                     │
│  Color     [🎨]    │ ← NEW: Color picker
│  ● Red              │
│                     │
│  Rendering  ≡       │ ← NEW: Rendering mode
│  ● Hierarchical     │
│                     │
│        ❤️           │ ← Preview with all settings
│                     │
├─────────────────────┤
│  [Export PNG ▼]     │ ← Export menu (multi-option)
│  [Generate Code]    │ ← NEW: Code generation
└─────────────────────┘
```

**Enhancement Details:**

**1. Favorite Star:**
- Tap star in nav bar → Add to favorites
- Filled star = already favorited
- Syncs instantly to Favorites tab

**2. Compatibility Badge:**
- Shows minimum iOS version
- Green checkmark if compatible with user's target
- Warning if incompatible: "⚠️ iOS 17.0+"

**3. Color Picker:**
```
Tap color → Sheet presents:
┌─────────────────────┐
│  Choose Color Close │
├─────────────────────┤
│                     │
│  System Colors:     │
│  ⬛ ⬜ 🔴 🔵 🟢 🟡  │
│  🟠 🟣 🟤 🔴        │
│                     │
│  Custom:            │
│  [Color Wheel]      │
│                     │
│  HEX: #FF0000       │
│                     │
│  [Apply]            │
└─────────────────────┘
```

**4. Rendering Mode:**
```
Tap rendering → Picker appears:
┌─────────────────────┐
│  Rendering Mode     │
├─────────────────────┤
│  ● Monochrome       │ ← Single color
│  ○ Hierarchical     │ ← Opacity variation
│  ○ Palette          │ ← Multiple colors
│  ○ Multicolor       │ ← Full color (if available)
│                     │
│  [Apply]            │
└─────────────────────┘
```

Preview updates immediately with each change.

#### **3. Export Menu (Multi-Scale)**

```
┌─────────────────────┐
│  Export Options     │
├─────────────────────┤
│  Format:            │
│  ● PNG              │
│  ○ SVG              │ ← NEW: Vector format
│                     │
│  Scales: (PNG only) │
│  ☑ @1x (64px)      │ ← NEW: Multi-select
│  ☑ @2x (128px)     │
│  ☑ @3x (192px)     │
│                     │
│  Settings:          │
│  Weight: Regular    │
│  Color: #FF0000     │
│  Mode: Hierarchical │
│                     │
│  Preview:           │
│  ❤️ ❤️ ❤️          │ ← 3 sizes
│  64 128 192         │
│                     │
│  [Export 3 Files]   │ ← Clear action
└─────────────────────┘
```

**Export Process:**
1. Choose format (PNG or SVG)
2. Select scales (multi-select for PNG)
3. Preview shows all sizes
4. Export creates ZIP if multiple files
5. Success toast: "3 files saved"

**File Naming:**
```
heart-fill@1x.png
heart-fill@2x.png
heart-fill@3x.png
```

Or for SVG:
```
heart-fill.svg
```

#### **4. Code Generation**

```
┌─────────────────────┐
│  Generate Code Close│
├─────────────────────┤
│  Framework:         │
│  ● SwiftUI          │
│  ○ UIKit            │
│                     │
│  ──────────────────│
│                     │
│  Image(systemName:  │ ← Generated code
│    "heart.fill")    │
│    .symbolRendering │
│    (.hierarchical)  │
│    .foregroundStyle │
│    (.red)           │
│    .font(.system(   │
│      size: 32,      │
│      weight:        │
│      .regular))     │
│                     │
│  [Copy Code]        │ ← Copy to clipboard
│  [Share]            │ ← Share via system sheet
└─────────────────────┘
```

**Code Variations:**

**SwiftUI:**
```swift
Image(systemName: "heart.fill")
    .symbolRenderingMode(.hierarchical)
    .foregroundStyle(.red)
    .font(.system(size: 32, weight: .regular))
```

**UIKit:**
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

**Copy Behavior:**
- Copies formatted code to clipboard
- Toast confirmation: "Code copied"
- User can paste directly into Xcode

---

### Tab 2: Favorites

#### **Favorites Grid**

```
┌─────────────────────┐
│  Favorites    [...]  │ ← Title + batch actions menu
├─────────────────────┤
│                     │
│  Recently Added     │ ← Section header
│  ❤️  ⭐  📝  ✉️     │ ← Grid of favorited symbols
│                     │
│  From Last Week     │ ← Auto-organized by time
│  🏠  ⚙️  📁  🔒     │
│                     │
│  Collections  +     │ ← User collections
│  📋 My Project      │
│  🎨 Design System   │
│                     │
│  [No favorites yet] │ ← Empty state
│  Tap ⭐ on symbols  │
│  to save them here  │
└─────────────────────┘
```

**Features:**

**1. Auto-Grouping:**
- Recently Added (last 7 days)
- Last Week
- Last Month
- Older

**2. Collections (NEW):**
- User-created folders
- Tap "+" to create new collection
- Long-press to rename/delete
- Drag symbols to collections

**3. Batch Actions Menu (...):**
```
┌─────────────────────┐
│  Batch Actions      │
├─────────────────────┤
│  Select Multiple    │ ← Multi-select mode
│  Export All         │ ← Batch export
│  Remove All         │ ← Clear favorites
│  Create Collection  │
└─────────────────────┘
```

#### **Collection Detail**

```
┌─────────────────────┐
│  ← My Project  [...]│ ← Collection name + menu
├─────────────────────┤
│                     │
│  ❤️  ⭐  📝  ✉️     │ ← Symbols in this collection
│  🏠  ⚙️  📁  🔒     │
│                     │
│  8 symbols          │ ← Count
│                     │
│  [Export All]       │ ← Batch export button
└─────────────────────┘
```

**Collection Menu (...):**
- Rename Collection
- Export All Symbols
- Delete Collection

---

### Tab 3: Settings

#### **Settings List**

```
┌─────────────────────┐
│  Settings           │
├─────────────────────┤
│  DEFAULTS           │
│  Export Format  PNG │ ← Tap to change
│  Export Scales  All │
│  Default Weight Reg │
│                     │
│  COMPATIBILITY      │
│  Target iOS   14.0  │ ← Filter symbols
│  Show Badge    ✓    │
│                     │
│  APPEARANCE         │
│  Grid Columns  Auto │
│  Symbol Size   Med  │
│                     │
│  ABOUT              │
│  Version 1.0        │
│  SF Symbols 7.0     │
│  [Send Feedback]    │
│  [Rate App]         │
└─────────────────────┘
```

**Key Settings:**

**1. Export Defaults:**
- Format: PNG or SVG
- Scales: @1x, @2x, @3x (multi-select)
- Default Weight: Ultralight → Black

**2. Compatibility Filter:**
- Target iOS version selector
- When set, grid only shows compatible symbols
- Badge shows on incompatible symbols

**3. Grid Customization:**
- Columns: Auto, 3, 4, 5, 6
- Symbol Size: Small, Medium, Large

---

## 📊 iPad-Specific Layouts

### NavigationSplitView Structure

```
┌─────────────────────────────────────────────┐
│  SF Symbols        ⭐  📋  ⚙️               │ ← Toolbar
├──────┬──────────────────────────────────────┤
│      │                                      │
│ 🔍   │  🔍 [semantic search____] ✕         │ ← Detail area
│Search│  ─────────────────────────────────  │
│      │                                      │
│ ⭐   │  📷 🏠 ⭐ ❤️ 📝 📁 🔒 ⚙️ 📱 🌟    │
│Favs  │  ✉️ 📞 🎵 🎮 🔔 🗂 📊 📈 🎨 🖼    │
│      │  ... (8-10 columns grid)            │
│ 📋   │                                      │
│Colls │                                      │
│      │  Selected: 3 symbols  [Export]      │ ← Batch toolbar
│ ⚙️   │                                      │
│Setts │                                      │
│      │                                      │
└──────┴──────────────────────────────────────┘
```

**iPad Features:**

**1. Sidebar Sections:**
- Search (main browse)
- Favorites
- Collections (expandable list)
- Settings

**2. Toolbar Actions:**
- Batch select mode toggle
- Export selected
- Add to collection
- Settings

**3. Multi-Selection:**
- Cmd+Click to select multiple
- Shift+Click for range selection
- Toolbar appears with selection count

**4. Drag & Drop:**
- Drag symbols to other apps
- Drag to create collections
- Drag to desktop for export

---

## 🎨 Visual Enhancements (Product Stage)

### Liquid Glass Integration

**Apply to:**
- Tab bar (automatic in iOS 26)
- Navigation bar (automatic)
- Sheets (export options, collections)
- Detail view background

**Custom Glass Effects:**
```swift
// For custom controls (like batch selection toolbar)
HStack {
    Text("3 selected")
    Button("Export") { }
}
.glassEffect()
.padding()
```

### Color System

**Dynamic colors with customization:**
```swift
// Default system colors
Primary: .tintColor
Background: .systemBackground

// User-customizable:
Symbol Preview: User-selected color
Export Preview: Shows actual color
```

### Animations

**Subtle interactions:**
- Symbol tap → Scale + haptic
- Star favorite → Confetti (brief)
- Export success → Checkmark animation
- Collection drop → Smooth fade

---

## 🔄 User Flows (Complete Scenarios)

### Scenario 1: "Export heart symbol for app"

```
1. Launch app → Search tab
2. Type "heart"
3. Tap heart.fill
4. Adjust:
   - Weight: Bold
   - Color: Red
   - Mode: Hierarchical
5. Tap "Export PNG ▼"
6. Select: ☑ @1x ☑ @2x ☑ @3x
7. Tap "Export 3 Files"
8. → ZIP saved to Files app
   → Toast: "3 files saved"
```

### Scenario 2: "Get SwiftUI code for custom symbol"

```
1. Launch → Search "cloud"
2. Tap "cloud.upload"
3. Set color: Blue
4. Tap "Generate Code"
5. Select: SwiftUI
6. → Code appears
7. Tap "Copy Code"
8. → Toast: "Code copied"
9. Paste into Xcode ✓
```

### Scenario 3: "Build design system collection"

```
1. Go to Favorites tab
2. Tap "+" next to Collections
3. Name: "Design System"
4. Go to Search tab
5. Find symbols:
   - heart.fill → Tap ⭐
   - star.fill → Tap ⭐
   - checkmark → Tap ⭐
6. Return to Favorites
7. Long-press symbols → Drag to "Design System"
8. Open "Design System" collection
9. Tap "Export All"
10. → All symbols exported as batch
```

### Scenario 4: "Filter for iOS 14 compatible symbols"

```
1. Go to Settings
2. Set "Target iOS" → 14.0
3. Enable "Show Badge" ✓
4. Return to Search
5. → Grid shows only iOS 14+ symbols
6. → Newer symbols show "⚠️ iOS 17.0+" badge
```

---

## 🎯 Product Stage Success Metrics

**User can now:**
1. Export production-ready assets (@1x/@2x/@3x)
2. Generate copy-paste code (SwiftUI + UIKit)
3. Organize symbols in collections
4. Batch export entire sets
5. Filter by iOS compatibility
6. Export SVG for designers
7. Use semantic search for intent-based finding

**Key Improvements Over MVP:**
- 10x more export options
- Code generation (huge developer win)
- Collections for organization
- Batch operations for efficiency
- Professional-grade outputs

---

## 💡 Design Principles Applied

### Product Stage Enhancements:

**1. Clarity:**
- Color-coded compatibility badges
- Clear export options with previews
- Organized collections structure

**2. Efficiency:**
- Batch operations reduce repetitive tasks
- Quick filters (color, iOS version)
- Semantic search finds intent, not just names

**3. Professional Power:**
- Multi-scale export = production-ready
- Code generation = copy-paste workflow
- SVG export = designer-friendly

**4. Organization:**
- Collections for project management
- Auto-grouping by recency
- Clear visual hierarchy

---

*Product stage transforms the app from "browse and save" to "professional workflow tool" - ready to compete with San Fransymbols and offer unique advantages (semantic search, compatibility filtering).*