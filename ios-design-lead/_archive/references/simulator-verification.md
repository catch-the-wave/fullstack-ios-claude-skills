<overview>
Automatically verify visual changes by running the app in iOS Simulator, taking screenshots, and comparing before/after states. This ensures design changes match expectations before proceeding.
</overview>

<workflow>
## Automatic UI Verification Workflow

**After each code change:**

### Step 1: Build for Simulator

```bash
xcodebuild -scheme YourScheme \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -quiet build
```

**If build fails:** Stop and fix (incremental approach)

### Step 2: Get Simulator ID

```bash
# List available simulators
xcrun simctl list devices available | grep "iPhone 15 Pro"

# Or use MCP tool
# mcp__ios-simulator__get_booted_sim_id
```

### Step 3: Boot Simulator (if needed)

```bash
xcrun simctl boot "iPhone 15 Pro"

# Or use MCP tool
# mcp__ios-simulator__open_simulator
```

### Step 4: Install App

```bash
# Get app path from build
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "*.app" -path "*/Build/Products/Debug-iphonesimulator/*" | head -1)

# Install
xcrun simctl install booted "$APP_PATH"
```

### Step 5: Launch App

```bash
xcrun simctl launch booted com.yourapp.bundleID

# Or use MCP tool
# mcp__ios-simulator__ui_view to navigate
```

### Step 6: Screenshot the Changed UI

**Using MCP tool:**
```
mcp__ios-simulator__screenshot
```

**Or using xcrun:**
```bash
xcrun simctl io booted screenshot screenshot-after.png
```

### Step 7: Compare Before/After

**Visual comparison:**
1. Load before screenshot
2. Load after screenshot
3. Identify the specific change
4. Verify it matches expectations

**Checklist:**
- [ ] Change is visible
- [ ] Looks as intended (spacing, color, size)
- [ ] No unintended side effects
- [ ] Animations work (if applicable)
- [ ] No layout breaks

### Step 8: Report Results

```markdown
✅ Visual Verification Complete

Changed: Added blue accent to tag input
Screenshot: After adding color, tag input now shows blue checkmark
Verified:
- Color change visible ✓
- Contrast is good ✓
- No layout shifts ✓
Ready for next change
```
</workflow>

<simulator_tools>
## Available MCP iOS Simulator Tools

**Tool: mcp__ios-simulator__get_booted_sim_id**
- Returns ID of currently booted simulator
- Use to target commands

**Tool: mcp__ios-simulator__screenshot**
- Captures current screen
- Returns image for verification

**Tool: mcp__ios-simulator__ui_tap**
- Tap UI element at coordinates or by label
- Navigate to relevant screens

**Tool: mcp__ios-simulator__ui_view**
- View UI hierarchy
- Find element positions

**Tool: mcp__ios-simulator__open_simulator**
- Boot and open Simulator app
- Prepare for testing
</simulator_tools>

<navigation>
## Navigating to Changed Screen

**Challenge:** After launching app, how to get to the screen you changed?

**Solutions:**

**1. Deep linking (best):**
```bash
xcrun simctl openurl booted "yourapp://feature/screen"
```

**2. UI automation:**
```
# Use mcp__ios-simulator__ui_tap
# Tap through navigation to reach screen
```

**3. Manual with guidance:**
```
App launched. Please navigate to:
Settings > Account > Profile
Then I'll screenshot to verify changes
```

**4. Direct screen launch (if app supports):**
```swift
// In app, add debug mode
#if DEBUG
if ProcessInfo.processInfo.environment["LAUNCH_SCREEN"] == "Profile" {
    return ProfileView()
}
#endif
```
</navigation>

<comparison>
## Before/After Comparison

**Best practice:**

**Before making change:**
1. Take "before" screenshot
2. Note: "Screenshot saved: before-tag-input.png"

**After making change:**
1. Build, install, launch
2. Take "after" screenshot
3. Load both screenshots
4. Compare visually
5. Report differences

**Example report:**
```markdown
## Visual Changes Verified

Before: Tags were gray text
After: Tags now have blue accent and pill style

Changes visible:
- Background color added (blue.opacity(0.2)) ✓
- Border radius applied (8pt) ✓
- Padding correct (horizontal: 8pt, vertical: 4pt) ✓
- Text color unchanged (good) ✓

No regressions detected.
Ready for next change.
```
</comparison>

<automated_testing>
## When to Use Automated Verification

**Use simulator verification when:**
- Making visual changes (color, spacing, layout)
- Adding new UI elements
- Changing animations (can see if they run)
- Modifying existing screens
- Want to catch layout breaks early

**Skip simulator verification when:**
- Only changing ViewModel logic
- Modifying data models
- Updating services/network code
- Changes aren't visually observable
- Build times are too long (>2 min)

**Balance:** Visual changes = always verify. Logic changes = unit tests.
</automated_testing>

<example_session>
## Example: Adding Button with Verification

**Change 1: Add button to view**

```bash
# Edit file: ProfileView.swift
# Add: Button("Save") { save() }

# Build
xcodebuild -scheme App -destination 'platform=iOS Simulator,name=iPhone 15 Pro' -quiet build
✓ Build succeeded

# Launch
xcrun simctl launch booted com.example.app
✓ App launched

# Screenshot
mcp__ios-simulator__screenshot
✓ Screenshot captured

# Verify
Visual check: Button appears at bottom of screen ✓
Ready for next change
```

**Change 2: Add button styling**

```bash
# Edit file: ProfileView.swift
# Add: .buttonStyle(.borderedProminent)

# Build
xcodebuild -scheme App -destination 'platform=iOS Simulator,name=iPhone 15 Pro' -quiet build
✓ Build succeeded

# Kill and relaunch (to see change)
xcrun simctl terminate booted com.example.app
xcrun simctl launch booted com.example.app

# Screenshot
mcp__ios-simulator__screenshot
✓ Screenshot captured

# Verify
Visual check: Button now has blue background and white text ✓
Matches design system ✓
Ready for next change
```

**Benefits:**
- Caught visual issues immediately
- Confirmed styling matches intention
- No surprises at end
- Fast iteration
</example_session>

<anti_patterns>
**Don't:**
- Make 10 changes then check simulator once
- Skip verification because "it should work"
- Test on device only (simulator is faster for iteration)
- Ignore visual regressions

**Do:**
- Verify each visual change immediately
- Screenshot before and after
- Report what you see
- Catch issues early
</anti_patterns>

<success_criteria>
Effective simulator verification:
- Screenshots taken after EACH visual change
- Before/after comparison documented
- Changes verified to match intention
- Layout breaks caught immediately
- Fast feedback loop (build → verify → next)
- User has visual confidence in changes
- No surprises when running on device
</success_criteria>
