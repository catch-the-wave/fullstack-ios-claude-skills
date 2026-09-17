<overview>
Classic UX laws as analytical tools — not inspiration, but evidence. Apply these to produce specific, measurable critiques instead of "this feels off."

Each law maps to a diagnostic question. Use the question to decide: does this design respect or violate the law? Then quantify the cost.
</overview>

<laws>

<law name="fitts">
**Fitts's Law** — Time to acquire a target = f(distance / size)

Acquisition time grows with distance and shrinks with target size. On mobile, the thumb defines the coordinate system.

**iOS-specific constraints:**
- Natural thumb arc: bottom 1/3 of screen, center-left/right sweep
- Danger zone: top corners, top center (requires full arm extension)
- Edge advantage: iOS edge gesture competes with any control near the left/right edge
- Minimum target: 44pt (HIG), comfortable target: 56pt+

**Diagnostic questions:**
- What is the primary action's distance from the thumb's resting position?
- Are frequent actions in the comfort zone (bottom 60% of screen)?
- Are destructive actions near frequently-hit targets?
- Does any toolbar control compete with system swipe-back (left edge, ~20pt)?

**Scoring:**
| Situation | Cost |
|-----------|------|
| Primary action in top bar | ~300ms extra per use |
| Target <44pt | Measurable miss rate increase |
| Destructive action adjacent to frequent action | Error rate increase |
| Action behind navigation gesture zone | Conflicts with system behavior |
</law>

<law name="hick">
**Hick's Law** — Decision time = log2(n+1) choices

Each additional option adds cognitive overhead. A toolbar with 9 items requires ~3.2 bits of decision-making. This overhead compounds: users paralyzed by choice abandon or make worse decisions.

**iOS-specific benchmarks:**
- Toolbar comfort zone: 3-5 visible actions
- 6-7 actions: noticeable overhead, consider grouping
- 8+ actions: decision paralysis territory, requires restructuring

**Diagnostic questions:**
- How many choices are visible simultaneously on this surface?
- Are any choices so similar users must pause to distinguish them?
- Does progressive disclosure exist, or is everything visible upfront?
- Are the most frequent actions presented without competition from rare ones?

**Scoring:**
| Count | Decision cost | Verdict |
|-------|--------------|---------|
| 1-3 | ~0.5-1.0 bits | Good |
| 4-5 | ~1.5-2.0 bits | Acceptable |
| 6-7 | ~2.5 bits | FRICTION |
| 8+ | 3+ bits | BROKEN — restructure required |

**Fix:** Progressive disclosure. Surface the 3 most frequent actions; put the rest behind a single "more" trigger.
</law>

<law name="miller">
**Miller's Law** — Working memory holds 7±2 chunks (or ~4 per modern research)

Users can't track more than ~4 discrete state changes, active selections, or simultaneous concerns at once. UI that requires holding more state than this forces users to externalise memory into the UI itself.

**Diagnostic questions:**
- How many things must the user hold in mind simultaneously to use this component?
- Does the current state of all relevant selections remain visible at all times?
- Are there flows where the user must remember a choice made on step 1 to interpret step 3?

**iOS patterns that respect Miller's Law:**
- Visible selection state (chips, check marks, fill color) — offloads to visual memory
- Single-task flows (one decision per screen) — reduces parallel chunk load
- Persistent context indicators (tag bar showing current tags, breadcrumb in navigation)

**Violations:**
- Multi-step modal flow where early choices affect later options, but early choices not visible
- Toolbar where selected state of multiple toggles must be mentally tracked simultaneously
- Filter systems where active filters disappear after applying
</law>

<law name="gestalt">
**Gestalt Principles** — Perception organises elements into groups before reasoning

Users perceive groups, relationships, and hierarchy before reading labels. Layout structure communicates meaning independent of content.

**Five principles most relevant to iOS:**

| Principle | Definition | iOS application |
|-----------|-----------|-----------------|
| **Proximity** | Near things belong together | Buttons near content they affect; destructive actions far from primary |
| **Similarity** | Same visual treatment = same category | All secondary actions share visual weight; primary breaks the pattern |
| **Continuation** | Eye follows lines and curves | Scroll direction implies there's more; toolbar alignment implies related controls |
| **Closure** | Mind completes incomplete shapes | Cards with partial content imply more below; truncation must be intentional |
| **Figure/Ground** | Foreground/background separation | Modal sheets signal "a separate layer"; overlays signal "temporary state" |

**Diagnostic questions:**
- Does proximity group actions by concern (not by accident of layout)?
- Do all actions in the same visual tier have the same weight and style?
- Is figure/ground clear — does the user know which surface is "active"?
- Does the layout imply false relationships through proximity or similarity?

**Common iOS violations:**
- Cancel and Confirm buttons with the same visual weight (similarity implies same-importance)
- Destructive action placed proximate to primary action (proximity implies relationship)
- Secondary actions that visually match primary (similarity implies equivalent importance)
</law>

<law name="jakob">
**Jakob's Law** — Users expect your app to behave like every other app they already know

Familiar patterns reduce learning cost to zero. Novel patterns require users to build a new mental model. Novelty is justified only when it solves a real problem — not when it's distinctive for its own sake.

**iOS convention inventory:**
- Back swipe from left edge (navigation)
- Pull-to-refresh on scroll views
- Swipe-to-delete on list rows
- Long-press for context menu
- Bottom sheet for transient actions
- Share sheet via system share button
- Settings in system Settings.app (not in-app for privacy/account)

**Diagnostic questions:**
- Does this interaction pattern match iOS convention? If not, what problem does the deviation solve?
- Would a new user who knows iOS but not this app understand this without instruction?
- Is any novel pattern consistently applied, or is it only in one place?

**When deviation is justified:**
The novel pattern must solve a real, demonstrated problem with the conventional pattern. "It looks different" or "it's our brand" are not justifications. The cost of teaching a new pattern must be paid by a real user benefit.

**When deviation is NOT justified:**
- Custom pull-to-refresh that looks identical to the system one but animated differently
- Swipe gesture that goes right-to-left instead of left-to-right for delete
- Bottom nav that doesn't follow tab bar conventions
</law>

<law name="doherty">
**Doherty Threshold** — Response must arrive within 400ms to feel immediate

Above 400ms, users perceive a gap. Above 1000ms, they lose context. Interaction that feels "heavy" or "laggy" erodes trust and discourages use — even when it works correctly.

**iOS response expectations:**
| Interaction | Target | Maximum |
|-------------|--------|---------|
| Tap response (visual feedback) | <16ms (next frame) | 100ms |
| Button state change | <100ms | 200ms |
| Content appearing after tap | <300ms | 400ms |
| Modal presenting | <300ms | 400ms |
| Search results updating | <200ms | 400ms |
| Any perceived "loading" state | must show progress | — |

**Diagnostic questions:**
- Does every tap produce visual feedback within one frame?
- Are any operations blocking the main thread?
- Do heavy operations show a loading state before 400ms?
- Does the animation duration itself exceed 400ms? (If so, it will feel slow regardless of actual performance)

**iOS-specific:** Spring animations with `duration > 0.4` often feel sluggish. Prefer `response: 0.3, dampingFraction: 0.7` for most interactions.
</law>

<law name="peak_end">
**Peak-End Rule** — Memory of an experience is dominated by its peak and its ending

Users don't evaluate flows by averaging all moments — they remember the most intense moment and the final moment. A 10-step flow with 9 smooth steps and one frustrating step is remembered as frustrating.

**Implications for iOS design:**
- The first and last screens of a flow carry disproportionate weight
- Error states are peaks — they define the experience if they occur
- Success states are endings — invest in them
- Friction in the "almost done" phase (confirmation, submission) damages the entire flow's perception

**Diagnostic questions:**
- What is the most intense (positive or negative) moment in this flow?
- What does the user see last? Is it satisfying or neutral?
- Are error states handled with clarity and a clear recovery path?
- Does the completion state feel rewarding?

**iOS patterns that apply this:**
- Things' confetti on task completion
- Linear's completion animation on closing an issue
- Duolingo's owl celebration on lesson completion
The "done" moment earns disproportionate investment.
</law>

</laws>

<application_protocol>
When auditing with UX laws, produce evidence-based verdicts, not subjective opinions.

**Template:**
```
Law violated: [Name]
Evidence: [Specific element or interaction]
Cost: [Quantifiable impact — bits of overhead, ms delay, error rate, etc.]
Fix: [Concrete change]
```

**What NOT to do:**
- "This violates Hick's Law" without counting the choices
- "Fitts's Law says this should be bigger" without measuring distance from thumb arc
- Invoking a law to justify a preference that isn't actually a violation

Laws are diagnostic tools, not aesthetic arguments. Use them to find real problems, not to rationalize preferred solutions.
</application_protocol>

<integration>
UX laws diagnose **user cost** (time, errors, cognitive load, memory burden).
CDN diagnoses **structural problems** (viscosity, hidden dependencies, premature commitment).
Action hierarchy diagnoses **organization violations** (junk drawer, premature surfacing, missing primary).

Use all three lenses in a full IA critique. UX laws answer "how expensive is this for the user?" CDN answers "what's structurally broken?" Action hierarchy answers "is the organization correct?"
</integration>
