---
name: ui-architecture-review
description: |
  Systematic critique of UI information architecture and interaction design. Challenges whether elements should exist, what belongs together, and whether the logical structure of a component is right. Use when reviewing input surfaces, toolbars, action bars, compose flows, menus, or any component where the STRUCTURE (not style) needs questioning. Triggers: "review this UI", "does this make sense", "challenge this design", "IA audit", "interaction critique", "what's wrong with this component", or when a design review focuses on pixels before questioning architecture.
---

<essential_principles>

**Structure precedes style.** If the information architecture is wrong, no amount of typography, haptics, or spring animations will fix it. This skill challenges logical structure before anyone touches pixels.

**Every element must justify its existence.** "Who needs this, how often, and what breaks if I remove it?" Elements that can't answer all three get killed or moved.

**Concerns don't mix.** Content creation, organization, media attachment, and mode switching are different concerns. Putting them in one flat menu creates a junk drawer, not a toolbar.

**Reference apps are evidence, not inspiration.** When Apple Notes, Things, Bear, Linear, and Notion all separate a concern the same way, that's a discovered pattern, not a style choice.
</essential_principles>

<objective>
Provide systematic interaction architecture critique grounded in Cognitive Dimensions of Notations (CDN), Bastien-Scapin Ergonomic Criteria, action-object analysis, and UICrit evaluation patterns.

This is the design equivalent of code review — challenge architecture, not aesthetics.
</objective>

<quick_start>
Given a component (code, screenshot, or description), run in this order:

1. **Element justification** — For each interactive element: who uses it, how often, what if removed? → KEEP / MOVE / MERGE / KILL
2. **Concern separation** — Are different concerns (creation, organization, attachment, destruction) mixed in one surface?
3. **Cognitive friction** — Apply CDN: viscosity, premature commitment, hidden dependencies, role expressiveness, diffuseness
4. **Action hierarchy** — Is there exactly ONE primary action? Are secondary actions same-concern? Are tertiary actions hidden?
5. **UX laws** — Apply relevant laws to quantify user cost: Hick's (choice count), Fitts's (target distance), Miller's (working memory load), Gestalt (false groupings), Doherty (latency perception)
6. **Reference check** — How do best-in-class apps solve this? What pattern emerges?
7. **Synthesis** — Recommended restructuring with rationale. Hand contradictions to TRIZ.

Read `references/` for detailed frameworks on each step.
</quick_start>

<reference_index>
Domain knowledge in `references/`:

| File | Content | Load when |
|------|---------|-----------|
| [cognitive-dimensions.md](references/cognitive-dimensions.md) | CDN framework — 9 dimensions with scoring rubric | Analyzing interaction friction |
| [action-hierarchy.md](references/action-hierarchy.md) | Primary/secondary/tertiary patterns + reference app evidence | Auditing control placement and menu structure |
| [ia-anti-patterns.md](references/ia-anti-patterns.md) | Junk drawer, false peers, concern mixing, premature surfacing + fixes | Diagnosing structural problems |
| [element-justification.md](references/element-justification.md) | Frequency-adoption matrix, kill criteria, Bastien-Scapin grouping rules | Deciding what should exist and what groups together |
| [ux-laws.md](references/ux-laws.md) | Fitts, Hick, Miller, Gestalt, Jakob's, Doherty, Peak-End — quantifiable user cost | Measuring user cost of structural decisions |
</reference_index>

<output_format>
```
## IA Critique: [Component Name]

### Element Justification
| Element | Who | Frequency | If removed? | Verdict |
|---------|-----|-----------|-------------|---------|

### Concern Map
[Which concerns are present? Are any mixed in one surface?]

### Cognitive Friction (CDN)
[FRICTION and BROKEN dimensions only — skip OK ones]

### Hierarchy Violations
[Primary/secondary/tertiary misplacements]

### UX Law Violations
| Law | Evidence | Cost |
|-----|----------|------|
[Only laws that are violated — skip compliant ones]

### Reference Comparison
[How 2-3 best-in-class apps solve this differently]

### Recommended Architecture
[Proposed restructuring with rationale]

### Open Contradictions
[Trade-offs that need /triz-product-architect]
```
</output_format>

<integration>
**Sequence for component design/review:**
1. **critique-interaction-architecture** (this) — Challenge structure. What should exist? Where?
2. **triz-product-architect** — If audit finds contradictions that restructuring alone can't resolve
3. **ios-design-lead** — Once structure is right, design visual/tactile expression
4. **ios-design-implementer** — Build it

**Anti-pattern this skill prevents:**
Reviewing typography, opacity, and haptics on a component whose information architecture is fundamentally wrong.
</integration>

<success_criteria>
A complete critique:
- Every interactive element has a justified KEEP/MOVE/MERGE/KILL verdict
- Concerns are mapped and separation violations identified
- CDN dimensions scored, with FRICTION/BROKEN items explained
- Action hierarchy audited against reference patterns
- At least 2 reference apps cited as evidence (not inspiration)
- Concrete restructuring proposed (not just "simplify this")
- Contradictions flagged for TRIZ if present
</success_criteria>
