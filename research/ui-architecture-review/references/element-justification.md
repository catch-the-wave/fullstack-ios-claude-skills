<overview>
Element justification framework. Before analyzing how elements relate, question whether each element should exist. Based on the feature audit matrix adapted for micro-components, combined with Bastien-Scapin's grouping/distinction criteria.
</overview>

<justification_matrix>
**Frequency-adoption matrix for UI elements:**

Map each interactive element by: (1) what % of sessions it's used, and (2) how frequently per session.

```
                    HIGH FREQUENCY
                         |
     CONTEXTUAL          |         PRIMARY
     (show when          |     (always accessible,
      relevant)          |      prominent placement)
                         |
  LOW ADOPTION ----------+---------- HIGH ADOPTION
                         |
        KILL             |         SECONDARY
     (remove or          |      (accessible but
      deep-bury)         |       not prominent)
                         |
                    LOW FREQUENCY
```

**Verdicts:**
- **PRIMARY** (high freq + high adoption): Must be instantly accessible. Permanent screen real estate justified.
- **SECONDARY** (low freq + high adoption): Everyone uses it sometimes. Accessible but not prominent — one tap away.
- **CONTEXTUAL** (high freq + low adoption): Power users need it a lot. Show when relevant (after trigger, in specific mode).
- **KILL** (low freq + low adoption): Remove entirely. Or bury 3+ taps deep. Don't let it occupy mental or visual space.

**The kill question:** "If this element didn't exist, what would the user do instead?" 
- If the answer is "something reasonable" → kill it
- If the answer is "be unable to complete their goal" → keep it
- If the answer is "use a different, existing path that works fine" → kill it
</justification_matrix>

<grouping_criteria>
**Bastien-Scapin: When elements belong together:**

Elements should share a surface when ALL of these are true:
1. **Same goal** — they serve the same user goal in the same moment
2. **Same temporal context** — they're used in sequence or simultaneously
3. **Same object** — they modify the same entity
4. **Same risk level** — they have similar consequences (all creative, or all destructive)

**When to separate:**

Separate elements into different surfaces when ANY of these are true:
1. **Different concerns** — content creation vs. organization vs. media vs. settings
2. **Different temporal context** — used at different moments in the flow
3. **Different risk levels** — mixing destructive with creative actions
4. **Different frequency bands** — mixing always-used with rarely-used
5. **Different audiences** — power user actions mixed with everyone actions
</grouping_criteria>

<action_object_analysis>
**Action-Object vs. Object-Action sequences:**

Mobile interfaces generally favor **object-action** patterns: select/focus an object first, then act on it. This reduces modal states.

**Object-action** (preferred for mobile):
- Tap text → formatting options appear
- Select card → swipe to reveal actions
- Focus input → relevant toolbar appears

**Action-object** (creates modality):
- Tap "format" → then select what to format (user is now in "format mode")
- Tap "+" → then pick what to add (user is now in "add mode")
- Toggle "task" → then type (user is now in "task mode")

**When action-object creates problems:**
- User forgets which mode they're in
- Actions available change based on invisible state
- Same gesture does different things in different modes

**Fix**: Reduce action-object patterns. Instead of "toggle task mode then type", let the user type and convert to task afterward. Instead of "expand menu then pick action", use a popover that doesn't change the main surface's state.
</action_object_analysis>

<audit_template>
**For each element in the component, fill this row:**

```
| Element | Who uses it? | How often? | What if removed? | Concern | Verdict |
|---------|-------------|------------|------------------|---------|---------|
```

**Concern categories** (use exactly these):
- **Input** — entering content (text field, voice recorder)
- **Commitment** — submitting/saving (send, save, done)
- **Formatting** — modifying content appearance (bold, list, indent)
- **Organization** — metadata and categorization (tag, collection, date)
- **Attachment** — adding non-text content (photo, file, camera)
- **Mode switch** — changing input type (task toggle, voice mode)
- **Navigation** — moving between surfaces (cancel, back, expand)
- **Destruction** — removing content (discard, delete, clear)

If one toolbar has elements from 3+ concern categories: **junk drawer alert**.
</audit_template>
