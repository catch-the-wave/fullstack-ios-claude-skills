<overview>
Haptic feedback transforms visual interfaces into tactile experiences. When done right, haptics confirm actions, signal state changes, and make interfaces feel physical. The iPhone's Taptic Engine enables precise vibration patterns that create a vocabulary of touch.
</overview>

<haptic_types>
## The Three Feedback Generators

<generator name="UIImpactFeedbackGenerator">
**Use for:** Collision, impact, physical interactions

**Intensities:**
- `.light` - Selection feedback, light taps, subtle confirmations
- `.medium` - State changes, button presses, standard actions
- `.heavy` - Significant events, completions, major state changes
- `.soft` (iOS 13+) - Gentle, cushioned feel
- `.rigid` (iOS 13+) - Sharp, precise feel

```swift
class HapticManager {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}

// Usage
HapticManager.impact(.medium) // Button press
```

**When to use each:**
- **Light:** Hover states, selection changes in lists, subtle feedback
- **Medium:** Button taps, toggle switches, confirmations
- **Heavy:** Task completion, major achievements, deletions
- **Soft:** Gentle interactions, accessibility-friendly
- **Rigid:** Precise selections, snapping to grid, technical feel
</generator>

<generator name="UINotificationFeedbackGenerator">
**Use for:** Success, warning, error states

**Types:**
- `.success` - Green checkmark, task completed, operation succeeded
- `.warning` - Yellow caution, validation issue, non-blocking error
- `.error` - Red X, failed operation, blocking error

```swift
class HapticManager {
    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}

// Usage
HapticManager.notification(.success) // Task completed!
```

**Distinctive patterns** - Each has unique vibration signature
</generator>

<generator name="UISelectionFeedbackGenerator">
**Use for:** Changing selection, scrubbing through values

**Single type** - Lightweight, repeated feedback

```swift
class HapticManager {
    static let selectionGenerator = UISelectionFeedbackGenerator()

    static func selection() {
        selectionGenerator.selectionChanged()
    }
}

// Usage - continuous selection
HapticManager.selection() // As picker value changes
```

**Best for:**
- Picker wheels (each value change)
- Scrubbing through timeline
- Drag-to-reorder (crossing items)
- Segmented control selection
</generator>
</haptic_types>

<haptic_vocabulary>
## Building a Haptic Language

**Consistency creates literacy** - Users learn your haptic vocabulary

<vocabulary name="Standard iOS App">
| Action | Haptic | Intensity |
|--------|--------|-----------|
| Button tap | Impact | Medium |
| Toggle switch | Impact | Light |
| Selection change | Selection | - |
| Task completed | Notification | Success |
| Error occurred | Notification | Error |
| Delete action | Impact | Heavy |
| Threshold crossed | Impact | Medium |
| Subtle feedback | Impact | Light |
</vocabulary>

<vocabulary name="Things 3 Vocabulary">
| Action | Haptic | Notes |
|--------|--------|-------|
| Check task | Impact Medium | Satisfying completion |
| Swipe threshold | Impact Light | Gesture recognized |
| Long press trigger | Impact Medium | Selection mode entered |
| Drag over item | Selection | Continuous feedback |
| Drop to reorder | Impact Light | Confirmed placement |
</vocabulary>

<vocabulary name="Premium Feel Vocabulary">
**Craft.do approach:**
- Minimal but meaningful
- Only on significant actions
- Paired with animation timing
- Soft/rigid for nuanced feedback

**Key:** Less is more. Overuse diminishes impact.
</vocabulary>
</haptic_vocabulary>

<implementation>
## SwiftUI Integration

```swift
import SwiftUI
import UIKit

// Reusable HapticManager
class HapticManager {
    static let impact = UIImpactFeedbackGenerator(style: .medium)
    static let selection = UISelectionFeedbackGenerator()
    static let notification = UINotificationFeedbackGenerator()

    static func prepare() {
        impact.prepare()
        selection.prepare()
        notification.prepare()
    }

    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    static func selection() {
        selection.selectionChanged()
    }

    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        notification.notificationOccurred(type)
    }
}

// SwiftUI View Extension
extension View {
    func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) -> some View {
        self.onTapGesture {
            HapticManager.impact(style)
        }
    }
}

// Usage
Button("Complete Task") {
    HapticManager.notification(.success)
    completeTask()
}
```
</implementation>

<timing>
## Haptic + Animation Synchronization

**Critical:** Haptic must fire at the exact moment of visual feedback

```swift
Button("Delete") {
    // Haptic fires immediately
    HapticManager.impact(.heavy)

    withAnimation(.spring(duration: 0.3, bounce: 0)) {
        // Visual animation
        isDeleted = true
    }
}
```

**Common patterns:**

**On gesture threshold:**
```swift
.onChange(of: dragOffset) { old, new in
    if !hasTriggered && abs(new.width) > threshold {
        HapticManager.impact(.medium) // Exactly when threshold crossed
        hasTriggered = true
    }
}
```

**On completion animation:**
```swift
withAnimation(.spring(duration: 0.6, bounce: 0.4)) {
    isCompleted = true
}
// Fire haptic at start (0.0s) or peak (0.3s)
HapticManager.notification(.success)
```

**Sequential haptics:**
```swift
// Prepare → Action → Confirm
HapticManager.impact(.light)        // 0.0s - Touch
DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
    HapticManager.impact(.medium)   // 0.3s - Completion
}
```
</timing>

<preparation>
## Preparing Generators (Reducing Latency)

**Problem:** Cold haptics have ~100ms latency

**Solution:** Call `.prepare()` just before use

```swift
// Before gesture starts
.onLongPressGesture(minimumDuration: 0.5) {
    HapticManager.impact(.medium)
} onPressingChanged: { pressing in
    if pressing {
        // Prepare while user is pressing
        UIImpactFeedbackGenerator(style: .medium).prepare()
    }
}
```

**Best practices:**
- Prepare 0.1-0.5s before expected use
- Don't prepare too early (wastes power)
- Don't prepare too late (defeats purpose)
- Generators auto-unprepare after 1-2s
</preparation>

<accessibility>
## Accessibility Considerations

**System setting:** Users can disable haptics (Accessibility > Touch > Vibration)

**Your app must respect this:**

```swift
class HapticManager {
    static var isEnabled: Bool {
        // Check if device supports haptics
        UIDevice.current.value(forKey: "feedbackSupportLevel") as? Int ?? 0 > 1
    }

    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        guard isEnabled else { return }
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
```

**Don't rely on haptics alone:**
- Visual feedback is primary
- Haptics enhance, not replace
- VoiceOver users may not feel haptics
- Always pair with visual/audio cues
</accessibility>

<anti_patterns>
## What NOT to Do

<anti_pattern name="Haptic Spam">
**Problem:** Haptic on every UI update

**Bad:** Firing haptics 10+ times per second
**Result:** Battery drain, vibration fatigue, annoying

**Fix:** Only on significant user actions
</anti_pattern>

<anti_pattern name="Wrong Haptic Type">
**Problem:** Using notification.error for button press

**Bad:**
```swift
Button("Save") {
    HapticManager.notification(.error) // Wrong!
}
```

**Fix:** Use impact for actions, notification for outcomes
</anti_pattern>

<anti_pattern name="Mismatched Timing">
**Problem:** Haptic fires after animation completes

**Bad:**
```swift
withAnimation {
    isCompleted = true
}
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
    HapticManager.notification(.success) // Too late!
}
```

**Fix:** Fire haptic at moment of visual peak
</anti_pattern>

<anti_pattern name="No Preparation">
**Problem:** Haptics lag behind interactions

**Solution:** Always prepare generators before expected use
</anti_pattern>
</anti_patterns>

<premium_patterns>
## Premium Haptic Design

**Things 3:**
- Minimal but purposeful
- Perfectly timed with animations
- Distinctive per action type
- Never overwhelming

**Craft.do:**
- Soft/rigid for nuanced interactions
- Haptic on drag thresholds
- Completion celebrations (success)

**AI Writer:**
- Subtle selection feedback
- Text editing confirmations
- Error vibrations (gentle warnings)

**Cosmos.so:**
- Extremely minimal (almost zen)
- Only on significant actions
- Silence is part of the design
</premium_patterns>

<sources>
Based on research from:
- [UIFeedbackGenerator - Apple](https://developer.apple.com/documentation/uikit/uifeedbackgenerator)
- [Haptic Feedback in iOS - Rushabh Singh](https://medium.com/naukri-engineering/implement-haptic-feedback-using-feedback-generators-in-ios-app-d7f6462a59a9)
- [Haptics on Apple Platforms - Marco Eidinger](https://blog.eidinger.info/haptics-on-apple-platforms)
- [Haptic Feedback - Sarunw](https://sarunw.com/posts/play-haptic-feedback-using-uifeedbackgenerator/)
</sources>
