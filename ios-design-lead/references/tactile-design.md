<overview>
Haptic feedback transforms visual interfaces into tactile experiences. When done right, haptics confirm actions, signal state changes, and make interfaces feel physical. The iPhone's Taptic Engine enables precise vibration patterns that create a vocabulary of touch.

**Philosophy:** Every significant action deserves tactile confirmation. Silence between haptics is part of the design.
</overview>

<haptic_types>
<generator name="UIImpactFeedbackGenerator">
**Use for:** Collision, impact, physical interactions

**Styles:**
| Style | Feel | Use Case |
|-------|------|----------|
| `.light` | Gentle tap | Selection feedback, subtle confirmations |
| `.medium` | Standard press | Button taps, state changes |
| `.heavy` | Strong thud | Completions, major actions, deletions |
| `.soft` | Cushioned | Gentle interactions, accessibility-friendly |
| `.rigid` | Sharp, precise | Snapping to grid, toggles, precision selections |

```swift
// Reusable pattern
HapticManager.impact(.medium) // Button press
HapticManager.impact(.rigid)  // Toggle switch
HapticManager.impact(.heavy)  // Delete action
```
</generator>

<generator name="UINotificationFeedbackGenerator">
**Use for:** Outcomes, results, semantic feedback

**Types:**
| Type | Pattern | Use Case |
|------|---------|----------|
| `.success` | Rising double-tap | Task completed, operation succeeded |
| `.warning` | Attention pulse | Validation issue, non-blocking error |
| `.error` | Harsh buzz | Failed operation, blocking error |

```swift
HapticManager.notification(.success) // Task done!
HapticManager.notification(.error)   // Something failed
```

**Each has distinctive vibration signature** — users learn the meaning.
</generator>

<generator name="UISelectionFeedbackGenerator">
**Use for:** Continuous selection, scrubbing through values

**Single lightweight tap** — designed for rapid, repeated feedback.

```swift
// As picker value changes
HapticManager.selection()
```

**Best for:**
- Picker wheels (each value change)
- Scrubbing through timeline
- Drag-to-reorder (crossing items)
- Segmented control changes
</generator>
</haptic_types>

<implementation>
## SwiftUI Integration

```swift
import SwiftUI
import UIKit

// Centralized HapticManager
final class HapticManager {
    static let shared = HapticManager()

    private let impactLight = UIImpactFeedbackGenerator(style: .light)
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    private let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    private let impactSoft = UIImpactFeedbackGenerator(style: .soft)
    private let selection = UISelectionFeedbackGenerator()
    private let notification = UINotificationFeedbackGenerator()

    private init() {}

    // Prepare generators before expected use
    func prepare() {
        impactMedium.prepare()
        selection.prepare()
        notification.prepare()
    }

    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        switch style {
        case .light: impactLight.impactOccurred()
        case .medium: impactMedium.impactOccurred()
        case .heavy: impactHeavy.impactOccurred()
        case .rigid: impactRigid.impactOccurred()
        case .soft: impactSoft.impactOccurred()
        @unknown default: impactMedium.impactOccurred()
        }
    }

    func selection() {
        selection.selectionChanged()
    }

    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        notification.notificationOccurred(type)
    }
}

// Convenience static accessors
extension HapticManager {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        shared.impact(style)
    }

    static func selection() {
        shared.selection()
    }

    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        shared.notification(type)
    }

    static func prepare() {
        shared.prepare()
    }
}
```

## Usage Patterns

**Button with haptic:**
```swift
Button("Complete Task") {
    HapticManager.impact(.medium)
    completeTask()
}
```

**Toggle with rigid feedback:**
```swift
Toggle("Notifications", isOn: $isEnabled)
    .onChange(of: isEnabled) { _, _ in
        HapticManager.impact(.rigid)
    }
```

**Success notification:**
```swift
func saveCompleted() {
    HapticManager.notification(.success)
    withAnimation(.spring(duration: 0.6, bounce: 0.3)) {
        showConfirmation = true
    }
}
```
</implementation>

<timing>
## Haptic + Animation Synchronization

**Critical:** Haptic must fire at the exact moment of visual change.

**On action:**
```swift
Button("Delete") {
    // Haptic fires immediately with visual
    HapticManager.impact(.heavy)
    withAnimation(.spring(duration: 0.3)) {
        isDeleted = true
    }
}
```

**On gesture threshold:**
```swift
.gesture(
    DragGesture()
        .onChanged { value in
            if !hasTriggeredHaptic && abs(value.translation.width) > threshold {
                HapticManager.impact(.medium)
                hasTriggeredHaptic = true
            }
        }
        .onEnded { _ in
            hasTriggeredHaptic = false
        }
)
```

**On continuous selection:**
```swift
Picker("Value", selection: $selectedValue) {
    ForEach(values, id: \.self) { value in
        Text(value).tag(value)
    }
}
.onChange(of: selectedValue) { _, _ in
    HapticManager.selection()
}
```
</timing>

<preparation>
## Reducing Latency

**Problem:** Cold haptics have ~100ms latency.

**Solution:** Call `.prepare()` just before expected use.

```swift
.onLongPressGesture(minimumDuration: 0.5) {
    HapticManager.impact(.medium)
    // Action
} onPressingChanged: { pressing in
    if pressing {
        HapticManager.prepare()
    }
}
```

**Best practices:**
- Prepare 0.1-0.5s before expected use
- Don't prepare too early (wastes power)
- Generators auto-unprepare after ~1-2s
- Prepare on `onAppear` for screens with immediate actions
</preparation>

<vocabulary>
## Building Your Haptic Language

**Consistency creates literacy.** Users learn your haptic vocabulary.

**Recommended vocabulary (TE/Braun-inspired):**

| Action | Generator | Style | Notes |
|--------|-----------|-------|-------|
| Primary button tap | Impact | Medium | Standard action confirmation |
| Secondary action | Impact | Light | Softer, less prominent |
| Toggle switch | Impact | Rigid | Sharp, precise state change |
| Selection change | Selection | — | Continuous, lightweight |
| Picker scrubbing | Selection | — | Each value = one tap |
| Task completed | Notification | Success | Celebration moment |
| Error occurred | Notification | Error | Something went wrong |
| Warning | Notification | Warning | Needs attention |
| Delete/destructive | Impact | Heavy | Significant, irreversible |
| Drag threshold | Impact | Medium | Gesture recognized |
| Snap to grid | Impact | Rigid | Precision alignment |
| Swipe to reveal | Impact | Light | Threshold crossed |

**Premium principle:** Less is more. Don't haptic on every scroll or minor state change.
</vocabulary>

<anti_patterns>
## What NOT to Do

<anti_pattern name="Haptic Spam">
**Problem:** Haptic on every UI update, every scroll position.
**Result:** Battery drain, vibration fatigue, meaningless feedback.
**Fix:** Only significant user actions get haptics.
</anti_pattern>

<anti_pattern name="Wrong Haptic Type">
**Problem:** Using notification.error for a button press.
**Fix:** Impact for actions, Notification for outcomes.
</anti_pattern>

<anti_pattern name="Mismatched Timing">
**Problem:** Haptic fires 0.5s after animation completes.
**Fix:** Fire haptic at moment of visual change.
</anti_pattern>

<anti_pattern name="No Preparation">
**Problem:** Haptics lag behind interactions.
**Fix:** Always prepare generators before expected use.
</anti_pattern>

<anti_pattern name="Relying on Haptics Alone">
**Problem:** Important feedback only through vibration.
**Fix:** Always pair with visual cues. VoiceOver users may not feel haptics.
</anti_pattern>
</anti_patterns>

<accessibility>
## Accessibility Considerations

**System setting:** Users can disable haptics (Settings > Accessibility > Touch > Vibration).

Your app should respect this, but UIFeedbackGenerator does this automatically.

**Don't rely on haptics alone:**
- Visual feedback is primary
- Haptics enhance, not replace
- VoiceOver users may not perceive haptics
- Always pair significant haptics with visual/audio cues

**For users with sensory processing differences:**
- Unexpected or intense vibrations can be overwhelming
- Prioritize crisp, predictable, short feedback
- Consider offering haptic intensity settings in your app
</accessibility>

<sources>
Based on:
- [UIFeedbackGenerator - Apple Developer](https://developer.apple.com/documentation/uikit/uifeedbackgenerator)
- [Haptic Feedback in iOS - Rushabh Singh](https://medium.com/naukri-engineering/implement-haptic-feedback-using-feedback-generators-in-ios-app-d7f6462a59a9)
- [2025 Guide to Haptics - Saropa](https://saropa-contacts.medium.com/2025-guide-to-haptics-enhancing-mobile-ux-with-tactile-feedback-676dd5937774)
- [Haptics on Apple Platforms - Marco Eidinger](https://blog.eidinger.info/haptics-on-apple-platforms)
</sources>
