# Apple Design Principles & Best Practices (2025)
**Synthesized from WWDC 2025 & Human Interface Guidelines**

---

## 🎨 Core Design Principles

### 1. **Clarity**
> "Legible text, precise controls, and sharp graphics create a seamless user interface"

**Key Practices:**
- Use ample white space to avoid overwhelming users
- Maintain clear visual hierarchy (important elements larger/bolder)
- Use simple, concise, descriptive language for labels
- Choose common, easily identifiable symbols
- Ensure readable typography at varying sizes
- Implement consistent UI element patterns

### 2. **Deference**
> "UI elements support rather than compete with content"

**Key Practices:**
- Interface should facilitate content discovery, not distract
- Controls use translucent backgrounds and minimal contrast
- Appear when needed without overshadowing content
- Content is the star, UI floats above unobtrusively

### 3. **Depth**
> "Visual layers and motion convey hierarchy and create spatial relationships"

**Key Practices:**
- Use subtle shadows, translucent materials to show relationships
- Motion reinforces depth (sheets scale up from buttons)
- Maximum 3 levels of depth: content, controls, temporary overlays
- Each layer represents clear relationship

---

## 💎 Liquid Glass Design System (2025)

### What is Liquid Glass?
**The most extensive software design update Apple has made**
- Adaptive material that floats above content
- Bends and shapes light while maintaining legibility
- Automatically adapts as you scroll (light to dark)
- Used for navigation layer that floats above content

### Core Behaviors:
1. **Lensing**: Bends light from content beneath
2. **Adaptation**: Changes from light to dark based on content
3. **Interactivity**: Controls transform during interaction (toggles, sliders shimmer)
4. **Spatial relationships**: Surfaces spring from their source (action sheets from buttons)

### When to Use:
- ✅ Navigation bars, toolbars, tab bars
- ✅ Sidebars, inspectors, sheets
- ✅ Floating controls above content
- ❌ Don't stack Liquid Glass on Liquid Glass
- ❌ Only tint to emphasize primary elements (not for visual effect alone)

---

## 📐 Shape System

### Three Core Shape Types:

#### 1. **Fixed Shapes**
- Constant corner radius regardless of container size
- Predictable geometry for consistent layouts

#### 2. **Capsules**
- Radius = half the container height
- Natural concentricity support
- **Primary choice for touch-friendly interfaces**
- iOS/iPadOS: Preferred for most interactive elements
- macOS: Reserved for Large and X-Large controls

#### 3. **Concentric Shapes**
- Radius calculated by subtracting padding from parent container
- Automatic inner radii calculation for nested elements
- Use `containerConcentric` configuration in SwiftUI

### Concentricity Rules:
- Interface elements must harmonize with system rhythm
- Nested containers require concentric alignment
- Near device edges: Use capsule with extra margin (iPhone) or concentric shape aligned to window edge (iPad/Mac)

---

## 🧭 Navigation Architecture

### Primary Navigation Patterns:

#### **Tab Bars** (Most Common)
**When to use:**
- 3-5 top-level sections of equal importance
- User needs to switch frequently between sections
- Each section has distinct content/functionality

**Best Practices:**
- Always keep tab bar persistent and visible
- Use minimum number of tabs required (3-5 ideal)
- Use succinct terms for tab titles
- **NEW in 2025:** Include dedicated Search tab on iOS (bottom position)
- Tab bar can minimize on scroll (use `.tabBarMinimizeBehavior(.onScrollDown)`)
- Use bottom accessory for persistent controls (media playback)
- ❌ Don't place screen-specific actions in tab bar (checkout buttons belong with content)

**Questions Tab Bars Answer:**
- "Where am I?"
- "What are the main sections?"
- "Where can I go?"

#### **Navigation Hierarchy**
**When to use:**
- Deep content hierarchy (category → subcategory → item → detail)
- Linear progression through related screens
- Drilling down into detailed information

**Best Practices:**
- Use navigation bar at top with clear titles
- Show back button with previous screen's title
- Breadcrumbs show navigation path
- Maintain consistent navigation patterns throughout

#### **Sidebars** (iPad/Mac)
**When to use:**
- Complex navigation with many categories
- Multi-pane layouts (NavigationSplitView)
- Desktop-class apps

**Best Practices:**
- **NEW in 2025:** Sidebars are inset with Liquid Glass
- Content can flow behind sidebar using `backgroundExtensionEffect`
- On iPhone: Use tab bar instead (sidebars too crowded)
- Leading pane: top-level collections
- Secondary pane: contents of selection
- Tertiary pane: additional details

---

## 🎯 Information Architecture

### Visual Hierarchy

**Three-Level System:**
1. **Content Layer** (bottom): Your app's actual content
2. **Controls Layer** (middle): Interactive elements, buttons
3. **Temporary Overlays** (top): Modals, alerts, sheets

**Expressing Hierarchy:**
- ❌ Don't use decoration (extra backgrounds, borders)
- ✅ Use layout and grouping
- ✅ Use size, weight, position
- ✅ Use spacing and containers

### Content Organization Strategies:

**Group by:**
- **Time**: Chronological ordering (messages, posts)
- **Progress**: Steps in workflow (onboarding, checkout)
- **Patterns**: Functional categories (settings groups)
- **Frequency**: Most-used to least-used

**Progressive Disclosure:**
- Show essential information first
- Reveal additional details on interaction
- Use "More" menus for secondary actions
- Keep primary path clear and uncluttered

---

## 🔧 Toolbar Guidelines (2025 Update)

### New Toolbar Behavior:

**Automatic Grouping:**
- Items grouped using correct API share background automatically
- Group by **function and frequency**
- Related actions go together

**Grouping Best Practices:**
- ✅ Group related actions (favorite + add to collection)
- ✅ Use `ToolbarSpacer(fixed: .standard)` for custom grouping
- ✅ Use `ToolbarSpacer(flexible: true)` for leading/trailing alignment
- ❌ Don't group symbols with text (looks like single button)
- ❌ Don't merge unrelated features

**Primary Actions:**
- Stay separate with tint (blue checkmark on iOS)
- Prominent text button on macOS
- Clear focal point, easy to spot

**Visual Updates:**
- Remove custom backgrounds and borders (system handles it)
- Icons use monochrome rendering by default
- Only tint to convey meaning (call to action), not decoration
- Automatic scroll edge effect for legibility

**Badges:**
- Use `.badge()` modifier to indicate notifications
- One line of code: `.badge(notificationCount)`

---

## 🔍 Search Patterns (2025)

### Two Main Patterns:

#### **1. Toolbar Search**
- Search field at bottom (iPhone) or top-trailing (iPad/Mac)
- Minimizes to button when space constrained
- Opt-in to minimized: `.searchToolbarBehavior(.minimized)`
- Use for apps where search applies to current screen

#### **2. Dedicated Search Tab**
- Entire tab dedicated to search + browsing
- Search field replaces tab bar when selected
- Centered field above suggestions (iPad/Mac)
- Use for apps where search covers entire content library

**Implementation:**
```swift
// Toolbar search (applies to entire NavigationSplitView)
NavigationSplitView { /* ... */ }
    .searchable(text: $searchText)

// Dedicated search tab
TabView {
    SearchView()
        .tabItem { Label("Search", systemImage: "magnifyingglass") }
        .searchRole(.searchPage)
}
.searchable(text: $searchText)
```

---

## 📱 Cross-Platform Continuity

### Device Context Understanding:

| Device | Characteristics | Layout Approach |
|--------|----------------|-----------------|
| **iPhone** | Narrow, vertical, zoomed-in focus | Single column, stacked content |
| **iPad** | Bridge between iPhone and Mac | Scalable, adaptive layouts |
| **Mac** | Wide, expansive canvas | Multi-pane, desktop-class |

### Design Once, Scale Everywhere:

**Shared Anatomy Principles:**
1. **Same symbols** across devices (preserve meaning)
2. **Consistent component structure** (icon, label, accessory)
3. **Same core interactions** (tap, swipe, select)
4. **Platform variations as expressions**, not exceptions

**Adaptive Behaviors:**
- Tab bar (iPhone) → Sidebar (iPad/Mac)
- Bottom toolbar (iPhone) → Top toolbar (iPad/Mac)
- Modal sheet (iPhone) → Popover (iPad/Mac)

---

## 🎨 Color & Typography (2025)

### System Colors:
- Adjusted across Light, Dark, Increased Contrast
- Enhanced hue differentiation
- Optimized for harmony with Liquid Glass
- Maintains Apple's "optimistic spirit"

### Typography:
- **Bolder text rendering** for improved clarity
- **Left-aligned** in critical moments (alerts, onboarding)
- SF Pro for UI text
- SF Symbols for icons (6,900+ symbols)

**Font Weights Hierarchy:**
- Regular: Body text
- Medium: Labels
- Semibold: Headings
- Bold: Emphasis

---

## 🎭 Modal Presentations

### When to Use Modals:

**Good Use Cases:**
- Full-screen content (video, article)
- Temporary task interrupting main flow
- Creating/editing new item
- Confirmation or alert requiring response

**Modal Anatomy:**
- Navigation bar with title
- Preferred action on right (bold, "Done")
- Dismiss action on left ("Cancel")
- ❌ Avoid modals over modals (jarring)

**NEW in 2025:**
- Sheets morph out of presenting buttons
- Partial height sheets inset with Liquid Glass
- Smooth transition to full height (glass becomes opaque)
- Modal + dimming layer = focused attention

---

## ✨ Animation & Interaction

### SF Symbols Animations (iOS 17+):
- Draw, Variable Draw, Wiggle, Rotate, Breathe, Bounce
- Use to convey state changes
- Provide feedback for user actions

### Liquid Glass Interactions:
- Controls shimmer during interaction
- Scale and bounce on press
- Smooth morphing between states
- Use `.interactive` modifier for custom controls

**Animation Principles:**
- Reinforce spatial relationships
- Provide feedback
- Maintain continuity
- Don't animate for decoration alone

---

## 🚫 Common Pitfalls to Avoid

1. **Navigation:**
   - ❌ Merging unrelated features into one tab
   - ❌ Inconsistent tab bar visibility
   - ❌ Too many tabs (>5)
   - ❌ Unclear navigation hierarchy

2. **Layout:**
   - ❌ Stacking Liquid Glass on Liquid Glass
   - ❌ Custom backgrounds behind system toolbars
   - ❌ Pinched or flared corners
   - ❌ Non-concentric nested containers

3. **Content:**
   - ❌ Interface competing with content
   - ❌ Too much decoration/visual noise
   - ❌ Inconsistent patterns
   - ❌ Missing visual hierarchy

4. **Interaction:**
   - ❌ Tinting for visual effect (not meaning)
   - ❌ Modals over modals
   - ❌ Screen-specific actions in persistent bars
   - ❌ Unclear affordances

---

## 📋 Pre-Launch Checklist

### Design Audit:
- [ ] Remove custom toolbar backgrounds/borders
- [ ] Verify all corners are concentric
- [ ] Check tab bar structure (3-5 tabs, includes Search if needed)
- [ ] Confirm visual hierarchy clear
- [ ] Test in Light and Dark modes
- [ ] Verify accessibility (contrast, touch targets, labels)

### Navigation Audit:
- [ ] Tab bar persistent throughout app
- [ ] Navigation bar titles clear and contextual
- [ ] Back button shows previous screen name
- [ ] Modal presentations appropriate
- [ ] No modals over modals

### Cross-Platform:
- [ ] Shared anatomy across devices
- [ ] Layouts adapt properly (iPhone/iPad/Mac)
- [ ] Same symbols and actions across platforms
- [ ] Continuity maintained in workflows

---

## 📚 Official Resources

**Human Interface Guidelines:**
- https://developer.apple.com/design/human-interface-guidelines/

**WWDC 2025 Essential Sessions:**
1. "Meet Liquid Glass" - Design introduction
2. "Get to know the new design system" - Comprehensive overview
3. "Build a SwiftUI app with the new design" - Technical implementation
4. "Elevate the design of your iPad app" - iPad-specific guidance

**Design Resources:**
- https://developer.apple.com/design/resources/
- Updated UI kits for Sketch, Figma, Adobe XD
- SF Symbols 7 app (free download)

---

## 💡 Key Takeaways

1. **Liquid Glass is the foundation** - Understand it first
2. **Content > Interface** - Deference principle paramount
3. **Design once, scale everywhere** - Shared anatomy approach
4. **Tab bars for navigation** - Most common, most effective
5. **3 levels of depth maximum** - Keep hierarchy clear
6. **Remove decoration** - Let system handle visual weight
7. **Concentricity matters** - Nested shapes must align
8. **Search is first-class** - Dedicated tab or prominent toolbar position
9. **Test across platforms** - iPhone, iPad, Mac behaviors differ
10. **Iterate based on HIG** - Guidelines are living documents

---

*Last Updated: WWDC 2025*
*This document synthesizes official Apple guidance for building modern iOS, iPadOS, and macOS applications.*