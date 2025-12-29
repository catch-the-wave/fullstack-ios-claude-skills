<overview>
The single most important development practice: work in USER SCENARIOS, not arbitrary code chunks. Write as-is → to-be, implement the scenario completely, test end-to-end, verify it works, then move to next scenario.
</overview>

<critical_rule>
## The Scenario-Based Development Rule

**The increment is a USER SCENARIO, not a line of code.**

This is not a suggestion. This is how you avoid 3-hour debugging sessions.

### Why This Matters

**Bad approach (causes 3-hour debugging):**
```
"Let's add tags and filters and sorting and..."
1. Modify 10 files
2. Add 5 new components
3. Change data models
4. Update navigation
5. NOW try to build
6. 47 errors
7. Which feature broke what? Unknown.
8. Spend 3 hours debugging
```

**Good approach (scenario-based):**
```
Scenario 1: "User can add tags by typing #"
- As-is: No tag support
- To-be: # triggers tag suggestions, Enter adds tag
- Implement: All code for this behavior
- Build and test: Tag input works end-to-end ✓
- Move to Scenario 2

Scenario 2: "User can filter thoughts by tag"
- As-is: Tags exist but no filtering
- To-be: Tap tag to filter, see filtered list
- Implement: All code for this behavior
- Build and test: Filtering works end-to-end ✓
- Move to Scenario 3
```

**The difference:**
- Bad: 3 hours lost debugging tangled changes
- Good: Each scenario works, builds on previous, confident progress
</critical_rule>

<workflow>
## The Scenario-Based Workflow

### Step 1: Agent Writes User Scenario

**Always start by documenting the scenario:**

```markdown
## User Scenario: [Name]

**As-is:**
[Current behavior - what happens now]

**To-be:**
[Desired behavior - what should happen]

**Acceptance criteria:**
- [ ] User can [specific action]
- [ ] System responds with [specific behavior]
- [ ] Edge case: [specific handling]
```

**Example:**
```markdown
## User Scenario: Add Tags to Thoughts

**As-is:**
User types in thought input field. No tag support.

**To-be:**
When user types "#", tag suggestion dropdown appears.
User can type tag name or select from suggestions.
Pressing Enter adds tag as blue pill below input.
Tags are saved with the thought.

**Acceptance criteria:**
- [ ] # character triggers tag mode
- [ ] Suggestions appear with existing tags
- [ ] Enter key adds tag
- [ ] Tag appears as blue pill
- [ ] Tag is persisted with thought
- [ ] Can add multiple tags
- [ ] Can remove tags by tapping X
```

### Step 2: Implement All Changes for Scenario

**Now you can make multiple code changes** - because they're all part of ONE user-facing behavior:

```
For "Add Tags" scenario:
- Create TagInputView.swift
- Add @State var tags: [String] to ThoughtInput
- Create TagSuggestionView.swift
- Update ThoughtModel to include tags
- Add tag parsing logic
- Add tag pill display
- Wire up all components
```

**This is fine** because it's all for ONE scenario.

### Step 3: Build and Test Complete Scenario

```bash
# Build
xcodebuild -scheme Mindcraft-Release -destination 'id=00008140-001220421AD0801C' -quiet build

# Test the COMPLETE scenario (ideally automated)
# 1. Boot simulator
# 2. Launch app
# 3. Type "#" → verify suggestions appear
# 4. Type "important" → verify it appears in suggestions
# 5. Press Enter → verify blue pill appears
# 6. Save thought → verify tag persisted
```

### Step 4: Verify End-to-End

**Checklist for scenario:**
- [ ] All acceptance criteria met
- [ ] No regressions (existing features still work)
- [ ] Edge cases handled
- [ ] Automated test passes (if available)
- [ ] Manual test passes
- [ ] Screenshot shows expected behavior

### Step 5: Move to Next Scenario

```markdown
✅ Scenario Complete: Add Tags to Thoughts

Next scenario: Filter Thoughts by Tag
```

**Now repeat** - write new scenario, implement, test, verify.
</workflow>

<scenario_template>
## User Scenario Template

Copy this structure for every scenario:

```markdown
## User Scenario: [Clear Name]

**As-is:**
[What currently happens - be specific]

**To-be:**
[What should happen - be specific]
[Include interaction details: tap, swipe, type, etc.]
[Include visual feedback: animations, colors, haptics]

**Acceptance criteria:**
- [ ] User can [action] and sees [result]
- [ ] System responds with [behavior] when [condition]
- [ ] Edge case: [specific edge case] is handled by [approach]
- [ ] Visual: [UI element] appears with [style/animation]
- [ ] Accessibility: [VoiceOver behavior]

**Files to modify:**
- [List expected files - helps scope work]

**Dependencies:**
- [List scenarios this depends on, if any]
```
</scenario_template>

<automated_testing>
## Ideal: Automated Scenario Testing

**For each scenario, ideally have automated test:**

```swift
// TagInputScenarioTests.swift
func testUserCanAddTagByTypingHash() {
    // Given: User is in thought input screen
    let view = ThoughtInputView()

    // When: User types "#important"
    view.textInput.typeText("#important")
    view.textInput.typeKey(.enter)

    // Then: Tag appears as blue pill
    XCTAssertEqual(view.tags.count, 1)
    XCTAssertEqual(view.tags.first?.text, "important")
    XCTAssertEqual(view.tags.first?.color, .blue)
}
```

**Or UI test in simulator:**
```bash
# Launch app in scenario test mode
xcrun simctl launch booted com.mindcraft.app --scenario "add-tags"

# Verify scenario completes successfully
# Screenshot at each step
# Compare with expected screenshots
```
</automated_testing>

<example_session>
## Example: Multi-Scenario Feature

**Feature:** Tag System

**Scenario 1: Add Tags**
```markdown
As-is: No tag support
To-be: User can type # to add tags
Implement: TagInputView, TagModel, persistence
Test: Can add tags and they persist ✓
```

**Scenario 2: Display Tags**
```markdown
As-is: Tags saved but not displayed
To-be: Tags shown as pills on thought cards
Implement: TagPillView, update ThoughtCard
Test: Tags visible on cards ✓
```

**Scenario 3: Filter by Tag**
```markdown
As-is: Tags visible but can't filter
To-be: Tap tag to filter thoughts
Implement: TagFilterView, filter logic
Test: Filtering works, can clear filter ✓
```

**Scenario 4: Tag Suggestions**
```markdown
As-is: Must type full tag name
To-be: Show existing tags as suggestions
Implement: TagSuggestionView, search logic
Test: Suggestions appear and work ✓
```

**Each scenario:**
- Written clearly (as-is → to-be)
- Implemented completely
- Tested end-to-end
- Verified before moving on
</example_session>

<anti_patterns>
**Don't:**
- Jump into code without writing scenario
- Mix multiple unrelated scenarios in one batch
- Test individual functions instead of user behavior
- Move to next scenario if current one doesn't work

**Do:**
- Always write scenario first (as-is → to-be)
- Implement all code for ONE scenario
- Test the complete user-facing behavior
- Verify scenario works before proceeding
- Use simulator automation to verify UI
</anti_patterns>

<success_criteria>
Effective scenario-based development:
- Every change starts with written scenario (as-is → to-be)
- Scenarios are user-facing behaviors, not code tasks
- All code for a scenario is implemented together
- Complete scenario is tested end-to-end
- Automated testing when possible
- Manual verification in simulator
- Each scenario works before moving to next
- No more 3-hour debugging sessions
</success_criteria>
