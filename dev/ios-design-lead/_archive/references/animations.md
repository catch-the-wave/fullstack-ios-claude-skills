<overview>
iOS animations should feel alive, physics-based, and natural. Spring curves are the default - they create fluid motion that respects momentum and feels organic. Linear easing curves feel mechanical. Timing precision creates premium feel.
</overview>

<fundamental_principle>
## Springs, Not Easing Curves

**Why springs win:**
- Springs maintain continuity with initial velocity (natural deceleration)
- Springs can be interrupted mid-animation smoothly
- Springs feel organic (real-world physics)
- Springs are the iOS 17+ system default

**When to use linear/easing:**
- Never for UI animations (always use springs)
- Only for loading indicators or progress bars

**Apple's recommendation:** Spring animations for all interactive UI.
</fundamental_principle>

<spring_parameters>
## Understanding Spring Physics

<parameter name="Duration">
**What it controls:** Total animation time from start to rest

**Common values:**
- `0.3s` - Standard iOS animation duration (most common)
- `0.6s` - Slower, more dramatic (Craft.do uses this)
- `0.15s` - Quick feedback (micro-interactions)

**Rule:** Consistency matters more than exact duration. Pick one (0.3s recommended) and use it everywhere.
</parameter>

<parameter name="Bounce (Extra Bounce)">
**What it controls:** How much overshoot/bounce before settling

**Common values:**
- `0.0` - No bounce (smooth deceleration, feels elegant)
- `0.2` - Subtle bounce (playful but not distracting)
- `0.4` - Noticeable bounce (fun, youthful)
- `0.6+` - Heavy bounce (use sparingly, for celebration moments)

**For premium feel:** 0.0-0.2 range. Cosmos.so uses 0.0.
</parameter>

<parameter name="Damping Ratio">
**What it controls:** How quickly oscillation decreases

**Common values:**
- `0.7-0.8` - Underdamped (slight bounce)
- `1.0` - Critically damped (no bounce, fastest to rest)
- `>1.0` - Overdamped (slow approach to rest)

**For smooth motion:** Use 0.8 or critically damped (1.0)
</parameter>

<parameter name="Response (Stiffness)">
**What it controls:** How quickly spring responds (stiffness)

**Common values:**
- `0.15-0.3` - Quick response (snappy feel)
- `0.5-0.7` - Medium response (balanced)
- `1.0+` - Slow response (gradual, gentle)

**For fluid interfaces:** 0.3-0.5 range
</parameter>
</spring_parameters>

<swiftui_implementation>
## SwiftUI Spring Animations

<approach name="Modern Spring API (iOS 17+)">
**Recommended:** Use `.spring(duration:bounce:)`

```swift
// Standard iOS animation (elegant, no bounce)
.animation(.spring(duration: 0.3, bounce: 0), value: isExpanded)

// Craft.do style (smooth, slightly dramatic)
.animation(.spring(duration: 0.6, bounce: 0.2), value: isExpanded)

// Quick micro-interaction
.animation(.spring(duration: 0.15, bounce: 0), value: isSelected)

// Playful celebration
.animation(.spring(duration: 0.5, bounce: 0.4), value: isCompleted)
```

**When to use:**
- iOS 17+ minimum deployment target
- Perceptual, designer-friendly parameters
- Clearest mental model
</approach>

<approach name="Response-Damping API">
**Alternative:** Use `.spring(response:dampingFraction:)`

```swift
// Smooth, no bounce
.animation(.spring(response: 0.3, dampingFraction: 1.0), value: isExpanded)

// Subtle bounce
.animation(.spring(response: 0.3, dampingFraction: 0.8), value: isExpanded)

// Quick, snappy
.animation(.spring(response: 0.2, dampingFraction: 0.9), value: isExpanded)
```

**When to use:**
- Need iOS 16 or earlier support
- Want precise control over damping
- Converting from UIKit spring animations
</approach>

<approach name="Named Spring Presets">
**Quick presets:** SwiftUI provides pre-made curves

```swift
// System presets (iOS 17+)
.animation(.smooth, value: isExpanded)      // General smooth motion
.animation(.snappy, value: isExpanded)      // Quick, responsive
.animation(.bouncy, value: isExpanded)      // Playful bounce

// Legacy presets
.animation(.spring(), value: isExpanded)    // Default spring
.animation(.interactiveSpring(), value: isExpanded) // Gesture-driven
```

**When to use:**
- Rapid prototyping
- Don't need precise control
- Following system conventions

**For premium apps:** Use explicit parameters instead (shows intentionality)
</approach>
</swiftui_implementation>

<timing_precision>
## The Art of Timing

<principle name="Consistency Creates Polish">
**Rule:** All UI transitions use same base duration

**Recommended system:**
- **Primary duration:** 0.3s (all UI transitions)
- **Quick feedback:** 0.15s (selection, hover states)
- **Dramatic moments:** 0.6s (major state changes, celebrations)

**Things 3's timing:**
- Task completion: 0.3s
- Task reveal: 0.3s
- Swipe gestures: 0.3s
- Consistent = professional
</principle>

<principle name="Sequential Animations">
**Staggered reveals:** When animating multiple elements

```swift
ForEach(items.indices, id: \.self) { index in
    ItemView(items[index])
        .transition(.opacity.combined(with: .scale))
        .animation(
            .spring(duration: 0.3, bounce: 0)
                .delay(Double(index) * 0.05),
            value: isVisible
        )
}
```

**Delay values:**
- **0.05s per item:** Rapid cascade (feels lively)
- **0.1s per item:** Noticeable sequence (deliberate)
- **0.15s+ per item:** Too slow (feels broken)

**Maximum items:** Limit to 10-12 items (otherwise feels sluggish)
</principle>

<principle name="Duration by Distance">
**Variable timing:** Longer distances = longer duration

```swift
let distance = abs(newPosition - oldPosition)
let duration = min(0.3, max(0.15, distance / 1000))

.animation(.spring(duration: duration, bounce: 0), value: position)
```

**Use when:**
- Drag-to-reorder
- Scrolling to specific positions
- Moving elements large distances

**Don't overdo:** Subtle effect, 0.15-0.4s range maximum
</principle>
</timing_precision>

<animation_patterns>
## Common Animation Patterns

<pattern name="Expand/Collapse">
**Use case:** Accordions, detail views, menus

```swift
VStack {
    HeaderView()

    if isExpanded {
        DetailView()
            .transition(.move(edge: .top).combined(with: .opacity))
    }
}
.animation(.spring(duration: 0.3, bounce: 0), value: isExpanded)
```

**Key details:**
- Combined transition (move + opacity feels natural)
- No bounce (feels controlled)
- 0.3s standard duration
</pattern>

<pattern name="Modal Presentation">
**Use case:** Sheets, popovers, overlays

```swift
.sheet(isPresented: $showingSheet) {
    SheetContent()
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
}
```

**System behavior:**
- iOS handles animation automatically
- Spring-based by default
- Respects gesture velocity (swipe faster = animates faster)

**Don't override** unless you have a compelling reason
</pattern>

<pattern name="State Change">
**Use case:** Toggle states, selection, completion

```swift
Circle()
    .fill(isSelected ? Color.blue : Color.gray)
    .scaleEffect(isSelected ? 1.2 : 1.0)
    .animation(.spring(duration: 0.15, bounce: 0.3), value: isSelected)
```

**Details:**
- Quick duration (0.15s) feels responsive
- Slight bounce (0.3) feels playful
- Scale + color change together
</pattern>

<pattern name="Loading → Content">
**Use case:** Network requests, data loading

```swift
Group {
    if isLoading {
        SkeletonView()
            .transition(.opacity)
    } else {
        ContentView()
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
    }
}
.animation(.spring(duration: 0.4, bounce: 0), value: isLoading)
```

**Premium approach:**
- Skeleton screens (not spinners)
- Content scales up slightly (0.95 → 1.0)
- Smooth opacity fade
- Slightly longer duration (0.4s) feels luxurious
</pattern>

<pattern name="Gesture-Driven Animation">
**Use case:** Drag, swipe, pinch interactions

```swift
.gesture(
    DragGesture()
        .onChanged { value in
            offset = value.translation
        }
        .onEnded { value in
            withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                offset = .zero
            }
        }
)
```

**Critical:** Use `.interactiveSpring()` or spring with bounce for gesture-driven animations
- Maintains velocity from gesture
- Feels connected to touch
- Natural deceleration
</pattern>
</animation_patterns>

<micro_timing>
## Microinteraction Timing

**200-400ms is optimal** for most microinteractions (research-backed)

<timing name="Hover/Pressed States">
**Duration:** 0.1-0.15s
**Reason:** Instant feedback feels responsive

```swift
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.spring(duration: 0.1, bounce: 0), value: isPressed)
```
</timing>

<timing name="Success/Error Feedback">
**Duration:** 0.3-0.4s
**Reason:** Needs to be noticed, but not intrusive

```swift
.foregroundColor(showSuccess ? .green : .primary)
.scaleEffect(showSuccess ? 1.1 : 1.0)
.animation(.spring(duration: 0.3, bounce: 0.3), value: showSuccess)
```

Pair with haptic (medium impact)
</timing>

<timing name="Completion Celebrations">
**Duration:** 0.5-0.6s
**Reason:** Deserves a moment of joy

```swift
.scaleEffect(isCompleted ? 1.2 : 1.0)
.opacity(isCompleted ? 0 : 1)
.animation(.spring(duration: 0.6, bounce: 0.4), value: isCompleted)
```

Pair with haptic (notification.success) + sound (optional)
</timing>
</micro_timing>

<anti_patterns>
## What NOT to Do

<anti_pattern name="Linear Easing for UI">
**Problem:** Feels mechanical, robotic

```swift
// DON'T
.animation(.linear(duration: 0.3), value: isExpanded)
```

**Why it's bad:** No acceleration/deceleration. Unnatural.

**Instead:** Always use spring
</anti_pattern>

<anti_pattern name="Too Many Different Durations">
**Problem:** Inconsistent timing feels amateur

**Bad example:**
- Button press: 0.25s
- Modal presentation: 0.5s
- Toggle: 0.2s
- Expand: 0.35s

**Instead:** Pick 2-3 durations maximum (0.15s, 0.3s, 0.6s)
</anti_pattern>

<anti_pattern name="Over-Bouncing">
**Problem:** Too much bounce feels gimmicky

```swift
// DON'T (unless celebration)
.animation(.spring(duration: 0.3, bounce: 0.8), value: isExpanded)
```

**When:** Bounces >0.4 should be rare (completion celebrations only)

**Premium feel:** 0.0-0.2 bounce range
</anti_pattern>

<anti_pattern name="Animating Everything">
**Problem:** Animation fatigue - nothing feels special

**Don't animate:**
- Initial state (only animate changes)
- Every property change (be selective)
- Non-interactive elements (static content)

**Do animate:**
- User-triggered actions
- State changes
- Spatial relationships
- Feedback moments
</anti_pattern>

<anti_pattern name="No Animation on Gestures">
**Problem:** Feels disconnected, abrupt

```swift
// DON'T
.onTapGesture {
    isExpanded.toggle() // No animation!
}
```

**Instead:** Wrap in withAnimation or use .animation() modifier
</anti_pattern>
</anti_patterns>

<craft_study>
## Craft.do Animation Analysis

**What makes Craft feel premium:**

1. **Consistent 0.6s duration** - Everything uses same timing
2. **Subtle bounce (0.2)** - Just enough life, not distracting
3. **Combined transitions** - Opacity + scale + position together
4. **Anticipatory motion** - Slight scale-down before expansion
5. **Continuous animations** - No jarring stops

**Signature move:** Content blocks scale up (0.95 → 1.0) when appearing
**Why it works:** Feels like elements are "landing" into place

**Lesson:** Find your signature timing and use it consistently
</craft_study>

<performance>
## Performance Considerations

**Animations must be 60fps minimum (120fps on ProMotion displays)**

**Expensive to animate:**
- Shadows (use sparingly)
- Blurs (pre-render if possible)
- Large images (optimize size)
- Many simultaneous elements (stagger or limit)

**Cheap to animate:**
- Position (offset, position)
- Scale
- Rotation
- Opacity
- Color (simple fills)

**Optimization:**
- Use `.drawingGroup()` for complex animations
- Animate transforms, not layout
- Profile with Instruments (Time Profiler)

**If animation drops frames:** Simplify or use UIKit layer animations
</performance>

<sources>
Based on research from:
- [SwiftUI Animation Masterclass - DEV Community](https://dev.to/sebastienlato/swiftui-animation-masterclass-springs-curves-smooth-motion-3e4o)
- [Animate with springs - WWDC23](https://developer.apple.com/videos/play/wwdc2023/10158/)
- [Enhance your UI animations and transitions - WWDC24](https://developer.apple.com/videos/play/wwdc2024/10145/)
- [Building Fluid Interfaces - Nathan Gitter](https://medium.com/@nathangitter/building-fluid-interfaces-ios-swift-9732bb934bf5)
- [Designing Fluid Interfaces - WWDC18](https://developer.apple.com/videos/play/wwdc2018/803/)
</sources>
