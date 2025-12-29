<overview>
Gestures are the primary interaction language of iOS. Touch is intimate - fingers directly manipulate objects. Design gesture-first interfaces where actions flow from natural hand movements. SwiftUI provides five core gestures, with iOS 18+ adding UIKit gesture integration.
</overview>

<gesture_philosophy>
## Gestures Over Buttons

**Things 3's mastery:**
- Swipe left: Select task (boundaries materialize)
- Swipe right: Schedule task (calendar appears)
- Drag anywhere: Reorder (object follows finger)
- Long press + drag: Multi-select and move
- Tap: Complete (satisfying check)

**Why gestures win:**
- Faster than hunting for buttons
- Muscle memory develops quickly
- Interface stays clean (no button clutter)
- Feels direct, not mediated

**When to use buttons instead:**
- Primary discoverability (first-time users)
- Accessibility (VoiceOver users)
- Destructive actions (need confirmation)
- Cross-platform consistency required
</gesture_philosophy>

<swiftui_gestures>
## The Five Core Gestures

<gesture name="TapGesture">
**Use for:** Selection, activation, toggle

```swift
// Simple tap
Text("Tap me")
    .onTapGesture {
        isSelected.toggle()
    }

// Double tap
Image("photo")
    .onTapGesture(count: 2) {
        isLiked.toggle()
    }
```

**Design guidelines:**
- Minimum target: 44x44pt (Apple HIG)
- Recommended: 48x48pt or larger
- Visual feedback: Scale down to 0.95 on press
- Haptic: Light impact on tap

**Common pattern:**
```swift
Button(action: { /* action */ }) {
    Label("Action", systemImage: "star")
        .frame(minWidth: 44, minHeight: 44)
}
.buttonStyle(ScaleButtonStyle()) // Custom press effect
```
</gesture>

<gesture name="LongPressGesture">
**Use for:** Context menus, drag initiation, secondary actions

```swift
Circle()
    .gesture(
        LongPressGesture(minimumDuration: 0.5)
            .onEnded { _ in
                showContextMenu = true
                // Haptic: Medium impact
            }
    )
```

**Timing guidelines:**
- **0.3s:** Too short (accidental triggers)
- **0.5s:** Goldilocks (standard iOS)
- **0.7s+:** Too long (feels unresponsive)

**Must include:**
- Visual feedback during press (slight scale or glow)
- Haptic at trigger point (medium impact)
- Cancel if finger moves too far (>10pt threshold)

**Things 3 pattern:**
```swift
.gesture(
    LongPressGesture(minimumDuration: 0.5)
        .onChanged { _ in
            // Start visual feedback
            withAnimation(.spring(duration: 0.2, bounce: 0)) {
                scale = 0.98
            }
        }
        .onEnded { _ in
            HapticManager.impact(.medium)
            enterSelectionMode = true
        }
)
```
</gesture>

<gesture name="DragGesture">
**Use for:** Reordering, dismissing, panning, custom interactions

```swift
@State private var offset: CGSize = .zero

Rectangle()
    .offset(offset)
    .gesture(
        DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { value in
                withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                    if abs(offset.width) > 100 {
                        // Dismiss
                        dismissCard()
                    } else {
                        // Snap back
                        offset = .zero
                    }
                }
            }
    )
```

**Design patterns:**

**Swipe to dismiss:**
- Threshold: 30-50% of width or >100pt
- Velocity matters: Fast swipe = lower threshold
- Snap back with spring animation
- Haptic: Light impact when threshold crossed

**Drag to reorder:**
- Visual lift: Scale up 1.05, add shadow
- Other items shift with spring animation
- Haptic: Selection changed when crossing items
- Drop with satisfying bounce (0.3)

**Pull to refresh:**
- Resistance: Slows down as pulled further
- Threshold: ~80-100pt
- Spinner appears gradually
- Haptic: Medium impact at trigger point
</gesture>

<gesture name="MagnificationGesture">
**Use for:** Zoom, scale adjustments

```swift
@State private var scale: CGFloat = 1.0
@State private var lastScale: CGFloat = 1.0

Image("photo")
    .scaleEffect(scale)
    .gesture(
        MagnificationGesture()
            .onChanged { value in
                scale = lastScale * value
            }
            .onEnded { value in
                lastScale = scale

                // Snap to limits
                withAnimation(.spring(duration: 0.3, bounce: 0)) {
                    scale = min(max(scale, 0.5), 3.0)
                }
            }
    )
```

**Constraints:**
- Min scale: 0.5x (don't allow negative)
- Max scale: 3-5x (performance degrades beyond)
- Snap to 1.0 if close (within 0.95-1.05)
- Double-tap to reset to 1.0

**No haptic needed** (pinch is its own feedback)
</gesture>

<gesture name="RotationGesture">
**Use for:** Rotation, orientation adjustments

```swift
@State private var rotation: Angle = .zero

Image("photo")
    .rotationEffect(rotation)
    .gesture(
        RotationGesture()
            .onChanged { angle in
                rotation = angle
            }
            .onEnded { angle in
                // Snap to 90° increments if close
                withAnimation(.spring(duration: 0.3, bounce: 0)) {
                    rotation = snapToIncrement(angle, increment: 90)
                }
            }
    )
```

**Snapping behavior:**
- Snap to 0°, 90°, 180°, 270° if within 10° of increment
- Helpful for layout tools
- Haptic: Selection changed at snap points

**Rarely used** - Consider if rotation actually adds value
</gesture>
</swiftui_gestures>

<advanced_patterns>
## Combining Gestures

<pattern name="Simultaneous Gestures">
**Use case:** Pinch to zoom while panning

```swift
.gesture(
    MagnificationGesture()
        .simultaneously(with: DragGesture())
)
```

**Examples:**
- Maps: Pan + pinch simultaneously
- Photo viewers: Zoom while adjusting position
- Drawing apps: Rotate canvas while drawing

**UX consideration:** Ensure gestures don't conflict
</pattern>

<pattern name="Sequential Gestures">
**Use case:** Long press, then drag

```swift
.gesture(
    LongPressGesture(minimumDuration: 0.5)
        .sequenced(before: DragGesture())
        .onEnded { value in
            switch value {
            case .second(let drag):
                // Long press succeeded, drag ended
                handleDragEnd(drag)
            default:
                break
            }
        }
)
```

**Things 3 pattern:**
1. Long press activates selection mode
2. Drag moves selected tasks
3. Release completes move

**Key:** Visual state change after long press (shows drag is possible)
</pattern>

<pattern name="High Priority Gesture">
**Use case:** Override child gesture with parent

```swift
ScrollView {
    ForEach(items) { item in
        ItemView(item)
            .onTapGesture { /* item tap */ }
    }
}
.highPriorityGesture(
    DragGesture()
        .onChanged { /* scroll */ }
)
```

**When to use:**
- Parent scroll should win over child taps
- Custom swipe actions override default behaviors
- Explicit override needed for gesture conflicts
</pattern>

<pattern name="UIKit Gesture Integration (iOS 18+)">
**New in iOS 18:** Direct UIKit gesture use

```swift
struct SwipeGestureView: View {
    var body: some View {
        Rectangle()
            .gesture(UISwipeGestureRecognizerRepresentable {
                print("Swiped!")
            })
    }
}
```

**When to use:**
- Need UIKit-specific gestures (3D Touch, swipe directions)
- Migrating from UIKit
- Gesture conflict resolution

**Prefer SwiftUI gestures** when possible (more declarative)
</pattern>
</advanced_patterns>

<gesture_feedback>
## Essential Feedback for Gestures

**Every gesture needs confirmation:**

<feedback type="Visual">
**On gesture start:**
- Scale: 0.95-0.98 (pressed state)
- Opacity: 0.7-0.9 (deactivating)
- Highlight: Add subtle glow/border

**During gesture:**
- Follow finger position (no lag)
- Show resistance at boundaries
- Preview outcome (e.g., delete icon fades in)

**On gesture end:**
- Spring back to rest (0.3s, bounce 0.2)
- Completion animation (scale up 1.05 → 1.0)
- State change visible immediately
</feedback>

<feedback type="Haptic">
**Start:** Light impact (gesture recognized)
**Progress:** Selection changed (crossing thresholds)
**End:** Medium impact (action confirmed)
**Cancel:** No haptic (silence = failure feedback)

**Example: Swipe to archive**
```swift
.onChange(of: dragOffset) { oldValue, newValue in
    if !hasTriggered && abs(newValue.width) > threshold {
        HapticManager.impact(.medium)
        hasTriggered = true
    }
}
```
</feedback>

<feedback type="Audio (Optional)">
**Use sparingly:**
- Completion sounds (success chime)
- Error sounds (gentle negative feedback)
- Respects silent mode

**Things 3:** No audio (clean, minimal)
**Craft.do:** Subtle whoosh on transitions
**Choice is intentional** - audio adds personality
</feedback>
</gesture_feedback>

<discoverability>
## Making Gestures Discoverable

**Problem:** Gestures are invisible - users must learn them

<solution name="Onboarding Hints">
**First launch:**
- Animated hint showing swipe direction
- Tooltip: "Swipe to archive"
- Fade after 3 seconds or first use

**Implementation:**
```swift
.overlay(alignment: .trailing) {
    if showHint {
        HintView("Swipe left to delete")
            .transition(.opacity.combined(with: .move(edge: .trailing)))
    }
}
.onAppear {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        withAnimation { showHint = true }
    }
}
```
</solution>

<solution name="Progressive Disclosure">
**Start simple:**
- Launch: Only tap gestures
- After usage: Reveal swipe hints
- Advanced: Show long-press options

**Things 3 approach:**
- Day 1: Tap to complete
- Day 3: "Try swiping tasks" hint
- Day 7: Long-press multi-select hint
</solution>

<solution name="Visual Affordances">
**Show possibility without showing gesture:**
- Swipeable: Subtle chevron or grab handle
- Draggable: Six-dot handle (⋮⋮)
- Long-press: Subtle pulsing glow

**Don't rely on affordances alone** - Combine with hints
</solution>

<solution name="Settings Documentation">
**Gesture reference page:**
- List all gestures with animations
- Searchable
- Accessible from ? button

**Example structure:**
- "Gestures" settings page
- Each gesture = Name + Animation + Description
- Try it live (interactive examples)
</solution>
</discoverability>

<things_analysis>
## Things 3 Gesture Vocabulary

**Complete mastery of gesture-first design:**

| Gesture | Action | Feedback |
|---------|--------|----------|
| Tap | Complete task | Checkmark animation + haptic |
| Swipe left | Select task | Boundaries appear |
| Swipe right | Schedule | Calendar picker slides in |
| Long press | Enter selection mode | Items start wiggling |
| Drag (in list) | Reorder | Shadow appears, items shift |
| Drag Magic + | Insert at position | + follows finger, preview where item goes |

**What makes it work:**
1. **Consistent physics** - Everything uses same spring timing
2. **Visual feedback** - Boundaries, shadows, highlights show state
3. **Haptic vocabulary** - Each action has signature feel
4. **Forgiving thresholds** - Works even with imprecise gestures
5. **Discoverable** - Hints appear contextually

**Key insight:** Objects feel physical. Tasks have weight, edges, momentum.
</things_analysis>

<anti_patterns>
## Gesture Design Mistakes

<anti_pattern name="No Visual Feedback">
**Problem:** User doesn't know gesture was recognized

**Bad:**
```swift
.onTapGesture {
    performAction()
}
```

**Good:**
```swift
.onTapGesture {
    withAnimation(.spring(duration: 0.15, bounce: 0)) {
        isPressed = true
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        withAnimation {
            isPressed = false
            performAction()
        }
    }
}
```
</anti_pattern>

<anti_pattern name="Conflicting Gestures">
**Problem:** Tap on button inside scrollview - which wins?

**Solution:** Use `.highPriorityGesture()` or `.simultaneousGesture()` explicitly

**Test:** Ensure all gesture combinations work as expected
</anti_pattern>

<anti_pattern name="Too Small Touch Targets">
**Problem:** 20x20pt button is unusable

**Minimum:** 44x44pt (Apple HIG)
**Recommended:** 48x48pt or larger
**Premium:** 60x60pt+ for primary actions

**Fix:**
```swift
.frame(minWidth: 44, minHeight: 44)
.contentShape(Rectangle()) // Entire frame is tappable
```
</anti_pattern>

<anti_pattern name="No Haptic Feedback">
**Problem:** Gesture feels disconnected

**Every gesture needs haptic:**
- Tap: Light impact
- Long press trigger: Medium impact
- Threshold crossed: Medium impact
- Completion: Selection changed or notification

**Silence = failure** (no haptic when canceling)
</anti_pattern>

<anti_pattern name="Gesture Fatigue">
**Problem:** Everything requires gesture, even simple actions

**Balance:**
- Primary actions: Tap (button or direct)
- Secondary actions: Swipe or long-press
- Advanced actions: Gesture combinations

**Don't force gestures** where buttons are clearer
</anti_pattern>
</anti_patterns>

<performance>
## Gesture Performance

**Must be 60fps minimum (120fps on ProMotion)**

**Optimize:**
- Update only changed properties
- Use `.onChange()` instead of body re-evaluation
- Throttle updates for expensive operations
- Profile with Instruments

**Example: Smooth drag**
```swift
.gesture(
    DragGesture(minimumDistance: 0)
        .onChanged { value in
            // Update immediately (60fps)
            offset = value.translation
        }
)
```

**If laggy:** Simplify visual effects or use UIKit gesture recognizers
</performance>

<sources>
Based on research from:
- [Customizing Gestures in SwiftUI - Fatbobman](https://fatbobman.com/en/posts/swiftuigesture/)
- [SwiftUI Simultaneous Gesture Recognition - DhiWise](https://www.dhiwise.com/blog/design-converter/effective-swiftui-simultaneous-gesture-recognition)
- [UIGestureRecognizerRepresentable - WWDC24](https://swiftwithmajid.com/2024/12/17/introducing-uigesturerecognizerrepresentable-protocol-in-swiftui/)
- [Things 3 Gestures - Cultured Code](https://culturedcode.com/things/support/articles/2803582/)
- [Composing SwiftUI gestures - Apple](https://developer.apple.com/documentation/swiftui/composing-swiftui-gestures)
</sources>
