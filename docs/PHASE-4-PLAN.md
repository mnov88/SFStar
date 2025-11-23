# Phase 4: Product Features - Implementation Plan

**Duration:** 3-4 days AI-assisted
**Focus:** Developer-centric features for production workflows

---

## Priority Order (Dependencies Considered)

| # | Feature | Priority | Depends On | Value |
|---|---------|----------|------------|-------|
| 1 | Code Generation Service | HIGH | - | Core developer workflow |
| 2 | Code Generation View | HIGH | #1 | User-facing code output |
| 3 | Multi-Scale Export | HIGH | - | Production asset creation |
| 4 | Color Picker | MEDIUM | - | Customization completeness |
| 5 | Rendering Mode Picker | MEDIUM | - | Customization completeness |
| 6 | Semantic Search | MEDIUM | - | Discovery enhancement |
| 7 | iOS Compatibility Badges | LOW | - | Polish/info feature |

---

## 1. Code Generation Service

**File:** `Services/CodeGenerationService.swift`

**Scope:**
- Generate SwiftUI code with symbol name, weight, color, rendering mode
- Generate UIKit code with equivalent configuration
- Handle all 9 weights, system colors, 4 rendering modes
- Output properly formatted, copy-ready code

**Output Example (SwiftUI):**
```swift
Image(systemName: "heart.fill")
    .symbolRenderingMode(.hierarchical)
    .foregroundStyle(.pink)
    .font(.system(size: 32, weight: .semibold))
```

**Output Example (UIKit):**
```swift
let config = UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold)
let image = UIImage(systemName: "heart.fill", withConfiguration: config)?
    .withRenderingMode(.alwaysTemplate)
imageView.image = image
imageView.tintColor = .systemPink
```

---

## 2. Code Generation View

**File:** `Views/Detail/CodeGenerationView.swift`

**Components:**
- Framework picker (SwiftUI/UIKit segmented control)
- Syntax-highlighted code display (monospace, secondary background)
- Copy button with haptic + toast confirmation
- Preview of current symbol configuration

---

## 3. Multi-Scale Export

**File:** Update `Views/Detail/ExportOptionsSheet.swift`

**Scope:**
- Scale selection: @1x (64pt), @2x (128pt), @3x (192pt)
- Multi-select toggles (can export 1, 2, or all 3)
- File naming: `symbolname@1x.png`, `symbolname@2x.png`, `symbolname@3x.png`
- Single export action creates all selected scales

**UI:**
```
Format: [PNG] [SVG]  ← existing
Scales: [x] @1x  [x] @2x  [x] @3x
Export 3 Files →
```

---

## 4. Color Picker

**File:** `Views/Detail/SymbolColorPicker.swift`

**Components:**
- System colors grid (13 colors): primary, red, orange, yellow, green, mint, teal, cyan, blue, indigo, purple, pink, brown
- Custom ColorPicker for arbitrary colors
- Selection indicator (checkmark overlay)

---

## 5. Rendering Mode Picker

**File:** `Views/Detail/RenderingModePicker.swift`

**Options:**
- Monochrome (single color)
- Hierarchical (depth via opacity)
- Palette (up to 3 colors)
- Multicolor (original colors)

**UI:** Segmented picker with live preview

---

## 6. Semantic Search

**Files:**
- `Repositories/KeywordRepository.swift`
- `Resources/semantic-keywords.json`

**Approach:**
- JSON mapping: keyword → [symbol names]
- ~100 common keywords covering actions, objects, concepts
- Integrate with existing search (check keywords if name doesn't match)

**Example mappings:**
```json
{
  "upload": ["arrow.up", "square.and.arrow.up", "icloud.and.arrow.up"],
  "settings": ["gear", "gearshape", "slider.horizontal.3"],
  "love": ["heart", "heart.fill", "heart.circle"]
}
```

---

## 7. iOS Compatibility Badges

**File:** `Views/Components/CompatibilityBadge.swift`

**Display:**
- Green checkmark + "iOS 13+" if compatible with user's target
- Orange warning + "iOS 16+" if newer than target
- Derive version from symbol availability metadata

---

## Implementation Order

```
Day 1: Code Generation (Service + View)
Day 2: Multi-Scale Export + Color Picker
Day 3: Rendering Mode Picker + Detail View Integration
Day 4: Semantic Search + Compatibility Badges
```

---

## Integration Points

### SymbolDetailView Updates
Add to existing detail view:
- Color picker section
- Rendering mode picker section
- "Generate Code" button → sheet
- Enhanced export button → multi-scale sheet
- Compatibility badge near symbol name

### Premium Detail View Updates
Same additions with premium styling/animations

### Settings Updates
- Default color preference
- Default rendering mode
- Target iOS version for compatibility

---

## Success Criteria

- [ ] Code generation produces valid, compilable SwiftUI code
- [ ] Code generation produces valid, compilable UIKit code
- [ ] Multi-scale export creates correctly sized PNG files
- [ ] Color picker shows all 13 system colors + custom
- [ ] Rendering mode picker updates preview in real-time
- [ ] Semantic search finds "upload" → arrow.up symbols
- [ ] Compatibility badges show correct iOS version requirements
