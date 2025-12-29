# User Scenario Template

Copy and fill this template for every scenario:

```markdown
## User Scenario: [Clear, Action-Oriented Name]

**As-is:**
[What currently happens - be specific about current behavior]
[Include what user sees, what they can/can't do]

**To-be:**
[What should happen - be specific about desired behavior]
[Include interaction details: tap, swipe, type, drag, etc.]
[Include visual feedback: animations, colors, transitions, haptics]
[Include system responses and state changes]

**Acceptance criteria:**
- [ ] User can [specific action] and sees [specific result]
- [ ] System responds with [behavior] when [condition]
- [ ] Edge case: [specific edge case] is handled by [approach]
- [ ] Visual: [UI element] appears/animates with [style/timing]
- [ ] Accessibility: [VoiceOver announces X, supports Dynamic Type, etc.]
- [ ] Performance: [Loads in <X seconds, animates at 60fps, etc.]

**Files to modify:**
- [List expected files - helps scope work]
- [Helps understand impact and dependencies]

**Dependencies:**
- [List scenarios this depends on, if any]
- [Note: implement dependencies first]

**Testing approach:**
- [ ] Automated UI test (preferred)
- [ ] Manual simulator test with screenshots
- [ ] Device test for performance/haptics

**Verification:**
After implementation, verify:
- [ ] All acceptance criteria met
- [ ] No regressions in existing features
- [ ] Edge cases handled gracefully
- [ ] Animations feel natural (springs, 0.3s standard timing)
- [ ] Accessible (VoiceOver, Dynamic Type, contrast)
- [ ] Screenshot matches design intent
```

## Example: Complete Scenario

```markdown
## User Scenario: Add Tags to Thoughts

**As-is:**
User types in thought input field (ThoughtInputView).
No tag support exists.
Tags concept doesn't exist in data model.

**To-be:**
When user types "#" character in input field, tag entry mode activates.
Tag suggestions dropdown appears below cursor showing existing tags.
User can continue typing to filter suggestions or create new tag.
Pressing Enter or selecting suggestion adds tag as blue pill below input.
Tag pills show tag name with X button to remove.
Tags are saved with thought and persist across app restarts.

**Acceptance criteria:**
- [ ] User types "#" and sees tag suggestions appear with 200ms fade-in
- [ ] Suggestions show existing tags matching typed text
- [ ] Pressing Enter adds tag and clears input back to normal mode
- [ ] Tag appears as blue pill (blue.opacity(0.2) bg, 8pt radius, 8pt h-padding, 4pt v-padding)
- [ ] Multiple tags can be added, displayed horizontally with 4pt spacing
- [ ] Tapping X on tag pill removes it with haptic feedback
- [ ] Tags are persisted in ThoughtModel and saved to storage
- [ ] VoiceOver announces "Tag [name] added" and can navigate pills
- [ ] Edge case: Empty tag name is rejected
- [ ] Edge case: Duplicate tags are not added twice
- [ ] Edge case: Very long tag names are truncated with ellipsis

**Files to modify:**
- ThoughtInputView.swift (add tag UI and logic)
- TagInputView.swift (new - tag suggestions dropdown)
- TagPillView.swift (new - tag display component)
- ThoughtModel.swift (add tags: [String] property)
- ThoughtStore.swift (update persistence to include tags)

**Dependencies:**
- None (first scenario in tag system)

**Testing approach:**
- [x] Automated UI test: testUserCanAddTagByTypingHash()
- [x] Manual simulator test with before/after screenshots
- [x] Device test for haptic feedback on tag removal

**Verification:**
After implementation, verify:
- [x] All acceptance criteria met
- [x] No regressions (normal text input still works)
- [x] Edge cases handled (empty, duplicate, long names)
- [x] Spring animation on pill appearance (0.3s, bounce: 0.3)
- [x] VoiceOver announces tags correctly
- [x] Screenshot shows blue pills matching design
```
