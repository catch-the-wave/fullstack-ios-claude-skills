<macos_patterns>
<overview>
macOS design extends iOS principles but respects desktop conventions.
Same design DNA (Teenage Engineering + Braun + Fuller), different expressions.

**Primary use:** Companion apps sharing design language with iOS
**Awareness:** Mac-first patterns for when desktop-native is needed
</overview>

<pattern name="window-management">
**Window Configuration**

```swift
// Multi-window (default for most apps)
WindowGroup {
    ContentView()
}
.defaultSize(width: 900, height: 600)
.windowResizability(.contentMinSize)

// Single window (utilities, preferences)
Window("Settings", id: "settings") {
    SettingsView()
}
.windowStyle(.hiddenTitleBar)
.windowResizability(.contentSize)
```

**Key modifiers:**
- `.defaultSize(width:height:)` — initial window dimensions
- `.windowResizability(.contentSize | .contentMinSize | .automatic)`
- `.windowStyle(.hiddenTitleBar)` — custom chrome apps
- `.defaultPosition(.center)` — where window appears
</pattern>

<pattern name="navigation">
**Sidebar Navigation (Standard)**

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

**Patterns:**
- NavigationSplitView for all macOS apps (replaces iOS TabView)
- Two-column (sidebar + detail) or three-column (sidebar + content + detail)
- `.inspector()` for secondary panels (right side)
- No tab bars — use sidebar sections or toolbar segmented control
</pattern>

<pattern name="input">
**Desktop Input Conventions**

```swift
// Hover states
.onHover { isHovered in
    withAnimation(.spring(duration: 0.2)) {
        self.isHovered = isHovered
    }
}

// Right-click context menus
.contextMenu {
    Button("Edit") { }
    Button("Delete", role: .destructive) { }
}

// Keyboard shortcuts
Button("New Item") { createItem() }
    .keyboardShortcut("n", modifiers: .command)
```

**Standard shortcuts (automatic):**
- `⌘C` copy, `⌘V` paste, `⌘X` cut
- `⌘Z` undo, `⌘⇧Z` redo
- `⌘W` close window, `⌘Q` quit
- `⌘,` preferences/settings

**Click targets:** Mouse precision allows smaller targets than iOS 44pt minimum. 24-32pt is acceptable.
</pattern>

<pattern name="menus">
**Menu Bar Integration**

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("New Document") { }
                    .keyboardShortcut("n", modifiers: .command)
            }
            CommandMenu("View") {
                Button("Toggle Sidebar") { }
                    .keyboardShortcut("s", modifiers: [.command, .control])
            }
        }

        Settings {
            SettingsView()
        }
    }
}
```

**Standard menu structure:**
- App menu (About, Preferences, Quit)
- File (New, Open, Save, Close)
- Edit (Undo, Redo, Cut, Copy, Paste)
- View (app-specific view options)
- Window (Minimize, Zoom, window list)
- Help (searchable help items)
</pattern>

<pattern name="companion-app">
**Shared with iOS:**
- Same color system (reference: color-system.md)
- Same typography scale
- Same data models (SwiftData syncs via CloudKit)
- Same iconography (SF Symbols)
- Same design DNA (industrial minimalism)

**Different from iOS:**
| Aspect | iOS | macOS |
|--------|-----|-------|
| Navigation | Tab bars, sheets | Sidebars, windows |
| Input | Touch, gestures | Keyboard, mouse, hover |
| Density | One thing at a time | More info visible |
| Chrome | Minimal, hidden | Toolbars, title bars |
| Gestures | Swipe, pinch, long press | Right-click, drag, scroll |

**SwiftUI multiplatform tips:**
```swift
#if os(macOS)
    NavigationSplitView { ... }
#else
    TabView { ... }
#endif
```
</pattern>

<pattern name="responsive-layout" critical="true">
**macOS apps MUST handle window resizing gracefully.**

Reference apps: Notion, Spotify, Linear

**Sidebar behavior:**
```swift
@State private var columnVisibility: NavigationSplitViewVisibility = .all

NavigationSplitView(columnVisibility: $columnVisibility) {
    Sidebar()
} detail: {
    Detail()
}
.navigationSplitViewColumnWidth(min: 180, ideal: 220, max: 300)
```

**Content adaptation:**
```swift
// Adaptive grid (Notion-style cards)
LazyVGrid(columns: [
    GridItem(.adaptive(minimum: 200, maximum: 400))
]) {
    ForEach(items) { CardView(item: $0) }
}

// Size class detection
@Environment(\.horizontalSizeClass) var sizeClass

// Automatic layout selection
ViewThatFits {
    HorizontalLayout()
    VerticalLayout()
}
```

**Window constraints:**
```swift
.frame(minWidth: 700, minHeight: 500)
```

**Test at these widths:** 700px, 1000px, 1400px — nothing should break.

**Density transitions:**
- Narrow (700-900): Single column, stacked elements
- Medium (900-1200): Sidebar + content
- Wide (1200+): Sidebar + content + inspector

**Anti-patterns:**
- Fixed widths that clip content
- Layouts that break below 800px
- Sidebars that can't collapse
- Content that doesn't reflow
- Horizontal scroll for primary content
</pattern>

<pattern name="toolbar">
**Toolbar Configuration**

```swift
.toolbar {
    ToolbarItem(placement: .primaryAction) {
        Button(action: addItem) {
            Label("Add", systemImage: "plus")
        }
    }

    ToolbarItem(placement: .navigation) {
        Button(action: toggleSidebar) {
            Label("Sidebar", systemImage: "sidebar.left")
        }
    }
}
.toolbarRole(.editor)  // or .browser, .navigationStack
```

**Placements:**
- `.primaryAction` — main actions (right side)
- `.navigation` — back, sidebar toggle (left side)
- `.automatic` — system decides
</pattern>

<pattern name="mac-first-awareness">
**Know these exist (for when needed):**

**Document-based apps:**
```swift
DocumentGroup(newDocument: MyDocument()) { file in
    ContentView(document: file.$document)
}
```

**Menu bar utilities:**
```swift
MenuBarExtra("Status", systemImage: "star") {
    StatusMenu()
}
.menuBarExtraStyle(.window)
```

**Drag & drop:**
```swift
.draggable(item)
.dropDestination(for: Item.self) { items, location in
    // Handle drop
}
```

**Quick Look preview:**
```swift
.quickLookPreview($selectedURL)
```
</pattern>
</macos_patterns>
