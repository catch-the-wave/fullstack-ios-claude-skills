<overview>
Cognitive Dimensions of Notations (CDN) — a framework for evaluating the usability of information structures and interactive systems. Developed by Green &amp; Petre. Provides shared vocabulary for interaction criticism.

Apply to any interactive component. Score each dimension: **OK** / **FRICTION** / **BROKEN**.
Focus analysis on FRICTION and BROKEN items.
</overview>

<dimensions>
<dimension name="viscosity">
**Resistance to change.** How much effort to modify or undo an input?

- **OK**: Tap to toggle, swipe to dismiss, immediate undo
- **FRICTION**: Must navigate away to change a setting made during input
- **BROKEN**: Cannot undo without discarding entire input

**Mobile input red flags:**
- Toggling a mode requires re-entering text
- No way to undo the last action without starting over
- Changing organization (tags, collection) requires leaving the compose flow
</dimension>

<dimension name="premature_commitment">
**Forced early decisions.** Does the UI require choices before the user has enough information?

- **OK**: Can add metadata (tags, type) at any point during or after input
- **FRICTION**: Must choose input type (text/voice/task) before starting
- **BROKEN**: Must organize (tag, categorize) before capturing content

**Mobile input red flags:**
- "What kind of note?" picker before the text field
- Must select collection before writing
- Mode selection that can't be changed mid-flow
</dimension>

<dimension name="hidden_dependencies">
**Invisible couplings.** Does acting on element A silently alter element B?

- **OK**: Each control's effect is visible and scoped
- **FRICTION**: Toggling task mode changes what the send button does (save vs. create task)
- **BROKEN**: Selecting a collection auto-applies tags the user didn't choose

**Mobile input red flags:**
- Mode switches that change behavior of other buttons without visual indication
- Tag selection that modifies collection assignment silently
- State that persists across sessions without being visible
</dimension>

<dimension name="role_expressiveness">
**Obviousness of purpose.** Can the user tell what each element does from its form alone?

- **OK**: Text label "Send" on a button, or universally understood icon (play/pause)
- **FRICTION**: Icon-only buttons that could mean multiple things (what does "+" do here?)
- **BROKEN**: Abstract icons with no tooltip, label, or contextual hint

**Mobile input red flags:**
- "+" button that could mean "add media", "add tag", "expand menu", or "create new"
- Icons without labels in a toolbar where actions aren't universally understood
- Same icon used for different functions in different states
</dimension>

<dimension name="closeness_of_mapping">
**Structure matches mental model.** Does the UI organization reflect how users think about the task?

- **OK**: Grouping by user goal (all formatting tools together, all organization tools together)
- **FRICTION**: Grouping by implementation (all "add" actions together regardless of what they add)
- **BROKEN**: Grouping by visual similarity (all circle buttons together)

**Mobile input red flags:**
- "Attach photo" and "Add tag" in the same menu (different concerns, same surface)
- Task toggle next to media picker (content type change vs. content addition)
- Actions grouped by "things you can do" rather than "goals you're pursuing"
</dimension>

<dimension name="diffuseness">
**Verbosity of the interface.** Does the UI use more elements than necessary to express an idea?

- **OK**: Minimal controls, each doing meaningful work
- **FRICTION**: Multiple buttons for variations of the same action
- **BROKEN**: 5+ buttons visible when 2 cover 95% of real use cases

**Mobile input red flags:**
- Expanded menu showing every possible action at once
- Separate buttons for camera, photo library, files (when one "attach" picker handles all)
- Both icon and text label for the same action in a space-constrained toolbar
</dimension>

<dimension name="error_proneness">
**Structure invites mistakes.** Does the layout encourage wrong taps or confusing sequences?

- **OK**: Destructive actions separated from creative actions, with distinct styling
- **FRICTION**: Discard and Send at similar visual weight in the same row
- **BROKEN**: Destructive action adjacent to primary action with similar appearance

**Mobile input red flags:**
- "Discard" next to "Send" at same size/prominence
- Cancel and confirm as adjacent same-styled buttons
- Easy to accidentally trigger recording or send
</dimension>

<dimension name="progressive_evaluation">
**Can the user check partial work?** Can they see what they have before committing?

- **OK**: Live preview of text, visible tag chips, waveform during recording
- **FRICTION**: Tags applied but not visible until after send
- **BROKEN**: No way to review content before it's saved

**Mobile input red flags:**
- Tags shown only in a picker, not visible on the compose surface
- Voice transcript not shown until recording ends
- Draft state that doesn't show enough of the content
</dimension>

<dimension name="abstraction_barrier">
**Implementation leaking through.** Do internal concepts appear in the UI?

- **OK**: User sees "thought", "task", "voice note" — their language
- **FRICTION**: User sees "capsule", "card", "collection" — system language
- **BROKEN**: User sees technical states like "draft", "expanded", "locked"

**Mobile input red flags:**
- State names from the code appearing in the UI
- Data model concepts (capsule, card) visible to users who think in "notes" and "thoughts"
- Mode names that describe implementation rather than user intent
</dimension>
</dimensions>

<scoring>
For each dimension, provide:
1. **Score**: OK / FRICTION / BROKEN
2. **Evidence**: Specific element or interaction that demonstrates the score
3. **Impact**: How this affects the user's primary task

Only report FRICTION and BROKEN in the final critique. OK dimensions are not worth mentioning.
</scoring>
