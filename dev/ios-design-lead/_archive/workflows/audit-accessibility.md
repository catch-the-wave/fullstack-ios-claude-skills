# Workflow: Audit and Improve Accessibility

<required_reading>
**Read these reference files NOW:**
1. references/accessibility.md
2. references/typography.md
3. references/color-system.md
</required_reading>

<process>
## Step 1: VoiceOver Audit

**Enable VoiceOver on device:**
- Settings → Accessibility → VoiceOver → On
- Or triple-click side button (if configured)

**Navigate entire app:**
- [ ] Can reach all interactive elements
- [ ] Labels are meaningful (not "button" or "image")
- [ ] Order makes sense (top to bottom, left to right)
- [ ] Grouped elements read as one (not individually)
- [ ] Hidden decorative elements (.accessibilityHidden)

**Fix missing labels:**
```swift
// Before
Image(systemName: "trash")
// VoiceOver: "image"

// After
Image(systemName: "trash")
    .accessibilityLabel("Delete")
    .accessibilityHint("Double tap to delete this item")
```

**Fix element grouping:**
```swift
// Before: Reads each element separately
HStack {
    Image(systemName: "person")
    Text("John Doe")
    Text("Online")
}

// After: Reads as one
HStack {
    Image(systemName: "person")
    Text("John Doe")
    Text("Online")
}
.accessibilityElement(children: .combine)
.accessibilityLabel("John Doe, Online")
```

## Step 2: Dynamic Type Audit

**Test at multiple sizes:**
- Settings → Accessibility → Display & Text Size → Larger Text
- Test at: Default, xxxLarge, AX3 (extreme)

**Check:**
- [ ] All text scales proportionally
- [ ] No truncation of important text
- [ ] Layout adapts (switches to vertical if needed)
- [ ] Touch targets remain accessible

**Fix fixed sizes:**
```swift
// Before (doesn't scale)
Text("Content")
    .font(.system(size: 17))

// After (scales)
Text("Content")
    .font(.body)
```

**Handle large sizes:**
```swift
// Adaptive layout
ViewThatFits {
    HStack {
        // Horizontal at small sizes
    }
    VStack {
        // Vertical at large sizes
    }
}

// Scale spacing
@ScaledMetric var spacing: CGFloat = 16
VStack(spacing: spacing) {
    // Spacing scales with text
}
```

## Step 3: Contrast Audit

**Use Accessibility Inspector:**
- Xcode → Open Developer Tool → Accessibility Inspector
- Click "Audit" button
- Review contrast warnings

**Manual check:**
- Take screenshots
- Use Color Contrast Analyzer tool
- Verify 4.5:1 minimum for text

**Fix low contrast:**
```swift
// Before (fails contrast)
Text("Subtitle")
    .foregroundColor(.gray)  // Fixed gray

// After (sufficient contrast)
Text("Subtitle")
    .foregroundColor(.secondary)  // Semantic color
```

**Check dark mode separately**

## Step 4: Touch Target Audit

**Measure targets:**
- Accessibility Inspector shows size
- Minimum: 44x44pt
- Recommended: 48x48pt+

**Fix small targets:**
```swift
// Before (too small)
Button {
    deleteItem()
} label: {
    Image(systemName: "trash")
        .font(.system(size: 14))
}
// Actual tappable area: ~20x20pt

// After (expanded)
Button {
    deleteItem()
} label: {
    Image(systemName: "trash")
        .font(.system(size: 14))
}
.frame(minWidth: 44, minHeight: 44)
.contentShape(Rectangle())
```

**Check spacing between targets:**
- Minimum 8pt
- Comfortable: 16pt

## Step 5: Color Blindness Check

**Use simulator:**
- Accessibility Inspector → Simulation
- Test: Protanopia, Deuteranopia, Tritanopia

**Or use online tools:**
- Colorblind Web Page Filter
- Color Oracle

**Fix color-only indicators:**
```swift
// Before (color only)
Circle()
    .fill(isActive ? .green : .red)

// After (icon + color)
HStack {
    Image(systemName: isActive ? "checkmark.circle.fill" : "xmark.circle.fill")
    Text(isActive ? "Active" : "Inactive")
}
.foregroundColor(isActive ? .green : .red)
```

## Step 6: Reduce Motion Check

**Enable:**
- Settings → Accessibility → Motion → Reduce Motion

**Test app:**
- Animations should be simplified or removed
- No vestibular trigger effects (parallax, zoom)

**Respect setting:**
```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

withAnimation(reduceMotion ? .none : .spring(duration: 0.3, bounce: 0)) {
    isExpanded.toggle()
}
```

## Step 7: Voice Control Test

**Enable:**
- Settings → Accessibility → Voice Control

**Test:**
- Say "Show names" (numbers appear on interactive elements)
- Try controlling app with voice commands
- Verify all actions are accessible

**Fix:**
- Ensure all buttons have clear labels
- Provide alternatives to gesture-only features

## Step 8: Comprehensive Checklist

**Before shipping:**

- [ ] **VoiceOver:** Full app navigation works
- [ ] **Dynamic Type:** Tested at xxxLarge and AX3
- [ ] **Contrast:** All text meets 4.5:1 minimum
- [ ] **Touch targets:** All ≥44x44pt
- [ ] **Color blindness:** Not relying on color alone
- [ ] **Reduce motion:** Animations respect setting
- [ ] **Voice Control:** All features accessible
- [ ] **Dark mode:** Contrast maintained
- [ ] **Accessibility Inspector:** No critical warnings
- [ ] **Real users:** Test with people who use assistive tech

## Step 9: Document Accessibility Features

**In App Store Connect:**
- Register accessibility features your app supports
- Helps users discover accessible apps

**In app:**
- Settings page with accessibility info
- Link to support for assistance

## Step 10: Continuous Testing

**Integrate into workflow:**
- Test VoiceOver after every major UI change
- Keep Accessibility Inspector open during development
- Profile with different text sizes regularly
- Include accessibility in QA checklist

</process>

<anti_patterns>
Avoid:
- Testing only in light mode
- Skipping VoiceOver testing
- Fixed font sizes
- Color as only indicator
- Touch targets <44pt
- Images without labels
- Gesture-only critical features
- Assuming accessibility is "done" (it's ongoing)
</anti_patterns>

<success_criteria>
Fully accessible app:
- All VoiceOver users can navigate independently
- Works perfectly at AX3 text size
- All text contrast ≥4.5:1 (7:1 for AAA)
- All touch targets ≥44x44pt
- Color-blind users can distinguish states
- Reduce motion respected
- Voice Control can access all features
- Passes Accessibility Inspector audit
- Ready for App Store approval
- Inclusive to 1.3B people with disabilities
</success_criteria>
