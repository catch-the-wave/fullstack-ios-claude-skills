<overview>
iOS layout is based on mathematical grids, spatial rhythm, and clear hierarchy. The 8pt grid system creates visual consistency. Depth and elevation signal importance. Generous spacing (Ma - negative space) creates breathing room and premium feel.
</overview>

<grid_system>
## The 8-Point Grid

**Base unit:** 8pt

**Common values:**
- 4pt: Minimum spacing (tight)
- 8pt: Default spacing
- 16pt: Comfortable spacing
- 24pt: Generous spacing
- 32pt: Section separation
- 48pt: Major group separation

**Why 8pt:**
- Divisible by 2 (easy halving: 4pt)
- Works with @2x and @3x displays
- Creates consistent rhythm
- Aligns with Apple's design system

```swift
VStack(spacing: 16) {  // 8pt grid
    HeaderView()
        .padding(.bottom, 8)
    ContentView()
        .padding(.horizontal, 16)
}
.padding(24)  // All multiples of 8
```

**Fibonacci for hierarchy:** 8, 13, 21, 34, 55pt (golden ratio spacing)
</grid_system>

<safe_areas>
## Safe Areas and Margins

**Respect safe areas:**
```swift
VStack {
    Content()
}
.padding(.horizontal, 16)  // Minimum margins
.safeAreaInset(edge: .bottom) {
    BottomBar()  // Respects home indicator
}
```

**Standard margins:**
- Phone (portrait): 16-20pt horizontal
- Phone (landscape): 32pt horizontal
- iPad: 20-40pt horizontal (larger screens = larger margins)

**Content width:**
- Readable text: 600-700pt maximum width (prevents long lines)
- Full bleed images: Edge to edge
- Cards: 16-24pt margins
</safe_areas>

<hierarchy>
## Spatial Hierarchy

<principle name="Proximity">
**Related items are close, unrelated items are far**

```swift
VStack(spacing: 0) {
    Text("Title")
    Text("Subtitle")
        .padding(.top, 4)  // Close (related)

    Divider()
        .padding(.vertical, 24)  // Far (separator)

    Text("New Section")
}
```

**Grouping:**
- 4-8pt: Tightly related (title + subtitle)
- 16pt: Related (list items)
- 24-32pt: Different sections
- 48pt+: Major boundaries
</principle>

<principle name="Size & Weight">
**Larger = more important**

```swift
VStack(alignment: .leading, spacing: 8) {
    Text("Primary Headline")
        .font(.largeTitle.weight(.semibold))  // Large + heavy

    Text("Supporting information")
        .font(.body)  // Smaller + regular

    Text("Metadata")
        .font(.footnote)  // Smallest
        .foregroundColor(.secondary)
}
```

**3 levels maximum per screen**
</principle>

<principle name="Depth & Elevation">
**Closer = more important, interactive**

```swift
CardView()
    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)  // Elevated
    .background(Color(.secondarySystemBackground))  // Lighter than background

ModalView()
    .shadow(color: .black.opacity(0.3), radius: 30, y: 15)  // Highest elevation
    .zIndex(100)  // Front-most
```

**Elevation levels:**
- Base: No shadow (background)
- Elevated: 5-10pt shadow (cards)
- Floating: 15-20pt shadow (modals, sheets)
- Overlay: 30pt+ shadow (popovers, alerts)
</principle>
</hierarchy>

<alignment>
## Alignment and Grid

<pattern name="Leading Alignment (Default)">
```swift
VStack(alignment: .leading) {
    Text("Title")
    Text("Longer subtitle text here")
}
```

**Use for:** Text-heavy content, lists, natural reading flow
</pattern>

<pattern name="Center Alignment">
```swift
VStack(alignment: .center) {
    Image(systemName: "star")
    Text("Centered content")
}
```

**Use for:** Empty states, onboarding, symmetric layouts
**Avoid for:** Long text (hard to read)
</pattern>

<pattern name="Trailing Alignment">
```swift
VStack(alignment: .trailing) {
    Text("Label")
    Text("$1,234.56")
        .monospacedDigit()
}
```

**Use for:** Numeric data, prices, aligned values
</pattern>

<pattern name="Grid Layouts">
```swift
LazyVGrid(columns: [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
], spacing: 16) {
    ForEach(items) { item in
        CardView(item)
    }
}
.padding(16)
```

**Spacing should match:**
- Column spacing = Row spacing (consistent grid)
- Typically 12-16pt for grids
</pattern>
</alignment>

<spacing_golden_ratio>
## Golden Ratio Spacing

**Fibonacci sequence:** 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89...

**In 8pt grid:** 8, 13, 21, 34, 55, 89pt

**Use for hierarchical spacing:**
```swift
VStack(spacing: 0) {
    MainTitle()
        .padding(.bottom, 34)  // Large gap

    SectionTitle()
        .padding(.bottom, 21)  // Medium gap

    BodyText()
        .padding(.bottom, 13)  // Small gap

    Caption()
        .padding(.bottom, 8)   // Minimal gap
}
```

**Creates natural, proportional rhythm**
</spacing_golden_ratio>

<touch_targets>
## Touch Target Sizes

**Minimum:** 44x44pt (Apple HIG)
**Recommended:** 48x48pt
**Premium:** 60x60pt+ for primary actions

```swift
Button("Action") {
    // Action
}
.frame(minWidth: 44, minHeight: 44)
.contentShape(Rectangle())  // Entire frame is tappable
```

**Spacing between targets:**
- Minimum: 8pt (prevents mis-taps)
- Comfortable: 16pt
- Generous: 24pt

**Things 3:** Uses 60x60pt for Magic Plus Button (easy to tap)
</touch_targets>

<cosmos_spacing>
## Cosmos.so Spacing Analysis

**Philosophy:** Maximum breathing room

**Characteristics:**
- 32pt minimum spacing between sections
- 48pt+ for major boundaries
- Single column layouts (no grid clutter)
- Content max-width: 600pt (centered)
- 40pt horizontal padding on larger screens
- Generous top/bottom padding: 60-80pt

**Result:** Calm, meditative, premium feel

**Lesson:** White space is design, not emptiness
</cosmos_spacing>

<anti_patterns>
## Layout Mistakes

<anti_pattern name="Inconsistent Spacing">
**Problem:** 12pt here, 18pt there, 7pt somewhere else

**Fix:** Stick to 8pt grid multiples
</anti_pattern>

<anti_pattern name="Too Tight">
**Problem:** Elements cramped together

**Fix:** Minimum 8pt between unrelated elements, 16pt preferred
</anti_pattern>

<anti_pattern name="Too Loose">
**Problem:** Elements feel disconnected

**Fix:** Related items should be close (4-8pt max)
</anti_pattern>

<anti_pattern name="Ignoring Safe Areas">
**Problem:** Content hidden by notch or home indicator

**Fix:** Always use .safeAreaInset() or respect .safeAreaPadding()
</anti_pattern>

<anti_pattern name="Tiny Touch Targets">
**Problem:** 20x20pt button is unusable

**Fix:** Minimum 44x44pt, expand with .contentShape() if needed
</anti_pattern>

<anti_pattern name="Center-Aligned Text Blocks">
**Problem:** Hard to read, eyes jump

**Fix:** Use leading alignment for text-heavy content
</anti_pattern>
</anti_patterns>

<sources>
Based on research from:
- [Principles of spatial design - WWDC23](https://developer.apple.com/videos/play/wwdc2023/10072/)
- [Spatial layout - Apple HIG](https://developer.apple.com/design/human-interface-guidelines/spatial-layout)
- [iOS Hard & Soft 8-point grids - B. Dalziel](https://medium.com/ios-os-x-development/ios-hard-soft-8-point-grids-6d2d1dc2fcf7)
- [iOS Design Guidelines - LearnUI](https://www.learnui.design/blog/ios-design-guidelines-templates.html)
</sources>
