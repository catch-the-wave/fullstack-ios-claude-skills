<overview>
Accessibility is not optional - it's required for App Store approval and essential for inclusive design. Over 1.3 billion people have disabilities. VoiceOver, Dynamic Type, and high contrast modes must work perfectly. Accessible design benefits everyone.
</overview>

<core_features>
## Essential iOS Accessibility Features

<feature name="VoiceOver">
**Screen reader for blind/low-vision users**

**Every element needs:**
```swift
Image(systemName: "heart.fill")
    .accessibilityLabel("Favorite")
    .accessibilityHint("Double tap to add to favorites")

// Better: Use Label (automatic)
Label("Favorite", systemImage: "heart.fill")
```

**Button accessibility:**
```swift
Button(action: toggleFavorite) {
    Image(systemName: isFavorite ? "heart.fill" : "heart")
}
.accessibilityLabel(isFavorite ? "Unfavorite" : "Favorite")
.accessibilityHint("Double tap to toggle")
```

**Custom views:**
```swift
.accessibilityElement(children: .combine)
.accessibilityLabel("Task: Buy milk")
.accessibilityValue(isCompleted ? "Completed" : "Not completed")
.accessibilityAction {
    toggleCompleted()
}
```
</feature>

<feature name="Dynamic Type">
**User-adjustable text sizes**

**Always use text styles:**
```swift
Text("Content")
    .font(.body)  // Scales automatically
```

**Custom fonts:**
```swift
Text("Content")
    .font(.custom("YourFont", size: 17, relativeTo: .body))
```

**Scaling metrics:**
```swift
@ScaledMetric var spacing: CGFloat = 16
// Automatically scales with text size
```

**Test at:**
- Default
- xxxLarge (common for 50+ users)
- AX3 (accessibility extreme)

**Handling large sizes:**
```swift
ViewThatFits {
    HStack { /* Horizontal at small sizes */ }
    VStack { /* Vertical at large sizes */ }
}
```
</feature>

<feature name="High Contrast">
**Increased contrast for visual impairments**

```swift
@Environment(\.accessibilityContrast) var contrast

var textColor: Color {
    contrast == .high ? .primary : .secondary
}
```

**Automatic with semantic colors** (they adapt automatically)
</feature>

<feature name="Reduce Motion">
**Fewer animations for vestibular disorders**

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

var animation: Animation {
    reduceMotion ? .none : .spring(duration: 0.3, bounce: 0)
}
```

**Pattern:**
```swift
withAnimation(reduceMotion ? .none : .spring()) {
    isExpanded.toggle()
}
```
</feature>

<feature name="Voice Control">
**Hands-free interface control**

**Requirements:**
- All interactive elements have labels
- Touch targets are 44x44pt minimum
- No gesture-only interactions (provide button alternatives)
</feature>
</core_features>

<wcag_compliance>
## WCAG 2.1 Standards

**Contrast ratios:**
- **Text:** 4.5:1 minimum (AA), 7:1 ideal (AAA)
- **Large text** (18pt+): 3:1 minimum
- **UI elements:** 3:1 minimum

**Testing:**
```swift
// Use Accessibility Inspector in Xcode
// Or Color Contrast Analyzer tool
```

**Common failures:**
- Light gray on white
- Colored text on colored backgrounds
- Thin fonts (need higher contrast)

**Fix:**
```swift
// Use semantic colors (they adapt)
.foregroundColor(.primary)  // Always sufficient contrast
.foregroundColor(.secondary)  // Also sufficient
```
</wcag_compliance>

<voiceover_best_practices>
## VoiceOver Excellence

<practice name="Meaningful Labels">
**Bad:**
```swift
Image(systemName: "star")
// VoiceOver: "Image"
```

**Good:**
```swift
Image(systemName: "star")
    .accessibilityLabel("Favorite")
// VoiceOver: "Favorite"
```

**Best:**
```swift
Label("Favorite", systemImage: "star")
// VoiceOver: "Favorite, button" (if tappable)
```
</practice>

<practice name="Action Descriptions">
```swift
Button("Delete") {}
    .accessibilityHint("Double tap to delete this item")
```

**Guidelines:**
- Label: What it is ("Delete button")
- Hint: What it does ("Double tap to delete")
- Keep hints under 10 words
</practice>

<practice name="State Announcements">
```swift
Toggle("Notifications", isOn: $isEnabled)
    .accessibilityValue(isEnabled ? "On" : "Off")
```

**For custom controls:**
```swift
.accessibilityAddTraits(isSelected ? [.isSelected] : [])
.accessibilityRemoveTraits(.isButton)  // If not actually a button
```
</practice>

<practice name="Grouping Elements">
```swift
// Bad: VoiceOver reads each element separately
HStack {
    Image(systemName: "person")
    Text("John Doe")
    Text("Online")
}

// Good: Combined into one element
HStack {
    Image(systemName: "person")
    Text("John Doe")
    Text("Online")
}
.accessibilityElement(children: .combine)
.accessibilityLabel("John Doe, Online")
```
</practice>

<practice name="Hide Decorative Elements">
```swift
Image("decorative-pattern")
    .accessibilityHidden(true)  // VoiceOver skips it
```

**Hide:**
- Decorative images
- Dividers
- Redundant information
- Visual-only elements
</practice>
</voiceover_best_practices>

<inclusive_design>
## Designing for Everyone

**Color blindness (8% of men):**
- Don't rely on color alone
- Add icons, shapes, text labels
- Test with color blindness simulators

```swift
// Bad: Red vs Green only
StatusView(color: isActive ? .green : .red)

// Good: Icon + color
HStack {
    Image(systemName: isActive ? "checkmark.circle.fill" : "xmark.circle.fill")
    Text(isActive ? "Active" : "Inactive")
}
.foregroundColor(isActive ? .green : .red)
```

**Motor impairments:**
- Large touch targets (48pt+)
- Generous spacing (16pt between targets)
- No precision-required gestures
- Alternative to drag: Buttons

**Cognitive load:**
- Clear hierarchy
- Consistent patterns
- Simple language
- One primary action per screen

**Situational disabilities:**
- Bright sunlight (high contrast mode helps)
- Noisy environment (visual feedback)
- One-handed use (reachable buttons)
</inclusive_design>

<testing>
## Accessibility Testing Checklist

**Before shipping:**

- [ ] Enable VoiceOver, navigate entire app
- [ ] Test at xxxLarge text size
- [ ] Test at AX3 text size (extreme)
- [ ] Enable high contrast mode
- [ ] Enable reduce motion
- [ ] Use Accessibility Inspector (Xcode)
- [ ] Test with color blindness simulator
- [ ] Verify all touch targets are 44x44pt+
- [ ] Check contrast ratios (4.5:1 minimum)
- [ ] Ensure all images have labels (or are hidden)
- [ ] Test with Voice Control

**Accessibility Inspector:**
- Xcode → Open Developer Tool → Accessibility Inspector
- Audit function finds common issues
- Test VoiceOver navigation
- Verify contrast ratios
</testing>

<anti_patterns>
## Accessibility Mistakes

<anti_pattern name="Images Without Labels">
**Problem:** VoiceOver says "image"

**Fix:** Add .accessibilityLabel() to every meaningful image
</anti_pattern>

<anti_pattern name="Fixed Font Sizes">
**Problem:** Doesn't scale with Dynamic Type

**Fix:** Use .font(.body) not .font(.system(size: 17))
</anti_pattern>

<anti_pattern name="Color-Only Information">
**Problem:** Color-blind users can't distinguish

**Fix:** Add icons, shapes, or text labels
</anti_pattern>

<anti_pattern name="Tiny Touch Targets">
**Problem:** Hard to tap for motor impairments

**Fix:** Minimum 44x44pt, expand with .contentShape()
</anti_pattern>

<anti_pattern name="Gesture-Only Actions">
**Problem:** Voice Control users can't access

**Fix:** Provide button alternative to swipe/long-press
</anti_pattern>

<anti_pattern name="Poor Contrast">
**Problem:** Low vision users can't read

**Fix:** Use semantic colors, test with Accessibility Inspector
</anti_pattern>
</anti_patterns>

<sources>
Based on research from:
- [iOS Accessibility Guidelines 2025 - David Auerbach](https://medium.com/@david-auerbach/ios-accessibility-guidelines-best-practices-for-2025-6ed0d256200e)
- [iOS Accessibility Guide - BrowserStack](https://www.browserstack.com/guide/accessibility-ios)
- [VoiceOver, Dynamic Type Tutorial - DEV](https://dev.to/cl0udleadanis/tutorial-27-improving-accessibility-voiceover-dynamic-type-and-haptic-feedback-50l2)
</sources>
