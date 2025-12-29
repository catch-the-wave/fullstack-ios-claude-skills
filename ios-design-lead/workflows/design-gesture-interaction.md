# Workflow: Design Gesture-Based Interactions

<required_reading>
**Read these reference files NOW:**
1. references/gestures.md
2. references/haptics.md
3. references/animations.md
4. references/exemplary-apps.md (study Things 3 section)
</required_reading>

<process>
## Step 1: Define the Gesture Vocabulary

**Ask user:**
- What actions need gestures? (delete, archive, reorder, select)
- How often will users perform these? (frequent = gesture-worthy)
- Are they discoverable? (onboarding plan?)

**Standard iOS gestures:**
- Tap: Primary action
- Swipe: Secondary actions (left/right for different outcomes)
- Long press: Enter mode or context menu
- Drag: Reorder, move, dismiss
- Pinch: Zoom, scale

**Things 3 vocabulary for reference:**
- Swipe left: Select
- Swipe right: Schedule
- Drag: Reorder
- Long press: Multi-select mode

## Step 2: Design Visual Feedback

**Every gesture needs immediate visual response:**

**On gesture start:**
```swift
.scaleEffect(isPressed ? 0.98 : 1.0)
.opacity(isDragging ? 0.9 : 1.0)
```

**During gesture:**
- Follow finger (no lag)
- Show resistance at boundaries
- Preview outcome (trash icon fades in as swipe threshold approached)

**On gesture end:**
- Spring back with natural physics
- Confirmation animation
- State change visible

## Step 3: Implement Swipe Actions

**Standard iOS pattern:**
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
        .swipeActions(edge: .leading) {
            Button {
                HapticManager.impact(.light)
                archiveItem(item)
            } label: {
                Label("Archive", systemImage: "archivebox")
            }
            .tint(.blue)
        }
}
```

**Custom swipe (Things-style):**
```swift
@State private var offset: CGFloat = 0
@State private var hasTriggered = false

ItemView()
    .offset(x: offset)
    .gesture(
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                offset = value.translation.width

                // Haptic at threshold
                if !hasTriggered && offset > 100 {
                    HapticManager.impact(.medium)
                    hasTriggered = true
                }
            }
            .onEnded { value in
                withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                    if offset > 150 {
                        performAction()
                    } else {
                        offset = 0  // Snap back
                    }
                }
                hasTriggered = false
            }
    )
```

## Step 4: Implement Long Press → Drag

**Sequential gesture pattern:**
```swift
@State private var isInSelectionMode = false
@State private var dragOffset: CGSize = .zero

TaskView()
    .scaleEffect(isInSelectionMode ? 1.05 : 1.0)
    .shadow(radius: isInSelectionMode ? 20 : 0)
    .offset(dragOffset)
    .gesture(
        LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                HapticManager.impact(.medium)

                withAnimation(.spring(duration: 0.2, bounce: 0)) {
                    isInSelectionMode = true
                }
            }
            .sequenced(before: DragGesture())
            .onChanged { value in
                if case .second(let drag) = value {
                    dragOffset = drag?.translation ?? .zero
                }
            }
            .onEnded { _ in
                withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                    isInSelectionMode = false
                    dragOffset = .zero
                }
            }
    )
```

**Visual state change after long press** (shows drag is now possible)

## Step 5: Add Haptic Feedback

**Haptic vocabulary for gestures:**

| Gesture Moment | Haptic | When |
|----------------|--------|------|
| Gesture recognized | Light impact | Long press starts |
| Threshold crossed | Medium impact | Swipe crosses action threshold |
| Action confirmed | Medium/Heavy | Drop to reorder, delete confirmed |
| Crossing items | Selection changed | Dragging over reorder targets |
| Cancel | None | Snap back (silence = failure) |

```swift
.onChange(of: dragOffset) { old, new in
    if !hasTriggered && abs(new.width) > threshold {
        HapticManager.impact(.medium)
        hasTriggered = true
    }
}
```

## Step 6: Make Gestures Discoverable

**Problem:** Gestures are invisible

**Solution 1: Onboarding hints**
```swift
.overlay(alignment: .trailing) {
    if showHint {
        HStack {
            Image(systemName: "arrow.left")
            Text("Swipe to delete")
        }
        .padding(8)
        .background(.thinMaterial)
        .cornerRadius(8)
        .transition(.opacity.combined(with: .move(edge: .trailing)))
    }
}
.onAppear {
    if !UserDefaults.standard.bool(forKey: "hasSeenSwipeHint") {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation { showHint = true }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation { showHint = false }
                UserDefaults.standard.set(true, forKey: "hasSeenSwipeHint")
            }
        }
    }
}
```

**Solution 2: Visual affordances**
- Swipeable: Subtle chevron or grab handle (⋯)
- Draggable: Six-dot handle (⋮⋮)
- Long-press: Subtle pulsing glow

**Solution 3: Progressive disclosure**
- Day 1: Only basic taps
- Day 3: Show swipe hint
- Day 7: Show long-press hint

## Step 7: Provide Button Alternatives

**Accessibility requirement:** Gesture-only features fail Voice Control

```swift
// Gesture AND button
ItemRow(item)
    .swipeActions {
        // Swipe gesture
    }
    .contextMenu {
        // Long-press OR right-click alternative
        Button("Delete", role: .destructive) {
            deleteItem(item)
        }
    }
```

**Balance:** Gestures for speed, buttons for discoverability

## Step 8: Test on Device

**Critical:** Gestures feel different on device vs simulator

```bash
xcodebuild -scheme YourScheme -destination 'id=00008140-001220421AD0801C' -quiet build
```

**Test:**
- [ ] Gesture recognition is immediate
- [ ] Visual feedback follows finger (no lag)
- [ ] Haptics fire at right moments
- [ ] Thresholds feel natural
- [ ] Can be interrupted mid-gesture
- [ ] Doesn't conflict with system gestures
- [ ] Works with VoiceOver (button alternative)
- [ ] Feels smooth at 60fps+

## Step 9: Document Gesture Vocabulary

**Create gesture reference page:**

```swift
// In settings or help
GestureGuideView()
```

**Show:**
- Animated demonstration of each gesture
- Text description
- Interactive practice area

**Example:**
```
Swipe left → Delete
Swipe right → Archive
Long press → Select multiple
Drag → Reorder
```

</process>

<anti_patterns>
Avoid:
- No visual feedback (user doesn't know gesture was recognized)
- No haptic confirmation (feels disconnected)
- Too-small touch targets (<44pt)
- Conflicting gestures (tap on button in scrollview)
- Gesture-only features (provide button alternative)
- Non-standard gestures (triple-tap, diagonal swipe)
- No onboarding (users never discover gestures)
- Testing only in simulator (performance differs on device)
</anti_patterns>

<success_criteria>
Well-designed gesture interactions:
- Every gesture has visual + haptic feedback
- Thresholds feel natural (100-150pt for swipe actions)
- Works at 60fps+ on device
- Discoverable through hints or affordances
- Has button alternative for accessibility
- Consistent vocabulary throughout app
- Can be interrupted mid-gesture
- Respects platform conventions (no conflicts)
- Feels immediate and responsive
- Things 3-level polish and fluidity
</success_criteria>
