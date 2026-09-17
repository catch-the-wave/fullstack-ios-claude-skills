# Workflow: Polish Microinteractions and Details

<required_reading>
**Read these reference files NOW:**
1. references/microinteractions.md
2. references/animations.md
3. references/haptics.md
4. references/exemplary-apps.md (study Craft.do, Things)
</required_reading>

<process>
## Step 1: Identify Micro-Moments

**Use your app for 10 minutes:**
- Note every interaction
- Which feel satisfying?
- Which feel dead or mechanical?
- Where is feedback missing?

**Common micro-moments:**
- Button press
- Toggle switch
- Task completion
- Selection change
- Loading state
- Empty state
- Success confirmation
- Error feedback
- Pull to refresh
- Swipe actions
- Drag and drop

## Step 2: Add Button Press Feedback

**Every tappable element needs immediate response:**

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

    if pressing {
        HapticManager.impact(.light)
    }
}, perform: {})
```

**Key details:**
- 0.1s animation (instant)
- Scale to 0.95 (subtle)
- Light haptic on press
- Spring curve (natural)

## Step 3: Celebrate Completions

**Task completion deserves joy:**

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
        .animation(.spring(duration: 0.6, bounce: 0.4), value: isCompleted)

    Text("Complete task")
        .strikethrough(isCompleted)
}
.onTapGesture {
    HapticManager.notification(.success)
    isCompleted.toggle()
}
```

**Premium details:**
- Success haptic (distinctive)
- 0.6s animation (celebratory)
- 0.4 bounce (playful)
- Checkmark scales in
- Text strikethrough animates

## Step 4: Improve Loading States

**Replace spinners with skeletons:**

```swift
if isLoading {
    SkeletonView()
        .transition(.opacity)
} else {
    ContentView()
        .transition(.opacity.combined(with: .scale(scale: 0.95)))
}
.animation(.spring(duration: 0.4, bounce: 0), value: isLoading)
```

**Skeleton view:**
```swift
struct SkeletonView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 20)
                .frame(maxWidth: 200)

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 16)

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 16)
                .frame(maxWidth: 150)
        }
        .opacity(isAnimating ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
        .onAppear { isAnimating = true }
    }
}
```

**Shows structure while loading** - feels faster

## Step 5: Design Helpful Empty States

**Not "No items" - guide the user:**

```swift
VStack(spacing: 24) {
    Image(systemName: "tray")
        .font(.system(size: 60))
        .foregroundColor(.secondary)
        .symbolEffect(.bounce, value: trigger)

    VStack(spacing: 8) {
        Text("No Items Yet")
            .font(.title3.weight(.semibold))

        Text("Tap the + button to add your first item")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
    }

    Button {
        showAddSheet = true
    } label: {
        Label("Add Item", systemImage: "plus")
    }
    .buttonStyle(.borderedProminent)
}
.padding(40)
.transition(.opacity.combined(with: .scale(scale: 0.9)))
```

**Helpful, not dead-end**

## Step 6: Add Selection Feedback

**Visual + haptic confirmation:**

```swift
@State private var selectedItem: Item?

ItemRow(item)
    .background(selectedItem == item ? Color.actionPrimary.opacity(0.1) : Color.clear)
    .cornerRadius(12)
    .onTapGesture {
        HapticManager.selection()

        withAnimation(.spring(duration: 0.2, bounce: 0)) {
            selectedItem = item
        }
    }
```

**Things 3 pattern:**
- Selection haptic (distinctive)
- Background highlight appears
- Smooth animation

## Step 7: Polish State Transitions

**Every state change should animate:**

```swift
// Toggle switch
Toggle("Feature", isOn: $isEnabled)
    .onChange(of: isEnabled) { old, new in
        HapticManager.impact(new ? .medium : .light)

        // Different haptic for on vs off creates vocabulary
    }

// Expanding section
if isExpanded {
    DetailView()
        .transition(.move(edge: .top).combined(with: .opacity))
}
.animation(.spring(duration: 0.3, bounce: 0), value: isExpanded)
```

## Step 8: Add Gesture Feedback

**During swipe/drag:**

```swift
@State private var offset: CGFloat = 0
@State private var hasTriggered = false

ItemView()
    .offset(x: offset)
    .gesture(
        DragGesture()
            .onChanged { value in
                offset = value.translation.width

                // Haptic at threshold
                if !hasTriggered && abs(offset) > 100 {
                    HapticManager.impact(.medium)
                    hasTriggered = true

                    // Visual feedback
                    withAnimation(.spring(duration: 0.2, bounce: 0)) {
                        showDeleteIcon = true
                    }
                }
            }
            .onEnded { value in
                withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                    if abs(offset) > 150 {
                        deleteItem()
                    } else {
                        offset = 0
                        showDeleteIcon = false
                    }
                }
                hasTriggered = false
            }
    )
```

**Threshold crossed = haptic + visual preview**

## Step 9: Craft Error Messages

**Gentle, helpful, human:**

```swift
// Bad
Text("Error 403: Forbidden")

// Good
VStack(spacing: 16) {
    Image(systemName: "exclamationmark.triangle")
        .font(.system(size: 48))
        .foregroundColor(.statusWarning)

    Text("Can't Access This")
        .font(.headline)

    Text("You don't have permission to view this content. Contact support if you think this is a mistake.")
        .font(.subheadline)
        .foregroundColor(.secondary)
        .multilineTextAlignment(.center)

    Button("Contact Support") {
        openSupport()
    }
    .buttonStyle(.bordered)
}
.padding(32)
```

**With warning haptic:**
```swift
HapticManager.notification(.warning)
```

## Step 10: Review Craft.do Details

**Study these signature moments:**
1. **Block insertion** - Scales up from 0.95 (appears to land)
2. **Drag handles** - Fade in on hover
3. **Modal presentation** - Scales from 0.98, backdrop fades simultaneously
4. **Text selection** - Highlight expands smoothly
5. **Completion** - Success haptic + subtle celebration

**Implement 2-3 signature details** in your app

**Make them yours** - consistent philosophy, unique execution

</process>

<anti_patterns>
Avoid:
- Generic feedback (make it specific to action)
- Inconsistent timing (standardize to 0.3s)
- Over-celebration (match significance)
- No haptic feedback (feels disconnected)
- Spinners instead of skeletons
- Dead-end empty states
- Technical error messages
- Animating everything (be selective)
</anti_patterns>

<success_criteria>
Premium microinteractions:
- Every button press has immediate feedback (0.1s)
- Completions feel rewarding (0.6s + bounce)
- Loading states show structure (skeletons)
- Empty states are helpful (clear action)
- State changes animate smoothly (0.3s springs)
- Gestures have visual + haptic feedback
- Error messages are human and helpful
- Timing is consistent (2-3 durations only)
- Haptics create vocabulary (learned patterns)
- Feels polished, premium, intentional
- Craft.do or Things 3 level of detail
</success_criteria>
