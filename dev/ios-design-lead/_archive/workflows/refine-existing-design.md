# Workflow: Refine Existing Design

<required_reading>
**Read these reference files NOW:**
1. references/philosophy.md
2. references/anti-patterns.md
3. references/microinteractions.md
4. references/exemplary-apps.md
</required_reading>

<process>
<ajtbd_integration>
## Step 0: Re-validate User Jobs (Auto-AJTBD)

**Before refining, confirm the interface is solving the right job.**

Automatically invoke the AJTBD product-analyst agent:

```
Use Task tool with subagent_type="ajtbd:product-analyst"

Prompt: "Analyze if this interface correctly serves the user job:
- Screen/feature being refined: [describe]
- Current issues observed: [list friction points]

Identify:
1. Core Job - Is the interface completing the right job?
2. Job drift - Has the design drifted from the original job?
3. Missing micro-jobs - What steps are broken or missing?
4. Success criteria gaps - Where does UI fail to signal job completion?

Focus on job alignment issues that refinement should fix."
```

**Output to capture:**
- Is this the right job? (validate or correct)
- Which micro-jobs have friction?
- What success criteria are unsatisfied?
- Refinement priorities based on job impact

<grounding_check critical="true">
**CRITICAL: Ground AJTBD in UI Reality**

AJTBD analysis must be validated against existing UI patterns. Theoretical job-correctness is worthless if users can't find or access the feature.

**Always verify:**
1. **Discoverability** - Can users tell this is interactive? (borders, shadows, affordances)
2. **Tap count** - How many taps to complete the job? (3+ taps = not "convenient")
3. **Existing patterns** - What do users already know is tappable? (leverage, don't fight)
4. **Visual affordances** - No borders = users won't try long-press

**Example failure:**
> AJTBD says: "Capsule-level context menu matches the job"
> Reality: Capsules have no borders → users don't know they're tappable
> Reality: 3+ taps to access → not convenient at all
> Reality: Cards already have discoverable context menus → use that pattern

**The lesson:** "Simplest" implementation isn't simple if users can't find it.
</grounding_check>

**Refinements should improve job completion, not just aesthetics.**
</ajtbd_integration>

## Step 1: Audit Current State

**With AJTBD context, audit the experience:**
- Note every friction point (especially in critical micro-jobs)
- Notice what feels "off" (job completion signals?)
- Identify inconsistencies
- Find missing feedback moments

**Screenshot key screens** for before/after comparison

## Step 2: Apply Minimalism Check

**Dieter Rams question:** "What can I remove?"

**For each screen:**
1. List every element
2. Mark as Essential / Nice to have / Remove
3. Actually remove the "Remove" items
4. Question the "Nice to have" items

**Cosmos.so approach:** When uncertain, remove it

**Common removals:**
- Redundant labels
- Decorative elements
- Secondary buttons (move to context menu)
- Unnecessary dividers
- Excessive colors

## Step 3: Fix Spacing Inconsistencies

**Measure current spacing:**
- Take screenshots
- Overlay 8pt grid
- Note violations

**Fix to 8pt grid:**
```swift
// Before (inconsistent)
.padding(.top, 12)
.padding(.bottom, 18)

// After (8pt grid)
.padding(.top, 16)
.padding(.bottom, 16)
```

**Increase spacing if too tight:**
- Minimum between unrelated elements: 16pt
- Between sections: 24-32pt
- Major boundaries: 48pt+

**Premium signals:** Generous spacing

## Step 4: Unify Typography

**Current state audit:**
- How many different font sizes?
- How many weights?
- Is Dynamic Type supported?

**Target state (3-4 styles max):**
```swift
// Standardize to text styles
.font(.largeTitle)  // Page titles
.font(.title2)      // Section headers
.font(.body)        // Primary content
.font(.footnote)    // Metadata
```

**Replace:**
```swift
// Before
.font(.system(size: 18, weight: .semibold))

// After
.font(.headline)
```

## Step 5: Consolidate Color Usage

**Current state audit:**
- Screenshot all screens
- Extract color palette
- Count unique colors

**Target state (1-2 accents):**
```swift
// Replace fixed colors
// Before
.foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))

// After
.foregroundColor(.primary)  // Adapts to dark mode
```

**Accent color usage:**
- Primary actions only
- Should appear 5-10% of UI
- Consistent throughout app

## Step 6: Add Missing Microinteractions

**Check for:**
- [ ] Button press feedback (scale to 0.95)
- [ ] Toggle confirmations (haptic)
- [ ] State change animations
- [ ] Loading states (skeletons, not spinners)
- [ ] Empty states (helpful, not generic)
- [ ] Success confirmations (visual + haptic)
- [ ] Error feedback (gentle, helpful)

**Add where missing:**
```swift
// Before (no feedback)
Button("Action") {
    performAction()
}

// After (with feedback)
@State private var isPressed = false

Button("Action") {
    HapticManager.impact(.medium)
    performAction()
}
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.spring(duration: 0.1, bounce: 0), value: isPressed)
```

## Step 7: Standardize Animation Timing

**Audit current animations:**
- Record screen
- Play back in slow motion
- Note timing variations

**Standardize to 2-3 durations:**
```swift
// Replace varied timings
// Before
.animation(.easeInOut(duration: 0.25))  // Inconsistent
.animation(.spring(dampingFraction: 0.7, response: 0.4))  // Different

// After (consistent)
.animation(.spring(duration: 0.3, bounce: 0), value: state)
```

**All UI transitions:** 0.3s
**Quick feedback:** 0.15s
**Celebrations:** 0.6s

## Step 8: Improve Accessibility

**Run checklist:**
- [ ] Enable VoiceOver, navigate app
- [ ] Test at xxxLarge text size
- [ ] Verify all images have labels
- [ ] Check contrast ratios
- [ ] Ensure 44x44pt touch targets

**Fix common issues:**
```swift
// Add missing labels
Image(systemName: "heart")
    .accessibilityLabel("Favorite")

// Support Dynamic Type
.font(.body)  // Not .font(.system(size: 17))

// Expand touch targets
.frame(minWidth: 44, minHeight: 44)
.contentShape(Rectangle())
```

## Step 9: Polish Details

**Border radius consistency:**
```swift
// Pick one value and use everywhere
.cornerRadius(12)  // Standard throughout app
```

**Shadow consistency:**
```swift
// Standard elevation
.shadow(color: .black.opacity(0.1), radius: 10, y: 5)
```

**Icon consistency:**
- Use SF Symbols where possible
- Same rendering mode (.monochrome or .hierarchical)
- Weight matches adjacent text

## Step 10: A/B Compare

**Before vs. After:**
- Place screenshots side by side
- Show to team/users
- Note improvements

**Measure:**
- Fewer elements?
- More spacing?
- Clearer hierarchy?
- More consistent?
- Better accessibility?

**Ship when:**
- Feels premium
- Passes accessibility audit
- No visual inconsistencies
- Every interaction has feedback

</process>

<anti_patterns>
Avoid:
- Adding more features (focus on polish, not scope)
- Over-decorating (remove, don't add)
- Inconsistent fixes (standardize everything)
- Ignoring accessibility
- Skipping before/after comparison
</anti_patterns>

<success_criteria>
Successfully refined design:
- Uses 8pt grid consistently
- 3-4 text styles maximum per screen
- 1-2 accent colors
- Generous spacing (16-24pt minimum)
- All animations use same timing
- Every interaction has feedback
- Passes accessibility audit
- Feels more premium than before
- Could remove nothing else
</success_criteria>
