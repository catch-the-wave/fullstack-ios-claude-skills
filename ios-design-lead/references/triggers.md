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
</triggers>
