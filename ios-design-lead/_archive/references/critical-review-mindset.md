<overview>
How to review code with brutal honesty and attention to real-world issues that developers actually miss. Based on real feedback: "Agent said 'everything is well maintained' when code had obvious organizational problems."
</overview>

<core_principle>
## Your Job is to Find Real Problems

**NOT to make the user feel good.**

If the code has issues, call them out specifically. If it's truly excellent, say so with specifics. But NEVER give generic praise when there are obvious problems.

**Bad review:**
> "Everything is well maintained! Your code is well structured."

**Good review:**
> "Found 5 organizational issues:
> 1. Components scattered across Features/ instead of centralized in DesignSystem/
> 2. Magic number `54` hardcoded on line 12 - should use UIConstants.Toolbar.buttonHeight
> 3. Inconsistent naming: SelectionToolbar should be CardSelectionToolbar
> 4. Wrong folder: SelectionToolbar in Cards/ instead of Toolbars/
> 5. Hardcoded padding values throughout - need design tokens"

The second review is USEFUL. The first is USELESS.
</core_principle>

<what_to_actually_check>
## Common Real-World Issues That Get Missed

These are the issues that exist in real codebases and need refactoring:

### 1. Design System Organization

**Check:**
- [ ] Are components in `DesignSystem/Components/[Category]/`?
- [ ] Or scattered in `Features/[Feature]/Components/`?
- [ ] Are design tokens being used?
- [ ] Or are values hardcoded everywhere?

**Real example that was missed:**
```swift
// This file: Features/Navigation/Components/Bottom Toolbar/BottomToolbar.swift
// Should be: DesignSystem/Components/Toolbars/Bottom/BottomToolbar.swift

let toolbarButtonH: CGFloat = 54  // ❌ Magic number, not design token
.padding(16)                       // ❌ Hardcoded spacing
.padding(.vertical, 12)            // ❌ Hardcoded spacing
.font(.system(size: 18))          // ❌ Hardcoded font size

// Should use:
UIConstants.Toolbar.buttonHeight
UIConstants.Spacing.m
UIConstants.Spacing.s
.font(.body)
```

### 2. Component Placement

**Check:**
- [ ] Is `SelectionToolbar.swift` in the `Cards/` folder? ❌
- [ ] Should it be in `Toolbars/` folder? ✓
- [ ] Are toolbar components scattered or organized?
- [ ] Does the file path match the component's purpose?

**Real example:**
```
❌ Bad:
DesignSystem/Components/Cards/SelectionToolbar.swift
Features/Navigation/Components/Bottom Toolbar/BottomToolbar.swift
Features/Navigation/Components/Bottom Toolbar/TabBarButtons.swift

✓ Good:
DesignSystem/Components/Toolbars/Bottom/CardSelectionToolbar.swift
DesignSystem/Components/Toolbars/Bottom/BottomToolbar.swift
DesignSystem/Components/Toolbars/Bottom/TabBarButtons.swift
```

### 3. Naming Consistency

**Check:**
- [ ] Is the name clear about what it does?
- [ ] `SelectionToolbar` - selection of what?
- [ ] `CardSelectionToolbar` - ah, card selection! ✓

**Real example:**
```swift
// ❌ Ambiguous
struct SelectionToolbar: View {
  // Toolbar for selecting... cards? tags? what?
}

// ✓ Clear
struct CardSelectionToolbar: View {
  // Obviously for selecting cards
}
```

### 4. Magic Numbers Everywhere

**Check:**
- [ ] Hardcoded spacing: `16`, `12`, `8`, `4`
- [ ] Hardcoded sizes: `54`, `44`, `32`
- [ ] Hardcoded durations: `0.3`, `0.25`
- [ ] Hardcoded colors: `0.2`, `0.8` opacity

**Real example:**
```swift
// ❌ Magic numbers scattered everywhere
.padding(.horizontal, 16)
.padding(.vertical, 12)
.frame(minHeight: 54)
.cornerRadius(8)
.opacity(0.2)

// ✓ Design tokens
.padding(.horizontal, UIConstants.Spacing.m)
.padding(.vertical, UIConstants.Spacing.s)
.frame(minHeight: UIConstants.Toolbar.buttonHeight)
.cornerRadius(UIConstants.CornerRadius.s)
.opacity(UIConstants.Opacity.subtle)
```

### 5. File Organization Doesn't Match Architecture

**Check:**
```bash
# Run these commands to see if organization is messy
find . -name "*Toolbar*.swift"
find . -name "*Button*.swift"
ls -la DesignSystem/Components/
ls -la Features/*/Components/

# Good structure:
DesignSystem/
  Components/
    Toolbars/
      Top/
      Bottom/
    Buttons/
    Cards/
  Tokens/
    UIConstants.swift
    Colors.swift

# Bad structure:
Features/Navigation/Components/Bottom Toolbar/
Features/Editor/Components/
DesignSystem/Components/Cards/SelectionToolbar.swift (wrong category!)
```
</what_to_actually_check>

<how_to_report>
## How to Report Issues

### Be Specific, Not Generic

**❌ Generic (useless):**
> "Some improvements could be made to organization."

**✓ Specific (useful):**
> "5 files need to be moved from Features/Navigation/Components/ to DesignSystem/Components/Toolbars/"

### Count the Issues

**❌ Vague:**
> "There are some magic numbers."

**✓ Counted:**
> "Found 12 magic numbers across 4 files that should use design tokens."

### Provide the Fix

**❌ No solution:**
> "This should use a constant."

**✓ With fix:**
> "Replace `let toolbarButtonH: CGFloat = 54` with `UIConstants.Toolbar.buttonHeight` token."

### Reference Real Code

**❌ Abstract:**
> "Some files are in wrong folders."

**✓ Concrete:**
> "`SelectionToolbar.swift` is in `DesignSystem/Components/Cards/`
> Should be in `DesignSystem/Components/Toolbars/Bottom/`
> And renamed to `CardSelectionToolbar.swift`"
</how_to_report>

<severity_classification>
## What's Actually Critical

### 🔴 Critical (causes real problems):
- **Design system violations** - leads to inconsistent UI, hard to maintain
- **Poor organization** - wastes hours finding code, slows development
- **Magic numbers** - breaks design consistency, hard to update
- Memory leaks, crashes, security issues
- Accessibility blockers

### 🟡 Important (should fix soon):
- **Wrong file locations** - confusing for team, hard to navigate
- **Inconsistent naming** - unclear purpose, cognitive load
- Performance problems
- Architecture violations

### 🟢 Minor (nice to have):
- Code style details
- Comment improvements
- Small refactoring opportunities

**The real-world refactor commit showed:**
- Moving files: 🟡 Important
- Adding design tokens: 🔴 Critical
- Renaming for clarity: 🟡 Important
- Organizing structure: 🔴 Critical

These are NOT minor issues. They required a dedicated refactor commit.
</severity_classification>

<anti_patterns>
## What NOT to Do

**Don't say:**
- "Everything is well maintained" (when it's not)
- "Your code is well structured" (when files are scattered)
- "Looks good" (when there are obvious issues)
- "Just a few minor tweaks" (when there's a full refactor needed)

**These phrases are RED FLAGS** - they mean you're not actually reviewing, just giving generic feedback.

**If you catch yourself about to say these, STOP and ask:**
1. Did I check design system organization?
2. Did I grep for magic numbers?
3. Did I verify file structure?
4. Did I check component placement?
5. Did I look for naming inconsistencies?

If the answer to ANY is "no", you haven't actually reviewed the code.
</anti_patterns>

<checklist>
## Pre-Review Checklist (DO EVERY TIME)

Before giving ANY feedback, verify you checked:

- [ ] Ran `find . -name "*.swift" | grep -E "(Toolbar|Button|Card)"` to see file organization
- [ ] Ran `grep -r "CGFloat.*=" --include="*.swift"` to find magic number constants
- [ ] Checked if `DesignSystem/` folder exists and is being used
- [ ] Looked for hardcoded values: `.padding(16)`, `.frame(height: 54)`, etc.
- [ ] Verified component names are clear and consistent
- [ ] Checked if files are in correct folders for their purpose
- [ ] Looked at actual code structure, not just assumed it's good

**If you didn't do ALL of these, your review is incomplete.**
</checklist>

<success_criteria>
A good critical review:
- Actually finds the issues that exist
- Is specific with file names, line numbers, counts
- Provides concrete fixes, not vague suggestions
- Prioritizes by real impact (not just style)
- Is honest about severity (major refactor vs minor tweak)
- Never gives generic praise when problems exist
- Helps the developer understand WHY it matters

**The user should feel:**
- "Wow, the agent actually looked at my code"
- "These are real issues I need to fix"
- "I understand why this needs refactoring"

**NOT:**
- "That was generic and unhelpful"
- "The agent just said nice things"
- "I had to do a 3-hour refactor the agent didn't catch"
</success_criteria>
