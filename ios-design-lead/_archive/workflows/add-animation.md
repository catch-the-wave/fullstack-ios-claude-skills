# Workflow: Add Animations and Transitions

<required_reading>
**Read these reference files NOW:**
1. references/animations.md
2. references/microinteractions.md
3. references/exemplary-apps.md (study Craft.do section)
</required_reading>

<process>
## Step 1: Identify What to Animate

**Animate these:**
- User-triggered actions (tap, swipe, long press)
- State changes (toggle, completion, selection)
- Transitions (screen changes, modal presentations)
- Feedback moments (success, error, loading)

**Don't animate:**
- Initial state (only animate changes)
- Static content
- Every property change (be selective)
- Background processes

**Ask:** Does this animation guide attention or provide feedback?

## Step 2: Choose Animation Type

**Spring animations (default for all UI):**
```swift
.animation(.spring(duration: 0.3, bounce: 0), value: isExpanded)
```

**Standard timings:**
- **0.15s:** Quick feedback (button press, hover states)
- **0.3s:** Standard UI transitions (most animations)
- **0.6s:** Dramatic moments (celebrations, major state changes)

**Bounce values:**
- **0.0:** Smooth, elegant (professional feel)
- **0.2:** Subtle life (balanced)
- **0.3-0.4:** Playful (celebrations only)

**Craft.do standard:** 0.6s duration, 0.2 bounce (use for consistency)

## Step 3: Implement State-Based Animation

**Pattern 1: Simple state change**
```swift
@State private var isExpanded = false

VStack {
    if isExpanded {
        DetailView()
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
    }
}
.animation(.spring(duration: 0.3, bounce: 0), value: isExpanded)
```

**Pattern 2: Multiple properties**
```swift
Circle()
    .fill(isSelected ? Color.blue : Color.gray)
    .scaleEffect(isSelected ? 1.2 : 1.0)
    .animation(.spring(duration: 0.3, bounce: 0.2), value: isSelected)
```

## Step 4: Add Button Press Feedback

**Immediate responsiveness:**
```swift
@State private var isPressed = false

Button(action: { performAction() }) {
    Label("Action", systemImage: "star")
        .scaleEffect(isPressed ? 0.95 : 1.0)
}
.buttonStyle(PlainButtonStyle())
.onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
    withAnimation(.spring(duration: 0.1, bounce: 0)) {
        isPressed = pressing
    }
}, perform: {})
```

**Key:** 0.1s for instant feedback, scale to 0.95 (subtle)

## Step 5: Implement Gesture-Driven Animation

**Drag with spring return:**
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
                        dismissCard()
                    } else {
                        offset = .zero  // Snap back
                    }
                }
            }
    )
```

**Critical:** Use spring with bounce for gesture-driven (maintains velocity)

## Step 6: Add Sequential Animations

**Staggered reveal:**
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

**Delay:** 0.05s per item (rapid cascade)

## Step 7: Implement Loading → Content Transition

**Premium approach (skeleton):**
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

**Key:** Content scales up slightly (0.95 → 1.0) when appearing

## Step 8: Add Celebration Animations

**Task completion:**
```swift
Circle()
    .fill(isCompleted ? Color.green : Color.gray.opacity(0.3))
    .overlay {
        if isCompleted {
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .transition(.scale.combined(with: .opacity))
        }
    }
.animation(.spring(duration: 0.6, bounce: 0.4), value: isCompleted)
.onTapGesture {
    HapticManager.notification(.success)
    isCompleted.toggle()
}
```

**Longer duration (0.6s) + more bounce (0.4) = celebratory**

## Step 9: Synchronize with Haptics

**Timing is critical:**
```swift
Button("Complete") {
    // Fire haptic immediately
    HapticManager.notification(.success)

    // Then animate
    withAnimation(.spring(duration: 0.6, bounce: 0.4)) {
        isCompleted = true
    }
}
```

**Haptic fires at:**
- Start of animation (0.0s)
- Or peak of animation (0.3s for 0.6s duration)

## Step 10: Test Performance

**Must be 60fps minimum (120fps on ProMotion)**

**Profile:**
```bash
# Run with Instruments (Time Profiler)
xcodebuild -scheme YourScheme -destination 'id=00008140-001220421AD0801C' -quiet build
```

**If animations lag:**
- Simplify visual effects
- Use `.drawingGroup()` for complex animations
- Reduce shadow complexity
- Optimize images

**Test on device, not simulator** (performance differs)

</process>

<anti_patterns>
Avoid:
- Linear easing curves (use springs always)
- Inconsistent timing (pick 2-3 durations, stick to them)
- Over-bouncing (>0.4 bounce feels gimmicky)
- Animating everything (only significant changes)
- No animation on gestures (feels disconnected)
- Laggy animations (<60fps)
- Mismatched haptic timing (fire at visual peak)
</anti_patterns>

<success_criteria>
Well-animated interface:
- All animations use spring curves (no linear)
- Consistent timing (2-3 durations maximum)
- 60fps+ on device
- Haptics synchronized with visual feedback
- Gesture-driven animations maintain velocity
- Button presses have immediate feedback (0.1s)
- Celebrations are longer (0.6s) with bounce
- Animations can be interrupted smoothly
- Respects reduce motion accessibility setting
- Feels fluid, alive, premium
</success_criteria>
