<overview>
Visual slop: the set of design decisions that make AI-generated iOS interfaces look generic, averaged, and unmemorable. These are patterns that emerge when an agent optimizes for "looks like an app" rather than "solves a real problem with conviction."

This is an enumerable checklist — not philosophy. Run it against any design before calling it done.
</overview>

<slop_checklist>

<category name="typography_slop">
**Typography Slop**

| Slop | Symptom | Fix |
|------|---------|-----|
| All SF Pro, no variation | Every text element at `.body` or `.headline` with no weight drama | Pick 2-3 weight/size combinations that form a clear hierarchy. The heading should be obviously heavier than the body. |
| Title and label same size | `.headline` header, `.subheadline` label, both 15-17pt — no drama | The primary element should be 1.5-2× the size of supporting text |
| Caption gray everywhere | All secondary text is `Color.secondary` — flat, undifferentiated | Use weight and size variation instead of lightening color. Reserve gray for truly subordinate metadata |
| No white space between type | Text blocks crammed together with `.padding(8)` everywhere | Typography breathes. Double the spacing until it looks too loose, then pull back by 20% |
| Custom font for "character" | Adding a display font that doesn't match the app's DNA | SF Pro is correct for most iOS apps. Add a custom font only when the app's identity demands it |
</category>

<category name="color_slop">
**Color Slop**

| Slop | Symptom | Fix |
|------|---------|-----|
| Generic blue CTA | Primary button is `Color.blue` or the default system accent | Define a single accent color rooted in the app's identity. Blue is fine only if it's intentional |
| Two accent colors | Primary blue button + orange badge + green success indicator | One accent color. Status (success/error) uses semantic system colors, not brand colors |
| Dark mode as color inverse | Light mode: white bg, dark text. Dark mode: black bg, white text, no adaptation | Use semantic colors and material backgrounds. Dark mode has its own palette — it's not RGB inversion |
| Shadow on shadow | Card shadow + container shadow + element shadow = muddy depth | One shadow tier per elevation level. Flat surfaces have no shadow |
| Gradient abuse | Gradient background + gradient button + gradient card = visual chaos | Gradients are decoration. Use one, purposefully, or none |
| Opacity soup | Multiple layers at .7, .8, .85 opacity stacked — muddy, unintentional | Use `.ultraThinMaterial` / `.thinMaterial` for intentional blur. Avoid arbitrary opacity chains |
</category>

<category name="layout_slop">
**Layout Slop**

| Slop | Symptom | Fix |
|------|---------|-----|
| Cards inside cards | Card component containing another card component as a child | Flatten. A card is a unit. If you need sub-items, use rows, not nested cards |
| Equal corner radius everywhere | `cornerRadius(12)` on every element — container, card, button, badge | Corner radius should correlate with element size. Large containers: 16-20pt. Small elements: 8-10pt. Buttons: match the container they live in |
| Every list item a card | `RoundedRectangle` background on every list row — heavy, cluttered | Cards for standalone entities. Rows for items in a list. Only one card-like treatment per hierarchy level |
| 16pt padding as default | `.padding(16)` everywhere — correct but uniform, no rhythm | Build a spacing vocabulary: 4/8/12/16/24/32pt. Use intentionally. Tighter inside components, looser between sections |
| Full-width primary button | One massive blue button spanning the screen — generic, low-prestige | Consider smaller, purposeful placement. Right-anchored, or floating where the action happens |
| Centered everything | Center-aligned text + centered buttons + centered icons = no visual direction | Left-align most text content. Reserve centering for truly standalone elements (empty states, confirmations) |
</category>

<category name="component_slop">
**Component Slop**

| Slop | Symptom | Fix |
|------|---------|-----|
| Chevron on every row | `>` on every list row regardless of destination type | Only use chevron when navigating to a detail screen. Toggles, pickers, and actions don't get chevrons |
| Dividers between every row | Separator lines throughout a list — visual noise, dated pattern | Use grouping and spacing instead of dividers. If dividers are needed, `.listStyle(.insetGrouped)` handles this natively |
| Placeholder text as hint | Placeholder text doing the work of a label — disappears on input | Labels live above or beside the field. Placeholder is for format hints only ("e.g., example@email.com") |
| Alert for every confirmation | `Alert` for every destructive action — modal, disruptive | Use inline confirmation (swipe to delete → "Confirm?" inline) or contextual button state change for low-stakes actions |
| Empty state with just text | "No items yet" centered on screen with a generic SF Symbol | Empty states should direct action. What should the user do? Show the first-step CTA in the empty state |
| Toggle on everything | Every preference is a toggle regardless of what it controls | Toggles for binary on/off. Segment controls for mutually exclusive choices. Steppers for quantities. Match control to semantic |
</category>

<category name="motion_slop">
**Motion Slop**

| Slop | Symptom | Fix |
|------|---------|-----|
| `.linear` animations | Linear easing on all transitions — robotic, unnatural | Springs for everything physical (expanding, moving). `.easeOut` for content fading in. Never `.linear` for UI motion |
| All animations same duration | Every animation at `0.3s` — monotone, no rhythm | Micro-interactions: 0.15-0.2s. State transitions: 0.25-0.35s. Page transitions: 0.35-0.45s |
| Animation without haptic | Visual state change with no tactile confirmation — feels hollow | Every significant action earns a haptic. Match haptic intensity to action weight |
| Haptic without visual | Vibration that precedes the visual change — disconnect | Haptic fires exactly at the visual moment, not before |
| Animate everything | Entrance animation + state animation + exit animation on every element | Animation earns attention. Reserve it for the primary action and significant state changes |
| Spring that overshoots too much | `dampingFraction: 0.5` — bounces three times, feels toy-like | Prefer `dampingFraction: 0.7-0.8` for production UI. Reserve low damping for explicit "bouncy" character moments |
</category>

<category name="content_slop">
**Content Slop (UX Writing)**

| Slop | Symptom | Fix |
|------|---------|-----|
| "Cancel" on every dismiss | "Cancel" as the dismiss label in every sheet/modal | Use the specific action: "Discard Draft", "Keep Editing", "Remove". Cancel is generic |
| "Error occurred" | `"An error has occurred. Please try again."` | Tell the user what happened and what to do: "Couldn't save — check your connection and tap Retry" |
| Button says "Submit" | Primary button labeled "Submit", "OK", "Confirm" | Button label = the action: "Save Note", "Add to Collection", "Send Message" |
| Header repeats nav title | Screen title in nav bar + same title as first element on screen | One place for the title. Either the nav bar or the page header, not both |
| Tooltip as excuse | Adding tooltip to explain a confusing control | If it needs a tooltip, the control is wrong. Fix the affordance, not the explanation |
| Passive voice in errors | "Your file could not be uploaded" | Active, direct: "Upload failed — file too large (max 25MB)" |
</category>

</slop_checklist>

<audit_protocol>
Run this as a checklist against any design. For each category, mark:
- **CLEAN** — no slop instances found
- **SLOP** — specific instance identified, fix required

Report only SLOP items. CLEAN categories don't need mention.

**Minimum bar before shipping:**
- Typography: clear 3-tier hierarchy (heading / body / caption) with size OR weight variation
- Color: one accent, semantic for status, no gradient unless intentional
- Layout: no nested cards, corner radius varies by element size
- Components: no orphaned chevrons, empty states have a CTA
- Motion: springs everywhere, haptics on significant actions only
- Content: buttons say what they do, errors say what to do

**High bar (worth aspiring to):**
One moment of unexpected delight — an animation, a haptic pattern, an empty state — that makes a user stop and notice. This is what separates "ships apps" from "makes products."
</audit_protocol>

<ios_specific_notes>
**What's iOS slop but not web slop:**
- Flat list dividers (dated on iOS, acceptable on web)
- Full-width buttons (acceptable on web, heavy on iOS)
- Modal alerts for confirmation (web norm, iOS anti-pattern for minor actions)
- Tab bar used as feature launcher (iOS HIG violation, common on web nav bars)

**What saves you from slop:**
- Trust `.listStyle(.insetGrouped)` — it handles dividers, grouping, and selection correctly
- Use materials (`.ultraThinMaterial`, `.thinMaterial`) for layering instead of manual shadows
- Respect Safe Area — don't fight it, work with it
- Read HIG not as law but as discovered wisdom. When you deviate, know why.
</ios_specific_notes>
