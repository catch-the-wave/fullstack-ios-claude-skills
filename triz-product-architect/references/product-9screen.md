# 9-Screen Product Analysis & Case Studies

## 9-Screen for Product Thinking

The 9-Screen (System Operator) is TRIZ's most underrated tool for product work.
It prevents solving yesterday's problem and reveals resources you haven't considered.

### Template

```
| Level / Time   | PAST                    | PRESENT                  | FUTURE                    |
|----------------|-------------------------|--------------------------|---------------------------|
| SUPERSYSTEM    | User's old workflow     | Current ecosystem        | Where ecosystem is heading|
| (Context)      | Previous tools/habits   | Competitors, OS, device  | Platform trends, AI shift |
|                |                         |                          |                           |
| SYSTEM         | Previous product state  | Current product          | Product after this change |
| (Product)      | Or competitor's current | What users actually do   | What we're designing      |
|                |                         |                          |                           |
| SUBSYSTEM      | Old components          | Current components       | Evolved components        |
| (Components)   | What we had before      | Architecture, features   | What needs to change      |
```

### How to Read the 9-Screen

**Horizontal (Time)**:
- Past → Present: What changed? What was gained/lost?
- Present → Future: What SHOULD change based on evolution trends?

**Vertical (Scale)**:
- Supersystem → System: What external forces shape the product?
- System → Subsystem: What internal constraints limit evolution?

**Diagonal insights** (most valuable):
- Past Supersystem → Future Subsystem: Old ecosystem patterns that should become embedded components
- Past Subsystem → Future Supersystem: Components that should graduate to ecosystem-level

### Key Questions Per Cell

| Cell | Ask |
|------|-----|
| Past Supersystem | "How did users solve this before our product existed?" |
| Present Supersystem | "What ecosystem does our product live in? What do users do before/after using us?" |
| Future Supersystem | "How will the ecosystem change? AI? New platforms? Behavior shifts?" |
| Past System | "What did the previous version look like? What did competitors look like?" |
| Present System | "What do users actually do (not what we designed for)?" |
| Future System | "What does the ideal version look like in 2 years?" |
| Past Subsystem | "What components did we have? What was the old architecture?" |
| Present Subsystem | "What are the current building blocks? Which is the weakest?" |
| Future Subsystem | "What components need to evolve? What new ones are needed?" |

---

## Product Evolution Patterns

### Feature Evolution S-Curve

Every feature follows this lifecycle:

```
Value
  |           ╭──── Maturity: Optimize, not add
  |         ╱
  |       ╱   Growth: Users adopt, iterate fast
  |     ╱
  |   ╱   Infancy: Users confused, high churn
  | ╱
  +──────────────────→ Time

Infancy:    "What is this?" → Focus on CLARITY
Growth:     "I want more"  → Focus on DEPTH
Maturity:   "It just works" → Focus on EFFICIENCY
Decline:    "There's better" → Focus on TRANSITION
```

**Product decision implications:**

| S-Curve Stage | What to Build | What NOT to Build |
|---------------|---------------|-------------------|
| Infancy | Clear value prop, simple UX | Power features, customization |
| Growth | Depth, workflows, integrations | Radical redesigns |
| Maturity | Performance, polish, efficiency | New features (users don't want them) |
| Decline | Migration path, data export | Anything — transition to next S-curve |

### UX Evolution Trends

| Trend | Stage 1 | Stage 2 | Stage 3 | Stage 4 |
|-------|---------|---------|---------|---------|
| **Input** | Typed | Tapped | Gestured | Anticipated |
| **Feedback** | Alert | Toast | Inline | Ambient |
| **Navigation** | Menu hierarchy | Flat tabs | Gesture/swipe | Contextual/AI |
| **Organization** | Manual folders | Tags | Smart groups | Auto-emergent |
| **Search** | Text match | Fuzzy match | Semantic | "You probably want..." |
| **Personalization** | Settings panel | Presets | Adaptive | Invisible |
| **Onboarding** | Tutorial screens | Contextual tips | Interactive guide | None (self-evident) |

---

## Case Studies: TRIZ Applied to Real Products

### Case 1: Mindcraft Card Interactions

**Contradiction**: Cards need actions (edit, relate, tag, delete) BUT card surface
must be minimal (no visible buttons, "too noisy").

**TRIZ Analysis**:
- Physical contradiction: Card must be **actionable** (many operations) AND **clean** (no visible affordance)
- Separation in Space: Actions live in a hidden dimension (swipe-reveal)

**Principles Applied**:
- #3 Local Quality: Different zones serve different functions (surface = read, left-swipe = actions, right-swipe = select)
- #17 Another Dimension: Actions exist in the swipe dimension, invisible at rest
- #6 Universality: Swipe gesture serves both navigation (reveal) AND selection (right-swipe)

**Result**: Two-threshold swipe system (72pt → Related, 144pt → Context) + right-swipe select.
Zero visible buttons. Full action capability.

**IFR Score**: 4/5 — Actions are available without visual noise. Not quite 5 because
thresholds still require learned behavior.

---

### Case 2: Search vs Browse (Generic Product Problem)

**Contradiction**: Users need to FIND specific items (search) AND DISCOVER
unexpected items (browse). Optimizing for one hurts the other.

**TRIZ Analysis**:
- Technical contradiction: Improving findability (#33 ease of operation for search) worsens discoverability (#35 adaptability for browse)
- Physical contradiction: Content must be **ordered** (for search) AND **surprising** (for discovery)

**Separation Approaches**:
- In Time: Search when user has intent, browse when user is exploring (detect from behavior)
- In Space: Search results in main view, discovery in sidebar/related section
- In Condition: Empty query = browse mode, typed query = search mode

**Principles Applied**:
- #15 Dynamics: Interface adapts based on whether user is searching or browsing
- #3 Local Quality: Search results are precise; "related" section is serendipitous
- #13 Inversion: Don't make user choose mode — infer from their actions

**Result**: Contextual search where empty state = discovery feed, typed state = precise results.
Tag taps in search = additive filter (refine), tag taps elsewhere = navigate (discover).

---

### Case 3: Simple vs Powerful (The Eternal Product Contradiction)

**Contradiction**: Product must be **simple enough for new users** AND **powerful
enough for expert users**.

**TRIZ Analysis**:
- Physical contradiction: Interface must be **minimal** (new users) AND **feature-rich** (experts)
- This is THE defining contradiction of product design

**Separation Approaches**:
- **In Condition** (most common): Detect user expertise, adapt interface
  - Things 3: Simple surface, keyboard shortcuts for power users
  - Notion: Slash commands reveal depth without cluttering surface
  - Arc: Simple browsing, command bar for everything else

- **In Time** (progressive): Start simple, reveal over time
  - Linear: Basic at first, unlocks features as user demonstrates proficiency
  - GitHub Copilot: Suggestions get more complex as user accepts more

- **In Space** (layered): Simple surface, depth on demand
  - iOS Settings: Main list is simple, sub-menus go deep
  - Mindcraft: Card is clean, swipe reveals depth, related cards reveal connections

- **In Scale** (different granularity): Simple at overview, powerful at detail
  - Photos: Grid is simple, editing tools are powerful
  - Maps: Overview is clean, zoom reveals detail

**Best resolution pattern**: **In Space + In Condition combined** — layer depth
behind interaction (space), and adapt which depth levels show based on usage
patterns (condition).

---

### Case 4: Privacy vs Personalization

**Contradiction**: Better personalization requires more data, but collecting more
data worsens privacy.

**TRIZ Analysis**:
- Technical contradiction: Improving personalization (#35) worsens privacy (#31 harmful factors)

**Principles Applied**:
- #2 Taking Out: Process data on-device, never send it (Apple's approach)
- #26 Copying: Use aggregate patterns (copies of behavior), not individual data
- #35 Parameter Changes: Transform raw data into embeddings (can't be reversed to original)
- #10 Preliminary Action: Compute personalization locally before any sync

**Result**: Local-first AI. Embeddings computed on-device. Personalization happens
without data leaving the device. Privacy AND personalization without compromise.

---

### Case 5: Real-time Sync vs Battery Life

**Contradiction**: Users want instant sync across devices, but constant sync
drains battery.

**TRIZ Analysis**:
- Technical contradiction: Improving sync speed (#9) worsens energy use (#19)

**Principles Applied**:
- #19 Periodic Action: Sync on meaningful events (save, close, switch), not continuously
- #15 Dynamics: Adaptive sync frequency (more frequent on WiFi+charging, less on battery)
- #10 Preliminary Action: Pre-sync likely-needed data during charging
- #22 Blessing in Disguise: Offline periods create natural conflict-free windows

**Result**: Event-driven sync + adaptive frequency + opportunistic pre-sync.
Feels real-time, uses fraction of the battery.

---

## Quick Decision Framework

When facing a product decision:

```
1. STATE the contradiction clearly
   "If we [A], then [B worsens]"

2. CHECK: Is it a real contradiction?
   → Can you have A without affecting B? Then no contradiction, just do it.
   → Is B actually acceptable? Then no contradiction, accept the trade-off.

3. MAP to product parameters (product-lens.md)

4. TRY separation first (for physical contradictions)
   → In Time? In Space? In Condition? In Scale?

5. TRY principles (for technical contradictions)
   → Check the "Common Product Contradictions" table
   → Apply top 2-3 principles, generate concrete solutions

6. EVALUATE against IFR
   → Does the solution approach the ideal?
   → Does it create new contradictions?
   → Would Fuller approve?

7. If stuck → escalate to full ARIZ via /triz skill
```
