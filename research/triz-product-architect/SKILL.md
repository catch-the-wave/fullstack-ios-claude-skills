---
name: triz-product-architect
description: |
  TRIZ-powered product architecture and design decisions. Use when facing product trade-offs ("more features vs simplicity"), choosing between design approaches, resolving UX contradictions, making architecture decisions, or when the user says "TRIZ", "trade-off", "contradiction", "can we have both", "approach A vs B", or asks you to evaluate competing design directions. NOT for generic engineering — this is for product craft.
---

<objective>
Resolve product contradictions instead of compromising between them.

When product people say "we need to balance X and Y," TRIZ says: **wrong frame.
There's a way to get both.** Find it.

This skill turns trade-off thinking into breakthrough thinking for product
architecture, UX design, feature strategy, and technical decisions.
</objective>

<ethos>
"The ideal product feature delivers its value WITHOUT the user having to
interact with it." — That's IFR applied to product.

Fuller said: "Can ONE element do TWO jobs?" That's TRIZ Principle #6.
Rams said: "Less, but better." That's increasing ideality.
Teenage Engineering ships instruments, not apps. That's IFR made real.

TRIZ isn't a methodology checkbox. It's a lens that reveals the solution
space your intuition can't see.
</ethos>

<when_to_use>
| Signal | Example | TRIZ Tool |
|--------|---------|-----------|
| "Should we do A or B?" | "Tabs vs sidebar?" | Contradiction → Both |
| "If we add X, Y gets worse" | "More settings = more complexity" | Technical Contradiction |
| "It needs to be X AND not-X" | "Simple for beginners, powerful for experts" | Physical Contradiction → Separation |
| "What should this feature become?" | "How should search evolve?" | 9-Screen + Evolution Trends |
| "We're stuck, nothing works" | "Every approach has fatal flaws" | ARIZ (systematic escalation) |
| "Which architecture?" | "Local-first vs cloud-first?" | Morphological + Contradiction |
| Choosing between 2-3 designs | "Option A is fast but fragile" | Multi-contradiction resolution |
</when_to_use>

<workflow>
## Step 0: Frame — Is This Actually a Contradiction?

Before applying TRIZ, verify:
- **Real contradiction**: "Improving A genuinely worsens B" → Use TRIZ
- **Resource constraint**: "We can't afford both" → Not TRIZ (it's budgeting)
- **Preference conflict**: "Stakeholder wants X, user wants Y" → Not TRIZ (it's alignment)
- **False dilemma**: "We assumed A and B are linked but they're not" → Reframe, no TRIZ needed

If it's a real contradiction, proceed.

## Step 1: IFR — Define the Impossible Ideal

> "The [feature/system] ITSELF [delivers value] WITHOUT [cost/complexity/friction]"

**Product IFR templates:**
- "The navigation itself reveals the right content without the user searching"
- "The onboarding itself teaches the app without a tutorial"
- "The data model itself stays consistent without sync logic"
- "The UI itself adapts to the user without settings"

**Why IFR first**: It prevents premature compromise. You can't find a breakthrough
if you've already accepted the trade-off as inevitable.

## Step 2: Identify the Contradiction

**Technical Contradiction** (improving A worsens B):
```
"If we [add/improve A], then [B gets worse]"
```
Map A and B to product parameters (see references/product-lens.md).

**Physical Contradiction** (same element needs opposite properties):
```
"[Element] must be [Property] for [use case X]
AND [Opposite] for [use case Y]"
```

**Product examples:**
- Technical: "More personalization → more privacy concern"
- Physical: "Search must be visible (discoverability) AND invisible (clean UI)"

## Step 3: Resolve

**For Technical Contradictions:**
1. Map to product parameters (references/product-lens.md)
2. Identify relevant principles (top 15 for product work listed in references)
3. Generate 2-3 concrete solutions per principle
4. Evaluate: Does it approach IFR?

**For Physical Contradictions — Separation:**
| Separation | Product Translation | Example |
|------------|---------------------|---------|
| **In Time** | Different moments in user journey | Search bar: prominent when empty, minimal when browsing |
| **In Space** | Different screens/views/layers | Power settings in deep menu, essentials on surface |
| **In Condition** | Different user states/contexts | Beginner mode vs expert mode (auto-detected) |
| **In Scale** | Different zoom levels/granularity | Overview shows clusters, detail shows individual items |

## Step 4: Validate Against IFR

For each solution, score:
1. **Ideality**: Does it increase benefits while reducing cost+harm?
2. **Elegance**: Would Fuller approve? Does one element do two jobs?
3. **Invisibility**: Does the user notice the mechanism, or just the value?
4. **Buildability**: Can we ship this in the current architecture?

## Step 5: 9-Screen Check (Optional but Powerful)

Before committing, zoom out:

| Level / Time | PAST | PRESENT | FUTURE |
|-------------|------|---------|--------|
| **Supersystem** | User's workflow before | Current ecosystem | Where ecosystem is heading |
| **System** | Previous version / competitor | Current product state | Product after this change |
| **Subsystem** | Old components | Current components | Components after evolution |

This reveals:
- Whether you're solving yesterday's problem
- Whether the solution aligns with where things are heading
- Hidden resources in the supersystem you haven't used
</workflow>

<product_evolution>
## Evolution Trends for Product Decisions

When deciding "what should this become?", check where you are on these curves:

| Trend | Evolution Path | Product Example |
|-------|---------------|-----------------|
| **Dynamism** | Static → Configurable → Adaptive → Anticipatory | Fixed layout → User-arranged → Auto-arranged → Pre-arranged before you need it |
| **Ideality** | Feature exists → Feature is effortless → Feature is invisible | Manual save → Auto-save → No concept of "saving" |
| **Segmentation** | Monolithic → Modular → Granular → Atomic | One editor → Multiple editors → Inline editing → Everything is editable in-place |
| **Micro-level** | Explicit → Implicit → Ambient | Tap to act → Gesture to act → Context triggers action |
| **Complexity arc** | Simple → Feature-rich → Integrated-simple | Notes app → Notion → (next: invisible organization?) |
| **Automation** | Manual → Assisted → Automated → Autonomous | Manual tags → Suggested tags → Auto-tags → Tags emerge from usage patterns |
| **Controllability** | One-size → Preferences → Adaptive → Learns | Same for all → User configures → Adapts to behavior → Anticipates needs |

**S-Curve positioning**: Is this feature in infancy (invest), growth (scale),
maturity (optimize), or decline (replace)?
</product_evolution>

<output_format>
## TRIZ Product Analysis: [Decision/Problem Name]

### IFR
"The [system] itself [delivers X] without [Y]"

### Contradiction
- **Type**: Technical / Physical
- **Statement**: "If [A], then [B worsens]" or "[Element] must be [X] and [not-X]"
- **Product Parameters**: [Mapped from references/product-lens.md]

### Resolution
| Approach | Principle(s) | How It Works | IFR Score | Elegance | Buildability |
|----------|-------------|--------------|-----------|----------|-------------|
| [Name] | #N [Name] | [Concrete description] | [1-5] | [1-5] | [1-5] |

### Recommendation
**Primary**: [Approach name]
- Why: [Rationale tied to IFR]
- What makes it TRIZ-good: [Which contradiction it resolves, not compromises]

**If blocked**: [Fallback approach]

### Evolution Check
- Current position on S-curve: [stage]
- Next evolution step: [prediction]
- Does this solution move us forward on the curve? [yes/no + why]
</output_format>

<integration>
## How This Skill Connects to Your Process

**Design Thinking (MEMORY.md rules):**
- "NEVER just extend existing patterns" → TRIZ's IFR forces you to question the frame
- "Always generate 2-3 fundamentally different approaches" → TRIZ principles generate structurally different solutions, not variations
- "Apply Fuller deeply" → Fuller IS Principle #6 (Universality). TRIZ makes Fuller systematic.
- "Can ONE element do TWO jobs?" → That's the core of increasing ideality

**When to reach for this skill vs others:**
- **ios-design-lead**: HOW it looks and feels → after TRIZ decides WHAT to build
- **mindcraft-advisor**: WHY users need it → feeds INTO the contradiction definition
- **system-architect**: HOW to build it technically → after TRIZ resolves the architectural contradiction
- **triz-product-architect** (this): WHAT to build when faced with competing approaches

**Escalation path:**
1. Simple trade-off → Contradiction Matrix (2 min)
2. Deeper analysis → Full workflow with 9-Screen (15 min)
3. Nothing works → ARIZ algorithm via installed `/triz` skill (30+ min)
4. Need design space exploration → `/morphological-analysis-triz` skill

This skill handles steps 1-2. For 3-4, it hands off to the installed TRIZ skills
with a properly framed problem statement (which is half the battle).
</integration>

<references_index>
| File | Content |
|------|---------|
| [product-lens.md](references/product-lens.md) | Product parameter mapping, top 15 principles for product work, common product contradictions |
| [product-9screen.md](references/product-9screen.md) | 9-Screen templates for product analysis, evolution patterns, real product case studies |

**For full TRIZ methodology** (40 principles, 39 parameters, ARIZ, Su-Field):
→ Use installed skills at `~/.agents/skills/triz/` and `~/.agents/skills/morphological-analysis-triz/`
</references_index>

<intake>
What product decision are you wrestling with?

Describe:
1. What you're trying to achieve
2. What's blocking you or what trade-off feels inevitable
3. Any approaches you've already considered

I'll identify the contradiction and find the resolution that doesn't compromise.
</intake>
