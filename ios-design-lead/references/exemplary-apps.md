<overview>
These apps represent the pinnacle of iOS interface design. Study them not to copy, but to understand the thinking behind the craft. Each solves different problems but shares obsessive attention to detail.

**Selection criteria:** Design-first thinking, premium polish, influential patterns, worthy of aspiration.
</overview>

<app name="endel">
## Endel — Organic Minimalism

**What it is:** AI-powered soundscapes for focus, relaxation, sleep
**Why study it:** Masterclass in "designed to disappear" — UI that serves then gets out of the way

<philosophy>
**"Designed to NOT be used"**

Once you set your mode, the app wants you to forget it exists. This is the opposite of engagement-driven design. Endel respects your attention by not demanding it.

**Kandinsky meets Brian Eno:**
- Abstract, flowing visuals inspired by Wassily Kandinsky
- Generative, ever-changing — never loops, never stale
- Sound and visual are one system, not decoration
</philosophy>

<patterns>
### Visual Language

| Element | Execution |
|---------|-----------|
| Palette | Monochrome with subtle color shifts |
| Shapes | Organic, flowing, abstract blobs |
| Animation | Breathing, pulsing — never jarring |
| Motion | Slow, hypnotic, continuous |
| Transitions | Dissolve, morph — no hard cuts |

### Breathing Animations

The signature Endel motion: elements expand and contract like lungs.

```swift
// Breathing animation pattern
struct BreathingView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Circle()
            .fill(Color.primary.opacity(0.1))
            .scaleEffect(scale)
            .animation(
                .easeInOut(duration: 4)
                .repeatForever(autoreverses: true),
                value: scale
            )
            .onAppear { scale = 1.15 }
    }
}
```

**Timing:** 4-6 second cycles. Slow enough to feel calming, not anxious.

### Generative Visuals

Visuals respond to audio in real-time:
- Amplitude → shape size
- Frequency → color temperature
- Rhythm → motion speed

**Key insight:** The visual IS the interface. No buttons needed during use.

### Minimal Chrome

| State | UI Visibility |
|-------|---------------|
| Active session | Nearly invisible — just the visualization |
| Paused | Subtle controls fade in |
| Settings | Clean modal, then disappear |

**Pattern:** Progressive disclosure to the extreme. Show nothing until needed.
</patterns>

<lessons>
### What to Steal

1. **Breathing motion** for ambient/background states
2. **Monochrome + organic shapes** for meditative UIs
3. **"Set and forget" philosophy** for utility apps
4. **Slow transitions** (2-4s) for non-urgent state changes
5. **Generative visuals** that never feel static

### When to Apply

- Focus/meditation features
- Background audio players
- Ambient information displays
- Loading states that could feel alive
- Onboarding that calms rather than excites
</lessons>

<anti_patterns>
**Don't use Endel patterns for:**
- Task lists (users need to engage, not zone out)
- Forms/input (organic shapes fight structure)
- E-commerce (breathing animations feel too slow)
- Urgent notifications (calming ≠ alert)
</anti_patterns>
</app>

<app name="cron">
## Cron (Notion Calendar) — Keyboard-First Speed

**What it is:** Next-gen calendar for professionals
**Creator:** Raphael Schaad (ex-Flipboard, iA Writer)
**Why study it:** Masterclass in power-user UX without sacrificing beauty

<philosophy>
**"Design-first, speed-obsessed"**

Cron proves you don't have to choose between beautiful and fast. Every millisecond matters. Every click has a keyboard shortcut. Power users feel the difference.

**Superhuman's sibling:**
- Same obsession with speed
- Same keyboard-centric interaction
- Same "feel" of premium software
</philosophy>

<patterns>
### Keyboard-First Design

| Action | Pattern |
|--------|---------|
| Navigation | `J/K` or arrows to move between items |
| Quick actions | Single letter shortcuts (`N` for new, `D` for delete) |
| Command palette | `⌘K` opens everything |
| Mode switching | Shortcuts enter/exit modes (share availability) |

```swift
// Keyboard shortcut registration
.keyboardShortcut("n", modifiers: [])  // No modifier = power user speed
.keyboardShortcut("k", modifiers: .command)  // Command palette
```

**Key insight:** No modifier keys for frequent actions. `N` not `⌘N`.

### Contextual Sidebar

Click an event → sidebar slides in from right with all details.

```swift
// Sidebar pattern
HStack(spacing: 0) {
    // Main content
    CalendarGridView()

    // Contextual sidebar
    if let selectedEvent = selectedEvent {
        EventDetailSidebar(event: selectedEvent)
            .frame(width: 320)
            .transition(.move(edge: .trailing))
    }
}
.animation(.spring(duration: 0.3), value: selectedEvent)
```

**Benefits:**
- Context stays visible (no modal blocking view)
- Quick edits without navigation
- Feels like direct manipulation

### Menu Bar Presence

Always accessible, never intrusive:
- See next meeting at a glance
- One-click to join video call
- Counts down to next event

**Pattern:** Ambient awareness without demanding attention.

### Time Block Selection

Mode-based interaction for complex tasks:

1. Press shortcut → enter "share availability" mode
2. Click/drag time blocks
3. Auto-generates text
4. Exit mode

```swift
enum CalendarMode {
    case normal
    case shareAvailability
    case createEvent
}

// Mode changes interaction behavior
switch mode {
case .shareAvailability:
    // Clicks select time blocks
    // Drag creates ranges
    // Text auto-generates
}
```

### Little Delightful Things

| Micro-interaction | Implementation |
|-------------------|----------------|
| Hover on time | Shows exact time tooltip |
| Drag event edge | Precise duration adjustment |
| Multi-select events | Batch operations |
| Conflict highlight | Red glow on overlapping events |
| Timezone ribbon | Always visible, draggable |

**Philosophy:** Hundred tiny improvements > one big feature.
</patterns>

<lessons>
### What to Steal

1. **Keyboard shortcuts without modifiers** for power users
2. **Contextual sidebars** instead of modals for detail views
3. **Menu bar presence** for quick-access utilities
4. **Mode-based interaction** for complex multi-step tasks
5. **Micro-interactions everywhere** — hover, drag edges, tooltips

### When to Apply

- Professional/productivity tools
- Data-heavy interfaces
- Power-user apps
- Scheduling/time-based features
- Any app where speed = value
</lessons>

<anti_patterns>
**Don't use Cron patterns for:**
- Consumer apps (too much keyboard reliance)
- Mobile-first (keyboard shortcuts don't translate)
- Casual users (modes add learning curve)
- Simple utilities (overkill)
</anti_patterns>
</app>

<app name="things">
## Things 3 — Gesture Vocabulary

**What it is:** Premium task manager
**Creator:** Cultured Code (Germany)
**Why study it:** Masterclass in gesture-based interaction + haptic design

<philosophy>
**"Objects, not screens"**

Tasks are tangible things you manipulate. Drag them, check them, swipe them. The UI is a physics playground where objects have weight and behavior.
</philosophy>

<patterns>
### Magic Plus Button

The floating action button that does more:
- Tap → new task
- Drag up → new task in inbox
- Drag to list → new task in that list
- Long press → new project/heading

**Key insight:** One element, multiple gestures, contextual behavior.

### Swipe Vocabulary

| Gesture | Action | Haptic |
|---------|--------|--------|
| Swipe right (short) | Schedule for today | Light impact |
| Swipe right (long) | Schedule picker | Medium impact at threshold |
| Swipe left (short) | Move to evening | Light impact |
| Swipe left (long) | Move picker | Medium impact |
| Long press | Enter selection mode | Medium impact |
| Check task | Complete | Success notification |

### Drag to Reorder

```swift
.onDrag { /* Start dragging */ }
.onDrop { /* Reorder logic */ }

// Haptic on crossing items
.onChange(of: dragPosition) { _, new in
    if crossedItem(at: new) {
        HapticManager.selection()
    }
}
```

**Key insight:** Selection haptic for each item crossed while dragging.

### Pull to Create

Pull down beyond top → new task appears, ready to type.

```swift
ScrollView {
    GeometryReader { geo in
        if geo.frame(in: .global).minY > threshold {
            // Show new task field
            HapticManager.impact(.medium)
        }
    }
}
```
</patterns>

<lessons>
### What to Steal

1. **Multi-function gestures** on single elements
2. **Haptic vocabulary** — consistent feedback per action type
3. **Pull-to-create** for list-based apps
4. **Swipe thresholds** with haptic confirmation
5. **Drag-to-organize** with selection feedback
</lessons>
</app>

<app name="craft">
## Craft — Animation Craft

**What it is:** Modern document editor
**Why study it:** Masterclass in transition animations + state changes

<philosophy>
**"Every transition designed"**

No default animations. Every state change has custom timing, custom curves, custom choreography. Premium = considered motion.
</philosophy>

<patterns>
### Block Selection

Select text → block highlights with spring animation:

```swift
.background(
    RoundedRectangle(cornerRadius: 8)
        .fill(Color.accentColor.opacity(0.1))
        .scaleEffect(isSelected ? 1 : 0.95)
        .opacity(isSelected ? 1 : 0)
)
.animation(.spring(duration: 0.25, bounce: 0.2), value: isSelected)
```

### Staggered Reveals

Content appears with orchestrated timing:

```swift
ForEach(Array(items.enumerated()), id: \.1.id) { index, item in
    ItemView(item: item)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 20)
        .animation(
            .spring(duration: 0.4)
            .delay(Double(index) * 0.05),  // 50ms stagger
            value: appeared
        )
}
```

### Seamless Navigation

Push/pop feels custom:
- Content slides
- Backgrounds crossfade
- Elements morph between states

### Loading Skeletons

Shimmer effect while loading:

```swift
struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [.clear, .white.opacity(0.3), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 300
                }
            }
    }
}
```
</patterns>

<lessons>
### What to Steal

1. **Staggered reveals** for list/grid content
2. **Selection animations** with scale + opacity
3. **Custom navigation transitions**
4. **Shimmer loading states**
5. **Consistent timing** across all animations (0.25-0.4s springs)
</lessons>
</app>

<app name="cosmos">
## Cosmos.so — Extreme Minimalism

**What it is:** Visual bookmark/moodboard tool
**Why study it:** Masterclass in whitespace and restraint

<philosophy>
**"Ma (間) — negative space as design"**

The space between elements is as important as the elements themselves. Cosmos takes this to the extreme — generous padding, single-column layouts, content that breathes.
</philosophy>

<patterns>
### Generous Spacing

| Element | Margin |
|---------|--------|
| Between cards | 24-32pt |
| Section padding | 40pt+ |
| Screen edges | 20pt minimum |
| Text line height | 150%+ |

### Single Column

Even on iPad, content stays in a comfortable reading width:

```swift
ScrollView {
    LazyVStack(spacing: 24) {
        ForEach(items) { item in
            ItemCard(item: item)
        }
    }
    .frame(maxWidth: 600)  // Readable width
    .padding(.horizontal, 20)
}
```

### Navigation Hidden Until Needed

- No visible nav bar by default
- Scroll reveals minimal controls
- Gestures for everything
</patterns>

<lessons>
### What to Steal

1. **Extreme padding** — when in doubt, add more space
2. **Readable width constraints** even on large screens
3. **Hidden navigation** that reveals on interaction
4. **Visual calm** as a feature
</lessons>
</app>

<comparison>
## When to Reference Each App

| Need | Study |
|------|-------|
| Calm, ambient UI | Endel |
| Power-user speed | Cron |
| Gesture interactions | Things |
| Animation craft | Craft |
| Whitespace/minimalism | Cosmos |
| Haptic vocabulary | Things |
| Keyboard shortcuts | Cron |
| Generative/organic visuals | Endel |
| Document editing | Craft |
| List management | Things |
</comparison>

<sources>
- [Endel iOS UI/UX - 60fps.design](https://60fps.design/apps/endel)
- [Endel App - UI Sources](https://www.uisources.com/app/endel)
- [Cron App Evaluation - Eleken](https://www.eleken.co/blog-posts/cron-app-evaluation-by-ui-ux-designers)
- [Raphael Schaad](https://raphaelschaad.com/)
- [Endel - Apple Newsroom](https://www.apple.com/in/newsroom/2021/05/endel-app-creator-on-the-power-of-endless-ambient-music/)
</sources>
