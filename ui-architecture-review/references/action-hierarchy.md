<overview>
Every interactive surface has a natural action hierarchy. The best mobile input surfaces enforce strict discipline: actions are distributed by necessity to the core task, not listed by capability.

Violations of this hierarchy are the most common source of "something feels off" in UI components.
</overview>

<hierarchy>
<level name="primary">
**The core goal of this surface.** There should be exactly ONE.

- **Placement**: Prominent, high-contrast, anchored position (typically bottom-right on mobile). Often mapped to keyboard return key.
- **Visual weight**: Highest contrast element. The only colored/filled button.
- **Count**: Exactly one. Multiple primaries = no primary.

**Reference evidence:**
| App | Primary action | Placement | Visual treatment |
|-----|---------------|-----------|-----------------|
| Linear | Create Issue | Bottom-right, filled accent | Only colored button |
| Things | Save (via keyboard) | Keyboard return key | No visible button needed |
| Apple Notes | Done | Top-right, text weight | Bold text, anchored |
| Telegram | Send | Right of text field, filled accent | Circle with arrow |
| Claude iOS | Send | Right of text field, filled accent | Circle with arrow |

**Audit question**: "Is there exactly ONE primary action? If I squint, which button draws my eye first?"
</level>

<level name="secondary">
**Contextual modifiers active during the task.** Format, tag, date, priority — things that modify the current input.

- **Placement**: Toolbar docked above keyboard, or inline toggles near content area. Always subordinate to primary.
- **Visual weight**: Low contrast, monochrome, smaller than primary. Often icon-only with learned meaning.
- **Constraint**: All secondary actions should serve the SAME concern. Mixed concerns = junk drawer.

**Reference evidence:**
| App | Secondary actions | Placement | Concern |
|-----|------------------|-----------|---------|
| Apple Notes | Bold, italic, list, indent, table | Toolbar above keyboard | All formatting |
| Notion | Text style, color, link, comment | Floating toolbar on selection | All formatting |
| Things | Date, tags, list, deadline | Toolbar above keyboard | All organization |
| Bear | H1, bold, italic, link, list | Toolbar above keyboard | All markdown formatting |
| Linear | Status, assignee, label, project | Side panel | All metadata/organization |

**Audit question**: "Are all secondary actions the same kind of thing? Would I describe them all with one verb?"
- Good: "Format text" (bold, italic, list)
- Good: "Organize" (tag, collection, date)
- Bad: "Do stuff" (format, attach photo, tag, record audio) — junk drawer
</level>

<level name="tertiary">
**Rare, destructive, or administrative actions.** Delete, share, settings, export — things most users rarely need during active input.

- **Placement**: Overflow menu (...), long-press gesture, navigation bar, or separate panel. Never on the main action surface.
- **Visual weight**: Minimal or hidden. Should not compete for attention with primary or secondary actions.
- **Access**: 1-2 taps away from main surface, but never accidentally triggerable.

**Reference evidence:**
| App | Tertiary actions | Access method |
|-----|-----------------|---------------|
| Bear | Note info, share, export, pin | Swipe or info (i) button |
| Notion | Page settings, delete, history | ... menu top-right |
| Things | Delete, move to project, duplicate | Long-press or swipe |
| Apple Notes | Share, lock, scan, find | ... menu or share sheet |
| Linear | Delete, archive, copy link | ... menu on issue |

**Audit question**: "Would a user need this during active input? If not, it's tertiary — hide it."
</level>
</hierarchy>

<media_attachment_pattern>
**How best apps handle "attach media" — a solved problem:**

The pattern across Telegram, iMessage, WhatsApp, Apple Notes, Notion, and Claude iOS is consistent:

1. Single "+" or attachment button on the compose surface
2. Tap opens a **system-level popover or sheet** showing: Camera, Photos, Files (and app-specific options)
3. The popover is a **separate surface** — not an inline expansion of the toolbar
4. After selection, media appears as a preview in the compose area

**Why this works**: Media attachment is an **interruption** of the compose flow (leave to pick, return with result). It deserves a separate surface, not inline real estate. Inline expansion competes with the text area — the user's primary focus.

**Anti-pattern**: Expanding the toolbar inline to show [Photo] [Camera] [File] [Audio] buttons. This:
- Wastes compose surface space
- Mixes media attachment with other toolbar actions
- Makes the toolbar feel like a junk drawer
- Duplicates what the system picker already does better
</media_attachment_pattern>

<mode_switching_pattern>
**Task toggle, voice mode, and other mode switches:**

Mode switches change the **nature** of the current input. They are neither secondary actions (they don't modify content) nor media attachments (they don't add content). They're a third concern.

**Best practice**: Mode switches should be:
- Visually distinct from content actions (different visual language)
- Persistent indicators (user sees current mode at all times)
- Low-friction to toggle (tap, not navigate)

**Reference evidence:**
| App | Mode switch | How it's expressed |
|-----|------------|-------------------|
| Things | Task vs. heading vs. checklist | Inline before text, tap to cycle |
| Notion | Block type (text, todo, heading) | / command palette or tap block handle |
| Apple Reminders | Priority, flag | Inline toggle icons below title |
| Linear | Issue type | Dropdown in header, not toolbar |
</mode_switching_pattern>

<diagnosis_checklist>
When auditing a component's action hierarchy:

1. Count primary actions. If more than one: **hierarchy violation**.
2. List all secondary actions. If they serve different concerns: **junk drawer**.
3. Check if any tertiary action is visible on the main surface: **premature surfacing**.
4. Check if media attachment is inline or a separate picker: **inline = anti-pattern**.
5. Check if mode switches are mixed with content actions: **concern mixing**.
6. Verify primary action has highest visual weight: **if not, visual hierarchy broken**.
</diagnosis_checklist>
