<overview>
Microinteractions are the tiny moments that make interfaces feel alive and premium. A button press that scales down, a checkmark that bounces in, a card that lifts on touch - these details transform functional into delightful. 200-400ms is optimal timing.
</overview>

<what_are_microinteractions>
## The Four Parts of Microinteractions

<part name="Trigger">
**What initiates the microinteraction**

- User action (tap, swipe, long press)
- System event (notification, timer)
- Automatic (entering view, loading complete)

**Example:** User taps "Complete" button
</part>

<part name="Rules">
**What happens once triggered**

- Animation plays
- State changes
- Feedback given

**Example:** Checkmark appears, button scales
</part>

<part name="Feedback">
**How user knows it worked**

- Visual (animation, color change)
- Haptic (vibration)
- Audio (sound effect)

**Example:** Spring animation + success haptic
</part>

<part name="Loops & Modes">
**What happens over time**

- Does it repeat?
- Does it vary on subsequent triggers?
- Can it be interrupted?

**Example:** First completion shows tutorial, subsequent completions just animate
</part>
</what_are_microinteractions>

<premium_microinteractions>
## Essential Premium Microinteractions

<interaction name="Button Press">
**Feel:** Immediate, responsive, tactile

```swift
@State private var isPressed = false

Button(action: { performAction() }) {
    Label("Action", systemImage: "star")
        .scaleEffect(isPressed ? 0.95 : 1.0)
}
.buttonStyle(PlainButtonStyle())
.onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
    withAnimation(.spring(duration: 0.1, bounce: 0)) {
        isPressed = pressing
    }

    if pressing {
        HapticManager.impact(.light)
    }
}, perform: {})
```

**Key details:**
- Scale to 0.95 (subtle compression)
- 0.1s animation (instant feedback)
- Light haptic on press
- Spring animation (natural feel)
</interaction>

<interaction name="Toggle State">
**Feel:** Satisfying confirmation

```swift
@State private var isOn = false

Toggle("Feature", isOn: $isOn)
    .onChange(of: isOn) { oldValue, newValue in
        HapticManager.impact(.medium)

        // Subtle celebration on enable
        if newValue {
            withAnimation(.spring(duration: 0.3, bounce: 0.3)) {
                // Optional: Scale or color flash
            }
        }
    }
```

**Enhancements:**
- Different haptic for on vs. off (medium vs. light)
- Slight bounce when turning on (0.3)
- Color transition with spring curve
</interaction>

<interaction name="Task Completion">
**Feel:** Celebratory, rewarding

```swift
@State private var isCompleted = false

HStack {
    Circle()
        .fill(isCompleted ? Color.green : Color.gray.opacity(0.3))
        .frame(width: 24, height: 24)
        .overlay {
            if isCompleted {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .transition(.scale.combined(with: .opacity))
            }
        }
    Text("Task")
        .strikethrough(isCompleted)
}
.onTapGesture {
    HapticManager.notification(.success)

    withAnimation(.spring(duration: 0.6, bounce: 0.4)) {
        isCompleted.toggle()
    }
}
```

**Key details:**
- Success haptic (distinctive pattern)
- 0.6s animation (longer for celebration)
- 0.4 bounce (playful joy)
- Checkmark scales in (0 → 1.0)
- Strikethrough animates across
</interaction>

<interaction name="Card Lift on Touch">
**Feel:** Tangible, object-like

```swift
@State private var isPressed = false

CardView()
    .scaleEffect(isPressed ? 1.05 : 1.0)
    .shadow(
        color: .black.opacity(isPressed ? 0.2 : 0.1),
        radius: isPressed ? 20 : 10,
        y: isPressed ? 10 : 5
    )
    .animation(.spring(duration: 0.3, bounce: 0), value: isPressed)
    .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
        isPressed = pressing
        if pressing {
            HapticManager.impact(.light)
        }
    }, perform: {})
```

**Key details:**
- Scale up 1.05 (subtle lift)
- Shadow expands (depth cue)
- 0.3s spring (smooth)
- Light haptic (tactile confirmation)
</interaction>

<interaction name="Pull to Refresh">
**Feel:** Elastic, physics-based

```swift
ScrollView {
    // Content
}
.refreshable {
    await loadData()
}
```

**System handles:**
- Elastic resistance
- Spinner appearance
- Release animation
- Completion feedback

**Don't override** unless you have a specific branded experience
</interaction>

<interaction name="Swipe to Delete">
**Feel:** Destructive but confirmable

```swift
ForEach(items) { item in
    ItemRow(item)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                HapticManager.impact(.medium)
                deleteItem(item)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
}
```

**Key details:**
- Full swipe deletes immediately (confident users)
- Partial swipe shows button (careful users)
- Red color signals danger
- Medium haptic on delete
- Trash icon clarifies action
</interaction>

<interaction name="Loading State">
**Feel:** Progress, not waiting

```swift
@State private var isLoading = false

Group {
    if isLoading {
        ProgressView()
            .scaleEffect(1.2)
            .transition(.opacity.combined(with: .scale(scale: 0.8)))
    } else {
        ContentView()
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
    }
}
.animation(.spring(duration: 0.4, bounce: 0), value: isLoading)
```

**Premium alternative:** Skeleton screens
```swift
if isLoading {
    SkeletonView() // Shows structure while loading
} else {
    ContentView()
}
```

**Avoid:** Spinners unless absolutely necessary
</interaction>

<interaction name="Empty State">
**Feel:** Helpful, not broken

```swift
if items.isEmpty {
    VStack(spacing: 16) {
        Image(systemName: "tray")
            .font(.system(size: 48))
            .foregroundColor(.secondary)

        Text("No Items Yet")
            .font(.headline)

        Text("Tap + to add your first item")
            .font(.subheadline)
            .foregroundColor(.secondary)

        Button("Add Item") {
            showAddSheet = true
        }
        .buttonStyle(.borderedProminent)
    }
    .transition(.opacity.combined(with: .scale(scale: 0.9)))
}
```

**Key details:**
- Helpful message (not just "Empty")
- Clear action (how to add first item)
- Illustration/icon (visual interest)
- Smooth transition in (not jarring)
</interaction>
</premium_microinteractions>

<timing_guidelines>
## Optimal Microinteraction Timing

**Research-backed durations:**

| Interaction | Duration | Reason |
|-------------|----------|--------|
| Button press | 100-150ms | Instant feedback |
| State toggle | 200-300ms | Notice but don't wait |
| Completion | 400-600ms | Celebrate moment |
| Page transition | 300-400ms | Smooth, not slow |
| Tooltip appear | 200ms | Quick but visible |
| Loading indicator | 400ms+ delay | Don't flash for fast loads |

**General rule:** 200-400ms is optimal for most microinteractions

**Too fast (<100ms):** Barely noticeable, feels glitchy
**Too slow (>600ms):** Feels laggy, frustrating
</timing_guidelines>

<craft_microinteractions>
## Craft.do Microinteraction Study

**Signature details:**
1. **Block insertion:** Scales up from 0.95 → 1.0 (appears to land)
2. **Drag handles:** Fade in on hover (progressive disclosure)
3. **Text selection:** Subtle highlight expansion
4. **Modal presentation:** Scales up from 0.98 with backdrop fade
5. **Image upload:** Progress ring + preview thumbnail appearing

**Consistency:** All use 0.6s duration, 0.2 bounce
**Philosophy:** Motion as personality, not decoration
</craft_microinteractions>

<anti_patterns>
## Microinteraction Mistakes

<anti_pattern name="Animation Everything">
**Problem:** Constant motion is exhausting

**Fix:** Only animate user-triggered actions and significant state changes
</anti_pattern>

<anti_pattern name="No Feedback">
**Problem:** User unsure if action registered

**Fix:** Every interaction needs feedback (visual + haptic minimum)
</anti_pattern>

<anti_pattern name="Inconsistent Timing">
**Problem:** Button 1 is 0.2s, button 2 is 0.5s

**Fix:** Pick one duration (0.3s recommended) and use everywhere
</anti_pattern>

<anti_pattern name="Over-The-Top Celebrations">
**Problem:** Confetti explosion for simple tap

**Fix:** Match celebration to significance of action
- Simple action: Light haptic + subtle scale
- Important action: Medium haptic + bounce
- Major achievement: Success haptic + celebration animation
</anti_pattern>

<anti_pattern name="Blocking Microinteractions">
**Problem:** Must wait for animation to complete

**Fix:** Animations should be interruptible and non-blocking
</anti_pattern>
</anti_patterns>

<sources>
Based on research from:
- [Microinteractions: The Tiny UX Details - Daria Zaytseva](https://medium.com/@dariazaytseva07/microinteractions-the-tiny-ux-details-that-make-a-big-impact-2cfa07cb8c59)
- [Animated Microinteractions in Mobile Apps - Smashing Magazine](https://www.smashingmagazine.com/2016/08/experience-design-essentials-animated-microinteractions-in-mobile-apps/)
- [The Role of Micro-interactions in Modern UX - IxDF](https://www.interaction-design.org/literature/article/micro-interactions-ux)
</sources>
