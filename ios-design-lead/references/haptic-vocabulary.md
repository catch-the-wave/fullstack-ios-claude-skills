<haptic_vocabulary>
**Tactile Pleasure System**

Haptics confirm reality. Build consistent vocabulary users learn.

| Interaction | Generator | Style | When |
|-------------|-----------|-------|------|
| Button tap | Impact | Medium | Primary actions |
| Toggle flip | Impact | Rigid | State changes |
| Selection change | Selection | — | Pickers, scrubbing |
| Threshold crossed | Impact | Medium | Gesture commits |
| Task completed | Notification | Success | Accomplishments |
| Error/warning | Notification | Error/Warning | Validation failures |
| Destructive action | Impact | Heavy | Irreversible actions |
| Subtle feedback | Impact | Soft | Hover, minor confirms |
| Precision snap | Impact | Rigid | Grid alignment |

**Timing Law:** Haptic fires at **moment of visual change**. Not before. Not after.

**Preparation:** Call `.prepare()` 0.1-0.5s before expected use (onPressing, onAppear).

**Premium Rule:** Less is more. Silence between haptics is part of the design.
</haptic_vocabulary>

<implementation_patterns>
**Basic haptic setup:**
```swift
let impact = UIImpactFeedbackGenerator(style: .medium)
impact.prepare()  // Call early
impact.impactOccurred()  // At moment of change
```

**Selection feedback (continuous):**
```swift
let selection = UISelectionFeedbackGenerator()
selection.prepare()
selection.selectionChanged()
```

**Notification feedback (outcomes):**
```swift
let notification = UINotificationFeedbackGenerator()
notification.notificationOccurred(.success)  // or .warning, .error
```

**SwiftUI sensory feedback:**
```swift
.sensoryFeedback(.impact(weight: .medium), trigger: value)
.sensoryFeedback(.selection, trigger: selectedIndex)
```
</implementation_patterns>
