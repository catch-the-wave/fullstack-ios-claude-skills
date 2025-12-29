<overview>
Apple's Human Interface Guidelines (HIG) define the principles and patterns of iOS design. Three core principles: Clarity, Deference, and Depth. Follow HIG as a foundation, then transcend with your unique vision.
</overview>

<three_principles>
## The Three Pillars

<principle name="Clarity">
**Text is legible, icons are precise, adornments are subtle**

- Typography at every size is paramount
- Color doesn't overwhelm content
- Negative space creates clarity
- Content is king, interface is servant

**In practice:**
- Use system fonts (SF Pro)
- Semantic colors adapt to modes
- Generous spacing (8pt grid)
- Remove visual noise
</principle>

<principle name="Deference">
**Fluid motion and crisp interface help people understand and interact with content without competing with it**

- Full-screen experiences
- Subtle gradients and effects
- Interface recedes, content advances
- Translucency suggests context

**In practice:**
- Edge-to-edge content where appropriate
- Blurred backgrounds (materials)
- Content-first hierarchy
- Animation guides attention
</principle>

<principle name="Depth">
**Visual layers and realistic motion convey hierarchy and facilitate understanding**

- Shadows create elevation
- Motion follows physics
- Layers communicate relationships
- Depth aids navigation

**In practice:**
- Cards elevated above background
- Modals float above content
- Spring animations (natural motion)
- Z-axis as design dimension
</principle>
</three_principles>

<key_patterns>
## Essential iOS Patterns

<pattern name="Navigation">
**NavigationStack** (iOS 16+):
```swift
NavigationStack {
    List {
        NavigationLink("Detail") {
            DetailView()
        }
    }
    .navigationTitle("Items")
}
```

**Large Title** (default):
- Scrolls to inline on scroll
- Provides context at top
- Collapses to save space

**Tab Bar** (primary navigation):
- 3-5 tabs maximum
- Icons + labels
- Always visible
</pattern>

<pattern name="Modality">
**Sheets** (primary modal):
```swift
.sheet(isPresented: $showSheet) {
    SheetContent()
        .presentationDetents([.medium, .large])
}
```

**Full Screen Cover** (immersive):
```swift
.fullScreenCover(isPresented: $showCover) {
    CoverContent()
}
```

**Popover** (iPad, context):
```swift
.popover(isPresented: $showPopover) {
    PopoverContent()
}
```

**Alert** (decisions):
```swift
.alert("Title", isPresented: $showAlert) {
    Button("Cancel", role: .cancel) {}
    Button("Delete", role: .destructive) {}
}
```
</pattern>

<pattern name="Lists">
**Standard list:**
```swift
List {
    ForEach(items) { item in
        Text(item.name)
    }
}
.listStyle(.insetGrouped)  // iOS standard
```

**Swipe actions:**
```swift
.swipeActions {
    Button(role: .destructive) {
        delete()
    } label: {
        Label("Delete", systemImage: "trash")
    }
}
```
</pattern>

<pattern name="Forms">
```swift
Form {
    Section("Profile") {
        TextField("Name", text: $name)
        DatePicker("Birthday", selection: $birthday)
    }

    Section("Settings") {
        Toggle("Notifications", isOn: $notifications)
        Picker("Theme", selection: $theme) {
            Text("Light").tag(0)
            Text("Dark").tag(1)
        }
    }
}
```

**Automatic styling** based on context
</pattern>
</key_patterns>

<platform_conventions>
## iOS-Specific Conventions

**Navigation Bar:**
- Back button (automatic)
- Title (large or inline)
- Trailing buttons (1-2 max)

**Tab Bar:**
- Bottom of screen
- 3-5 tabs
- Selected state (filled icon)
- Badge for notifications

**Search:**
- `.searchable()` modifier
- Appears in navigation bar
- Dismissible

**Toolbars:**
- Bottom toolbar for primary actions
- Top toolbar for contextual actions

**Context Menus:**
```swift
.contextMenu {
    Button("Copy", action: copy)
    Button("Delete", role: .destructive, action: delete)
}
```

**Pull to Refresh:**
```swift
.refreshable {
    await loadData()
}
```
</platform_conventions>

<design_resources>
## Official Apple Resources

**HIG Website:**
- developer.apple.com/design/human-interface-guidelines/

**SF Symbols App:**
- Download from Apple Developer
- Browse all 5000+ symbols
- Preview in different weights/sizes

**Design Resources:**
- Apple Design Resources (Sketch, Figma templates)
- iOS UI Kit
- SF Pro fonts

**WWDC Sessions:**
- "Designing Fluid Interfaces" (2018)
- "Animate with springs" (2023)
- "Enhance your UI animations" (2024)
- "Principles of spatial design" (2023)
</design_resources>

<when_to_break_rules>
## Breaking HIG Intentionally

**HIG is a foundation, not a prison**

**When to follow strictly:**
- System interactions (navigation, modals)
- Accessibility features
- Platform conventions (tab bars, alerts)
- Expected behaviors

**When you can innovate:**
- Custom gestures (if discoverable)
- Unique animations (if purposeful)
- Brand expression (if not confusing)
- Advanced features (if progressive disclosure)

**Examples of intentional departure:**
- **Things 3:** Custom swipe gestures (but provides tutorials)
- **Craft.do:** Non-standard modal presentations (but familiar patterns)
- **Halide:** Pro camera UI (but respects iOS conventions elsewhere)

**Rule:** Earn the right to break rules by mastering them first
</when_to_break_rules>

<sources>
Based on research from:
- [Human Interface Guidelines - Apple](https://developer.apple.com/design/human-interface-guidelines/)
- [Implementing Apple's HIG with SwiftUI - Pavlos Simas](https://simaspavlos.medium.com/implementing-apples-human-interface-guidelines-hig-with-swiftui-64bdb8ceb2fc)
- [Mastering iOS Design - Kanvi Makwana](https://medium.com/design-bootcamp/mastering-ios-design-a-guide-to-apples-human-interface-guidelines-39b202ed102c)
</sources>
