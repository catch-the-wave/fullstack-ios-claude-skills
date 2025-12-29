# Workflow: Critique and Rate Design

<required_reading>
**Read these reference files NOW:**
1. references/philosophy.md
2. references/hig-principles.md
3. references/layout-spatial.md
4. references/typography.md
5. references/color-system.md
6. references/anti-patterns.md
</required_reading>

<process>
## Step 1: View the Design

**Ask user for:**
- Screenshot(s) to review
- Context (what is this? what's the goal?)
- Specific concerns or areas to focus on

**Read the image:**
- Use Read tool to view screenshot
- Study the visual hierarchy
- Note the interaction patterns
- Understand the information architecture

## Step 2: Evaluate Against Core Principles

### Consciousness & Minimalism
- [ ] **Is it minimal?** Could anything be removed?
- [ ] **Does it breathe?** Adequate white space?
- [ ] **Is it intentional?** Every element has purpose?
- [ ] **Does it feel calm?** Not overwhelming or chaotic?

**Score: /10**

### Visual Hierarchy
- [ ] **Clear primary action?** One obvious next step?
- [ ] **3 levels max?** Not too many competing elements?
- [ ] **Size + weight + color?** Hierarchy through contrast?
- [ ] **Scannable?** Can understand in 3 seconds?

**Score: /10**

### Typography
- [ ] **Text styles?** Appears to use 3-4 styles max?
- [ ] **Readable sizes?** Not too small (min 15-17pt body)?
- [ ] **Good contrast?** Dark on light, light on dark?
- [ ] **Proper weight?** Not too thin, not too heavy?

**Score: /10**

### Spacing & Layout
- [ ] **8pt grid?** Spacing appears consistent?
- [ ] **Generous margins?** Minimum 16pt from edges?
- [ ] **Aligned elements?** Clean grid, not random?
- [ ] **Breathing room?** Not cramped?

**Score: /10**

### Color
- [ ] **Restrained palette?** 1-2 accent colors max?
- [ ] **Semantic use?** Colors have meaning?
- [ ] **Good contrast?** Readable text?
- [ ] **Works in dark mode?** If shown?

**Score: /10**

### Interactions (if visible)
- [ ] **Touch targets?** Appear ≥44pt?
- [ ] **Tappable elements clear?** Obvious what's interactive?
- [ ] **States shown?** Pressed, selected, disabled?
- [ ] **Gestures discoverable?** If used?

**Score: /10**

### iOS Native Feel
- [ ] **Platform conventions?** Follows HIG patterns?
- [ ] **SF Symbols?** Uses system icons appropriately?
- [ ] **Native components?** Or well-designed custom?
- [ ] **Feels iOS?** Not Android or web-like?

**Score: /10**

### Accessibility (observable)
- [ ] **Color not only indicator?** Icons/text too?
- [ ] **Likely supports Dynamic Type?** Scalable text?
- [ ] **Touch targets adequate?** Buttons not tiny?
- [ ] **Clear labels?** Descriptive text?

**Score: /10**

## Step 3: Identify Specific Issues

**Categorize problems found:**

### 🔴 Critical Issues
- Major usability problems
- Accessibility blockers
- Unclear primary action
- Information overload

### 🟡 Important Issues
- Inconsistent spacing
- Typography hierarchy problems
- Color usage issues
- Touch target concerns

### 🟢 Nice to Have
- Microinteraction opportunities
- Polish refinements
- Minor spacing tweaks
- Enhancement ideas

## Step 4: Rate Overall Design

**Overall Score: X/10**

**Rating Scale:**
- **9-10**: Exceptional - Publication-worthy, inspiring
- **7-8**: Strong - Professional, polished, minor improvements
- **5-6**: Good - Solid foundation, needs refinement
- **3-4**: Needs Work - Significant issues, major revision needed
- **1-2**: Poor - Fundamental problems, start over

## Step 5: Provide Detailed Feedback

**For each issue, provide:**

### Issue Template

**❌ Problem: [Clear description]**

**Why it matters:**
- Impact on usability/UX
- Violates which principle
- User confusion/friction

**✅ Recommendation:**
```
Specific fix or alternative approach
```

**Example improvement:**
- Visual mockup description or
- Code example if applicable

## Step 6: Highlight What Works

**Don't just criticize - celebrate strengths:**

**✨ What's Working Well:**
- Specific elements that are excellent
- Good decisions made
- Strong aspects to preserve

## Step 7: Provide Inspiration

**Reference exemplary patterns:**
- "This is similar to [Things/Craft/Cosmos] approach"
- "Consider how [app] handles this"
- Show better examples from exemplary apps

## Step 8: Actionable Next Steps

**Prioritized improvements:**

1. **First (Critical):** Fix X, Y, Z
2. **Then (Important):** Address A, B, C
3. **Finally (Polish):** Consider D, E, F

**Quick wins:** Changes that have high impact, low effort

</process>

<critique_template>
## Design Critique: [Design Name]

### Overview
**What it is:** [Description]
**Goal:** [Purpose/intention]

### Scores

| Aspect | Score | Notes |
|--------|-------|-------|
| Consciousness & Minimalism | X/10 | |
| Visual Hierarchy | X/10 | |
| Typography | X/10 | |
| Spacing & Layout | X/10 | |
| Color | X/10 | |
| Interactions | X/10 | |
| iOS Native Feel | X/10 | |
| Accessibility | X/10 | |
| **Overall** | **X/10** | |

### What's Working ✨

1. **[Strength 1]**
   - Why it's good
   - Keep this approach

2. **[Strength 2]**
   - Why it works
   - Reference to principle

### Issues & Recommendations

#### 🔴 Critical

**1. [Issue Name]**

**Problem:** [Description]

**Impact:** [Why it matters]

**Fix:**
```
[Specific recommendation]
```

#### 🟡 Important

**2. [Issue Name]**
[Same format]

#### 🟢 Nice to Have

**3. [Enhancement]**
[Same format]

### Inspiration & References

- **Similar to:** [Exemplary app pattern]
- **Consider:** [Alternative approach]
- **Study:** [Specific feature in reference app]

### Next Steps

**Immediate (Fix first):**
1. [Action 1]
2. [Action 2]

**Important (Then address):**
1. [Action 3]
2. [Action 4]

**Polish (Finally):**
1. [Enhancement 1]
2. [Enhancement 2]

### Final Thoughts

[Overall assessment, encouragement, key insight]

</critique_template>

<rating_guidelines>
## How to Rate Fairly

**Be constructive, not destructive:**
- Critique the work, not the designer
- Explain why, not just what's wrong
- Provide actionable solutions
- Celebrate what works

**Consider context:**
- What's the goal? (MVP vs polished product)
- Who's the audience? (Internal tool vs consumer app)
- What are constraints? (Timeline, resources)
- What stage? (Concept vs final)

**Balance rigor with encouragement:**
- High standards, but supportive
- Specific improvements, not vague criticism
- Reference principles, not personal preference
- Focus on impact, not perfection

**Compare to exemplars:**
- Things, Craft, Cosmos, AI Writer level = 9-10
- Professional, polished = 7-8
- Solid, functional = 5-6
- Needs significant work = 3-4
- Fundamental issues = 1-2
</rating_guidelines>

<success_criteria>
A good design critique:
- Is specific and actionable
- Explains why, not just what
- Provides solutions, not just problems
- Celebrates strengths
- References principles and exemplars
- Prioritizes by impact
- Is constructive and encouraging
- Gives clear next steps
- Considers context
- Balances rigor with support
</success_criteria>
