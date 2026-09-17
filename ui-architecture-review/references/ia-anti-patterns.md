<overview>
Common information architecture anti-patterns in mobile UI components. Each pattern includes the symptom, root cause, and fix. Based on Bastien-Scapin ergonomic criteria, UICrit evaluation patterns, and observed failures in production apps.
</overview>

<anti_patterns>
<pattern name="junk_drawer">
**Symptom**: A menu or toolbar contains unrelated actions grouped only because "we needed a place for them."

**Root cause**: Adding features incrementally without questioning where they belong. Each new feature gets added to the existing toolbar.

**Example**: An input bar's "+" menu containing: [Task] [Tag] [Photo] [Mic]. These are four different concerns (mode switch, organization, media attachment, recording mode) in one flat list.

**Diagnosis questions:**
- Can you describe all items with one verb? ("Format", "Organize", "Attach") If not: junk drawer.
- Would removing any item change the category of the others? If not: they don't belong together.

**Fix**: Split by concern into separate surfaces:
- Mode switches → inline toggles near text
- Organization → tag picker (dedicated surface)
- Media attachment → system popover
- Voice → dedicated gesture (hold mic)
</pattern>

<pattern name="false_peers">
**Symptom**: Items at the same visual level have fundamentally different importance, frequency, or risk.

**Root cause**: Uniform styling applied to a heterogeneous group. All buttons same size, same style.

**Example**: "Discard" and "Send" as same-sized buttons in one row. Discard is destructive and rare. Send is constructive and primary. Same visual treatment = false peers.

**Fix**: Primary gets accent color and larger hit area. Destructive gets text-only treatment, separated spatially. Never adjacent same-weight buttons for actions with asymmetric consequences.
</pattern>

<pattern name="premature_surfacing">
**Symptom**: A rarely-used action occupies permanent screen real estate.

**Root cause**: "What if the user needs it?" fear-driven design. Feature parity with competitors.

**Diagnosis**: Use the frequency-adoption matrix (see element-justification.md). If an action is low-frequency AND narrow-adoption, it has no business being visible.

**Example**: A "Photo" button permanently visible in an input toolbar when 95% of inputs are text-only. The button is visible 100% of the time but used 2% of the time.

**Fix**: Move to overflow, contextual reveal, or system picker. The space it occupied should serve a high-frequency action or not exist.
</pattern>

<pattern name="concern_mixing">
**Symptom**: One toolbar or menu serves multiple unrelated user goals.

**Root cause**: Implementation-driven grouping ("these are all toolbar actions") rather than user-goal-driven grouping ("these all help me format text").

**Example**: A compose toolbar with [Bold] [Photo] [Tag] [Send]. Bold = formatting. Photo = attachment. Tag = organization. Send = commitment. Four concerns in one row.

**Diagnosis**: List the concern each action serves. If you need more than one category label, concerns are mixed.

**Fix**: Separate surfaces per concern:
- Formatting → keyboard toolbar
- Attachment → popover from + button
- Organization → tag row or picker
- Commitment → anchored primary button
</pattern>

<pattern name="modal_creep">
**Symptom**: Too many mode switches in one component, each changing behavior in non-obvious ways.

**Root cause**: Features accumulated as modes rather than integrated into the flow.

**Example**: An input bar with: text mode, task mode, voice mode, expanded mode, draft mode, locked mode — each with different button layouts, different send behavior, and different available actions.

**Diagnosis**: Count the modes. If a user must learn different button meanings per mode: modal creep.

**Fix**: Reduce modes. Ask: "Can this mode be eliminated by making the feature work in all modes?" Voice recording doesn't need a mode — it's a gesture. Task doesn't need a mode — it's a prefix. Expanded doesn't need a mode — it's a state of the same surface.
</pattern>

<pattern name="inline_expansion">
**Symptom**: Tapping a button expands a toolbar inline, pushing other elements around and competing with the content area.

**Root cause**: Avoiding system popovers or sheets because "everything should be in the pill."

**Example**: "+" expands to reveal [x] [Task] [Tag] [Photo] [Mic] inline, shrinking the space available for the text display.

**Diagnosis**: Does the expanded state reduce the content area or displace other controls? If yes: inline expansion problem.

**Fix**: Secondary actions that need a list belong in a **separate surface** (popover, sheet, keyboard toolbar). The compose surface's job is to show content, not to show menus.
</pattern>

<pattern name="icon_ambiguity">
**Symptom**: Icon-only buttons in a context where the icons aren't universally understood.

**Root cause**: Visual minimalism overriding usability. "Icons look cleaner."

**Example**: [+] [checkmark.circle] [#] [photo] [mic] — requires learning what each icon means in this specific context. "+" is particularly ambiguous (add what?).

**Diagnosis**: Show the icon to someone unfamiliar with the app. If they can't guess the action: ambiguous.

**Fix options:**
- Text labels (monospaced for instrument feel)
- Icon + label (if space allows)
- Reduce to icons that ARE universally understood (mic, camera, send) and use text for the rest
- Use the icon only after the user has learned it (progressive reduction)
</pattern>
</anti_patterns>
