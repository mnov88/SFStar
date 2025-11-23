# SF Symbols App - MVP User Flow
**Stage: Minimum Viable Product (2-3 weeks)**
**Goal: Ship something useful fast - Browse, search, view, export**

---

## 🎯 Core User Journey

```
App Launch → Browse Grid → Search/Filter → View Details → Export/Copy → Done
```

---

## 📱 Screen-by-Screen User Flow

### 1. **Launch Screen → Symbol Grid**
**First Impression: Instant value**

**User sees:**
- Grid of SF Symbols (6,900+ symbols)
- Search bar at top
- Category filter button (optional)

**User can:**
- Scroll through symbols immediately
- Tap search to find specific symbols
- Tap category filter for browsing

**Design Notes:**
- No onboarding - symbols are self-explanatory
- Grid is primary interface (not hidden)
- Lazy loading for performance

---

### 2. **Symbol Grid View**
**Primary Browse Interface**

#### **iPhone Layout:**
```
┌─────────────────────┐
│  🔍 Search Symbols  │ ← Search bar (always visible)
├─────────────────────┤
│ [Filter] 6,900 sym  │ ← Category filter button + count
├─────────────────────┤
│                     │
│  📷  🏠  ⭐  ❤️  📝  │ ← Grid (3-4 columns)
│  📁  🔒  ⚙️  📱  🌟  │
│  ✉️  📞  🎵  🎮  🔔  │
│  🗂  📊  📈  🎨  🖼  │
│  ...  (scrollable)  │
│                     │
└─────────────────────┘
```

**Grid Specifications:**
- **iPhone SE/Mini:** 3 columns (tight spacing)
- **iPhone Standard:** 4 columns (comfortable)
- **iPhone Pro Max:** 5 columns (expansive)
- Cell size: 64x64 pt minimum (accessibility)
- Spacing: 12-16 pt between cells
- Symbol size: 32-40 pt

**Interaction:**
- Tap symbol → Detail view
- Long press → Quick action menu (copy name)
- Scroll → Infinite scroll with lazy loading

#### **iPad Layout:**
```
┌─────────────────────────────────────┐
│  🔍 Search Symbols     [Filter] □   │ ← Search + filter + view options
├─────────────────────────────────────┤
│                                     │
│  📷 🏠 ⭐ ❤️ 📝 📁 🔒 ⚙️ 📱 🌟  │ ← Grid (6-8 columns)
│  ✉️ 📞 🎵 🎮 🔔 🗂 📊 📈 🎨 🖼  │
│  ...  (more columns, scrollable)    │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

**Grid Specifications:**
- **iPad Portrait:** 6 columns
- **iPad Landscape:** 8-10 columns
- Cell size: 72x72 pt (more breathing room)
- Spacing: 16-20 pt
- Symbol size: 40-48 pt

**iPad-Specific:**
- Keyboard shortcuts (Cmd+F for search)
- Pointer hover effects
- Drag symbols to other apps

---

### 3. **Search Interface**
**Activated when user taps search bar**

#### **iPhone:**
```
┌─────────────────────┐
│ 🔍 [heart____]  ✕   │ ← Active search field + clear
├─────────────────────┤
│                     │
│  ❤️ heart.fill      │ ← Filtered results
│  💔 heart.broken    │
│  💗 heart.circle    │
│  ❤️‍🔥 heart.slash  │
│  💝 heart.rectangle │
│  ...                │
│                     │
│  No results? Try:   │ ← Helpful suggestions if empty
│  • "love" "like"    │
│  • Check spelling   │
└─────────────────────┘
```

**Search Behavior:**
- Real-time filtering (as you type)
- Matches symbol names (substring matching)
- Shows result count: "142 symbols"
- Clear button (✕) to reset
- Keyboard: Shows immediately, hides on scroll

#### **iPad:**
```
┌─────────────────────────────────────┐
│ 🔍 [heart_________]  ✕      142 sym │ ← Search + count
├─────────────────────────────────────┤
│                                     │
│  ❤️ 💔 💗 ❤️‍🔥 💝 💖 💘 💙 🧡  │ ← Filtered grid
│  💚 💛 💜 🖤 🤍 🤎 ❣️ 💕 💞  │
│  ...                                │
│                                     │
└─────────────────────────────────────┘
```

**iPad Specifics:**
- Search field in navigation bar (top-trailing)
- Results shown inline in grid
- Keyboard shortcuts (Esc to cancel search)

---

### 4. **Category Filter** (Optional for MVP)
**Sheet presenting categories**

#### **iPhone:**
```
┌─────────────────────┐
│   Categories   Done │ ← Sheet header
├─────────────────────┤
│  All Symbols  ✓     │ ← Selected category
│  Communication      │
│  Weather            │
│  Objects            │
│  Transportation     │
│  Nature             │
│  Symbols            │
│  ...                │
└─────────────────────┘
```

**Categories (15 main groups):**
1. All Symbols (default)
2. Communication
3. Weather
4. Objects & Tools
5. Transportation
6. Nature
7. Symbols
8. Human & Body
9. Gaming
10. Health & Fitness
11. Commerce
12. Text & Media
13. Editing
14. Math & Science
15. Shapes

**Interaction:**
- Tap category → Filter grid
- "All Symbols" resets filter
- Sheet dismisses automatically

---

### 5. **Symbol Detail View**
**Tapping a symbol shows detail**

#### **iPhone:**
```
┌─────────────────────┐
│  ← Symbol     Copy  │ ← Nav bar (back + copy name)
├─────────────────────┤
│                     │
│        ❤️           │ ← Large preview (128pt)
│                     │
│    heart.fill       │ ← Symbol name
├─────────────────────┤
│  Weight             │ ← Section header
│  ○ ○ ○ ● ○ ○ ○ ○ ○ │ ← Weight selector (9 weights)
│  UL Th Lt Rg Md Sm Bd Hv Bl
│                     │
│        ❤️           │ ← Preview updates with weight
│                     │
├─────────────────────┤
│  [Export PNG]       │ ← Primary action button
└─────────────────────┘
```

**Detail Components:**

**1. Large Preview:**
- 128x128 pt symbol display
- Updates live when weight changes
- Clean background (system background color)

**2. Symbol Name:**
- Centered below preview
- Monospace font (system mono)
- Easily identifiable for copying

**3. Weight Selector:**
- Horizontal row of 9 weights
- Radio button style selection
- Labels: UL, Th, Lt, Rg, Md, Sm, Bd, Hv, Bl
- Selected weight highlighted
- Preview updates immediately

**4. Export Button:**
- Prominent bordered button
- Full width (minus padding)
- Primary action: "Export PNG"

#### **iPad:**
```
┌─────────────────────────────────────┐
│  ← heart.fill           Copy  Share │ ← More actions
├─────────────────────────────────────┤
│                                     │
│            ❤️                       │ ← Larger preview (160pt)
│                                     │
│        heart.fill                   │
│                                     │
│  Weight                             │
│  ○ ○ ○ ● ○ ○ ○ ○ ○                 │
│  Ultralight  Thin  Light  Regular   │ ← Full labels
│  Medium  Semibold  Bold  Heavy      │
│  Black                              │
│                                     │
│            ❤️                       │ ← Preview
│                                     │
│                                     │
│  [Export PNG]     [Copy Name]      │ ← Multiple actions
└─────────────────────────────────────┘
```

**iPad Enhancements:**
- Larger preview (160pt vs 128pt)
- Full weight labels (not abbreviated)
- Side-by-side action buttons
- Share button in nav bar

---

### 6. **Export Flow**
**User taps "Export PNG"**

#### **iPhone:**
```
┌─────────────────────┐
│  Export Symbol      │
├─────────────────────┤
│                     │
│        ❤️           │ ← Preview of what's exporting
│                     │
│  heart.fill         │
│  @2x • Regular      │ ← Export settings
│                     │
│  Exporting...       │ ← Progress indicator
│                     │
│  ✓ Saved to Photos  │ ← Success message
│                     │
│  [Done]             │ ← Dismiss
└─────────────────────┘
```

**Export Process:**
1. Show confirmation sheet with preview
2. Render symbol as PNG (@2x, 128x128 px)
3. Save to Photos library
4. Show success message
5. Auto-dismiss after 1.5s

**Technical:**
- Export size: 128x128 px @2x (256x256 actual)
- Format: PNG with transparency
- Color: Black on transparent (matches system)
- Save location: Photos library (requires permission)

---

### 7. **Copy Name Flow**
**User taps "Copy" button**

```
┌─────────────────────┐
│  ← Symbol     Copy  │ ← Button changes to checkmark
├─────────────────────┤
│                     │
│        ❤️           │
│                     │
│    heart.fill       │
│                     │
│  ✓ Copied to        │ ← Toast notification
│    clipboard        │ ← Fades after 1.5s
│                     │
└─────────────────────┘
```

**Copy Behavior:**
- Copies symbol name to clipboard: `heart.fill`
- Shows brief confirmation (toast)
- Button momentarily shows checkmark
- User can paste into code editor

---

## 🎨 Visual Design Specifications

### Colors (System Dynamic)
```swift
// Using Apple's system colors
Background: .systemBackground
Secondary Background: .secondarySystemBackground
Text: .label
Secondary Text: .secondaryLabel
Accent: .tintColor (system blue by default)
```

### Typography
```swift
// SF Pro Text (system font)
Navigation Title: .largeTitle (34pt, bold)
Symbol Name: .title3 (20pt, medium, monospaced)
Body Text: .body (17pt, regular)
Caption: .caption1 (12pt, regular)
```

### Spacing
```swift
// Consistent spacing units
Extra Small: 4pt
Small: 8pt
Medium: 16pt
Large: 24pt
Extra Large: 32pt
```

### Grid Layout
```swift
// iPhone
let columns = GridItem(.adaptive(minimum: 64, maximum: 80), spacing: 12)

// iPad
let columns = GridItem(.adaptive(minimum: 72, maximum: 96), spacing: 16)
```

---

## 🚦 Navigation Pattern

**MVP uses standard hierarchical navigation:**

```
Symbol Grid (Root)
    ↓ (tap symbol)
Symbol Detail
    ↓ (tap back)
Symbol Grid (returns to same scroll position)
```

**No tabs in MVP** - Single primary view keeps it simple

---

## ⚡ Performance Considerations

1. **Lazy Loading:**
   - Only render visible cells
   - Load symbols on-demand as user scrolls
   - SwiftUI: `LazyVGrid` automatically handles this

2. **Symbol Rendering:**
   - Use `Image(systemName:)` for efficient rendering
   - Cache rendered images for weight changes
   - Limit preview updates to avoid lag

3. **Search:**
   - Filter array locally (all 6,900 names in memory is fine)
   - Case-insensitive search
   - Debounce if needed (unlikely with simple substring search)

4. **Export:**
   - Render on background thread
   - Show progress for larger exports
   - Request Photos permission on first export

---

## 📋 MVP Scope Summary

### ✅ Included:
- Browse 6,900+ symbols in grid
- Text search (substring matching)
- Category filter (15 categories)
- Symbol detail view
- Weight selector (9 weights)
- Copy symbol name
- Export single PNG (@2x)
- Dark mode support
- iPhone + iPad layouts

### ❌ Excluded (Later Stages):
- Multi-scale export (@1x/@2x/@3x)
- Batch export
- Code generation
- Semantic search
- Favorites/Collections
- Color customization
- SVG export
- Animation preview

---

## 🎯 Success Metrics

**MVP is successful when:**
1. User can find any symbol within 10 seconds
2. Export produces usable PNG file
3. Copy name works for pasting into code
4. App feels fast and responsive (60fps scrolling)
5. No crashes on launch or export

**User can accomplish:**
- "I need a heart symbol for my app" → Find, export, done
- "What's this symbol called?" → Search, copy name
- "Show me weather symbols" → Filter by category, browse

---

## 💡 Design Principles Applied

### From Apple HIG:

1. **Clarity:** Clean grid, clear labels, obvious actions
2. **Deference:** Symbols are the star, UI is minimal
3. **Depth:** Simple hierarchy (grid → detail)

### Liquid Glass (Minimal in MVP):
- Standard navigation bar (automatic Liquid Glass)
- Standard sheets for filters (automatic)
- Focus on content, not fancy effects

### Navigation:
- Single root view (no tabs needed yet)
- Standard hierarchical navigation
- Back button always visible

---

*This MVP focuses on core value: helping users find and export SF Symbols quickly. Everything else can wait.*