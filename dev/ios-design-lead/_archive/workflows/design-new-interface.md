# Workflow: Design New Interface

<required_reading>
**Read these reference files NOW before designing:**
1. references/philosophy.md
2. references/hig-principles.md
3. references/layout-spatial.md
4. references/typography.md
5. references/color-system.md
6. references/exemplary-apps.md
</required_reading>

<process>
<ajtbd_integration>
## Step 0: Understand User Jobs (Auto-AJTBD)

**Before designing anything, understand the job the user is trying to complete.**

Automatically invoke the AJTBD product-analyst agent:

```
Use Task tool with subagent_type="ajtbd:product-analyst"

Prompt: "Analyze the user job for this interface:
- Feature/screen: [describe what we're designing]
- Product context: [app name, purpose]

Identify:
1. Core Job - What job will this interface complete?
2. Big Job - What higher-level goal does this serve?
3. Critical sequence - What jobs lead to/from this?
4. Success criteria - How will user know the job is done?
5. Consideration set - What alternatives exist?

Keep analysis focused and actionable for UI design."
```

**Output to capture:**
- Core Job statement (When... Want... So that...)
- 3-5 success criteria the UI must satisfy
- Critical micro-jobs the interface must complete
- Key emotional transition (negative → positive)

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

**This analysis informs ALL subsequent design decisions.**
</ajtbd_integration>

## Step 1: Understand Intention

**With AJTBD context, now clarify design intent:**

Ask user (or derive from AJTBD analysis):
- What is the user trying to accomplish? (Core Job from Step 0)
- What emotional state should this evoke? (From job's emotional transition)
- What's the ONE primary action? (Critical micro-job)
- Who is this for? (Segment context from AJTBD)

**Mental model shift:** Design for job completion + consciousness elevation

## Step 2: Sketch Information Architecture

**On paper or whiteboard (not in code yet):**

1. List all information that must be present
2. Rank by importance (1-2-3)
3. Remove anything not essential
4. Group related information
5. Identify primary action

**Minimalism check:** Can you remove one more element?

## Step 3: Apply Layout Principles

**8pt grid foundation:**
```swift
VStack(spacing: 16) {  // Multiples of 8
    // Primary content
    PrimaryView()
        .padding(.bottom, 24)

    // Secondary content
    SecondaryView()
}
.padding(16)  // Margins
```

**Hierarchy through size + weight:**
- Primary: `.title` or `.largeTitle`, Semibold
- Secondary: `.headline` or `.body`, Medium/Regular
- Tertiary: `.subheadline` or `.footnote`, Regular

**Spacing (Fibonacci):**
- Related elements: 4-8pt
- Sections: 16-24pt
- Major groups: 34-48pt

**Cosmos.so influence:** When uncertain, add more space

## Step 4: Design with System Components First

**Start with native iOS patterns:**

```swift
// Navigation
NavigationStack {
    List {
        // Content
    }
    .navigationTitle("Title")
}

// Or Form
Form {
    Section("Details") {
        TextField("Name", text: $name)
        Toggle("Enabled", isOn: $isEnabled)
    }
}

// Or Custom VStack
VStack(alignment: .leading, spacing: 16) {
    // Custom layout
}
```

**Customize only after establishing foundation**

## Step 5: Apply Typography

```swift
VStack(alignment: .leading, spacing: 8) {
    Text("Primary Headline")
        .font(.title2)
        .foregroundColor(.primary)

    Text("Supporting text goes here")
        .font(.body)
        .foregroundColor(.primary)

    Text("Metadata • 2 min ago")
        .font(.footnote)
        .foregroundColor(.secondary)
}
```

**3 levels maximum per screen**

## Step 6: Add Semantic Colors

```swift
// Use semantic colors (adapt to dark mode)
.foregroundColor(.primary)
.background(Color(.systemBackground))

// Accent sparingly
Button("Primary Action") {}
    .tint(.accentColor)
```

**Restraint:** 1-2 accent colors maximum

## Step 7: Ensure Accessibility

**Before proceeding:**

- [ ] All touch targets 44x44pt minimum
- [ ] Text uses .font() styles (not fixed sizes)
- [ ] All images have .accessibilityLabel()
- [ ] Contrast ratios meet 4.5:1 minimum
- [ ] Test with VoiceOver
- [ ] Test at xxxLarge text size

## Step 8: Add Visual Polish

**Only after structure is solid:**

- Subtle shadows for elevation
- Border radius (8-12pt standard)
- Dividers where needed (hairline)
- SF Symbols for icons

```swift
CardView()
    .background(Color(.secondarySystemBackground))
    .cornerRadius(12)
    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
```

**Premium signal:** Consistent corner radius throughout app

## Step 9: Review Against Philosophy

**Consciousness check:**
- Does this feel alive?
- Could I remove one more element?
- Is this accessible to everyone?
- Does this respect user's attention?
- Would I pay for this level of polish?

**If answer is no to any:** Refine before proceeding

## Step 10: Implement and Test

```swift
// Build for device
xcodebuild -scheme YourScheme -destination 'id=00008140-001220421AD0801C' -quiet build
```

**Test on actual device (Stargazer - iPhone 16e):**
- Does it feel responsive?
- Are touch targets easy to hit?
- Does Dynamic Type work?
- Does dark mode look good?
- Are animations smooth (60fps+)?

</process>

<anti_patterns>
Avoid:
- Starting in code (sketch first)
- Decorating before structure is solid
- Ignoring platform conventions
- Fixed font sizes
- Too many colors
- Cluttered layouts (add more spacing)
- Skipping accessibility
- Designing in light mode only
</anti_patterns>

<success_criteria>
A well-designed interface:
- **Completes the Core Job** identified in AJTBD analysis
- **Satisfies success criteria** from user job analysis
- Has clear hierarchy (3 levels max)
- Uses 8pt grid spacing consistently
- Supports Dynamic Type
- Works in dark mode
- Meets accessibility standards (VoiceOver, contrast)
- Has generous spacing (minimum 16pt between sections)
- Uses 1-2 accent colors maximum
- Feels intentional and alive
- Could pass App Store review
- Respects consciousness (calm, not chaotic)
</success_criteria>
