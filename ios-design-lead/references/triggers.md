<triggers>
Activate Claude's built-in knowledge with these domain triggers:

<trigger domain="animations">
**SwiftUI Springs**

Use springs for all animations:
```swift
.spring(duration: 0.4, bounce: 0.2)  // Standard
.spring(duration: 0.3, bounce: 0.3)  // Bouncy
.spring(duration: 0.25, bounce: 0)   // Snappy
```

**Parameters:**
- `duration` — total animation time
- `bounce` — 0 = no overshoot, 0.5 = significant bounce

**Physics springs (advanced):**
```swift
.spring(response: 0.5, dampingFraction: 0.7)
```
- `response` — stiffness (lower = faster)
- `dampingFraction` — 0 = infinite bounce, 1 = no bounce
</trigger>

<trigger domain="gestures">
**Things App Patterns**

```swift
DragGesture()
    .updating($dragState) { value, state, _ in
        // Live feedback during drag
        state = value.translation
    }
    .onEnded { value in
        // Commit action
        if value.translation.width > threshold {
            // Action with haptic
            impactGenerator.impactOccurred()
        }
    }
```

Combine with springs + haptics at thresholds.
</trigger>

<trigger domain="layout">
**8pt Grid System**

Fibonacci spacing: 8, 13, 21, 34pt

```swift
.padding()           // 16pt default
.padding(.small)     // 8pt
.padding(.medium)    // 16pt
.padding(.large)     // 24pt
```

Use `.padding()` over explicit heights. GeometryReader sparingly.
</trigger>

<trigger domain="typography">
**Monochrome Hierarchy**

Weight + size + opacity (no color variety):
- **Headers:** Bold/Semibold, larger size
- **Body:** Regular weight
- **Secondary:** Lower opacity (0.6-0.7)
- **Tertiary:** Even lower opacity (0.4-0.5)

**Special treatments:**
- *Italics* for dynamic content (user input, variables)
- `Monospace` for tags (#topic), codes, IDs

**Size jumps:** 8-12pt between hierarchy levels
</trigger>

<trigger domain="sf_symbols">
**SF Symbols**

```swift
Image(systemName: "star.fill")
    .symbolRenderingMode(.hierarchical)  // Depth
    .font(.body.weight(.medium))         // Match text
    .symbolEffect(.bounce)               // Animation
```

Match symbol weight to surrounding text weight.
</trigger>

<trigger domain="architecture">
**MVVM Pattern**

```
View (SwiftUI)
  ↓ observes
ViewModel (@Observable)
  ↓ uses
Service (business logic)
  ↓ accesses
Model (SwiftData)
```

- Files under 300 lines
- @StateObject owned, @ObservedObject passed
- Feature-based folder organization
</trigger>

<trigger domain="voiceover">
**Accessibility**

```swift
.accessibilityLabel("Send message")     // What it is
.accessibilityHint("Double tap to send") // What happens
.accessibilityElement(children: .combine) // Group related
```

Never rely on haptics alone — always visual + auditory alternatives.
</trigger>

<trigger domain="macos-navigation">
**NavigationSplitView (macOS Standard)**

```swift
NavigationSplitView {
    Sidebar()
} content: {
    ContentList()
} detail: {
    DetailView()
}
.navigationSplitViewColumnWidth(min: 180, ideal: 220, max: 300)
```

Use for all macOS apps. Replaces iOS TabView/NavigationStack patterns.
Two-column or three-column layouts. Add `.inspector()` for right panels.
</trigger>

<trigger domain="keyboard-shortcuts">
**Keyboard Shortcuts (macOS)**

```swift
Button("New Item") { createItem() }
    .keyboardShortcut("n", modifiers: .command)

Button("Delete") { deleteItem() }
    .keyboardShortcut(.delete, modifiers: .command)

// Toggles with ⌘⇧
Button("Toggle Sidebar") { }
    .keyboardShortcut("s", modifiers: [.command, .shift])
```

**Standard (automatic):** ⌘C copy, ⌘V paste, ⌘Z undo, ⌘Q quit, ⌘W close, ⌘, settings

Every primary action needs a shortcut. Mac users expect keyboard-first UX.
</trigger>

<trigger domain="responsive-macos">
**Responsive Window Layouts**

```swift
// Adaptive grid (Notion-style)
LazyVGrid(columns: [
    GridItem(.adaptive(minimum: 200, maximum: 400))
]) {
    ForEach(items) { CardView(item: $0) }
}

// Collapsible sidebar
@State private var columnVisibility: NavigationSplitViewVisibility = .all

NavigationSplitView(columnVisibility: $columnVisibility) {
    Sidebar()
} detail: {
    Detail()
}
.navigationSplitViewColumnWidth(min: 180, ideal: 220, max: 300)

// Window constraints
.frame(minWidth: 700, minHeight: 500)
```

Test at: 700px, 1000px, 1400px widths. Nothing should break.
</trigger>

<trigger domain="macos-hover">
**Hover States (macOS)**

```swift
@State private var isHovered = false

Button { } label: {
    Text("Hover me")
        .background(isHovered ? Color.accentColor.opacity(0.1) : .clear)
}
.onHover { hovering in
    withAnimation(.spring(duration: 0.2)) {
        isHovered = hovering
    }
}
```

Hover is the macOS equivalent of iOS long-press reveal. Use for secondary info, quick actions.
</trigger>
</triggers>
