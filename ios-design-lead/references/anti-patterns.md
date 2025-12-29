<overview>
Learn from common mistakes. These anti-patterns appear in poorly designed iOS apps. Recognize them, avoid them, and understand why they fail. Good design is often about what you don't do.
</overview>

<navigation_antipatterns>
## Navigation Mistakes

<anti_pattern name="Hamburger Menus">
**Problem:** Hides features, reduces discoverability, hard to reach one-handed

**Why it fails:**
- Users don't explore hidden menus
- Features get ignored
- Not iOS-native pattern
- Breaks thumb zone ergonomics

**Instead:** Tab bar (3-5 items), or NavigationStack with visible options

**Exception:** Secondary settings/profile menu (but not primary navigation)
</anti_pattern>

<anti_pattern name="Too Many Tab Bar Items">
**Problem:** 6+ tabs is overwhelming

**Why it fails:**
- Can't display all tabs (shows "More")
- Decision paralysis
- Unclear hierarchy

**Instead:** 3-5 tabs maximum. Group related features into sections
</anti_pattern>

<anti_pattern name="Deep Navigation Hierarchies">
**Problem:** Screen → Screen → Screen → Screen → Screen (5 levels deep)

**Why it fails:**
- Users get lost
- Back navigation is tedious
- Hard to return to starting point

**Instead:** Flatten hierarchy, use modals/sheets for side quests, provide shortcuts
</anti_pattern>

<anti_pattern name="Unclear Navigation State">
**Problem:** Can't tell where you are in the app

**Why it fails:**
- Confusing
- Can't build mental model
- Frustrating

**Instead:** Clear titles, breadcrumbs, visual indicators of current location
</anti_pattern>
</navigation_antipatterns>

<interaction_antipatterns>
## Interaction Mistakes

<anti_pattern name="Tiny Touch Targets">
**Problem:** 20x20pt buttons, cramped spacing

**Why it fails:**
- Mis-taps
- Frustration
- Accessibility failure

**Instead:** Minimum 44x44pt, prefer 48pt+, 16pt spacing between targets
</anti_pattern>

<anti_pattern name="Gesture-Only Features">
**Problem:** Critical action only accessible via hidden gesture

**Why it fails:**
- Undiscoverable
- Accessibility failure (Voice Control can't access)
- New users never find it

**Instead:** Provide button alternative, show onboarding hint, progressive disclosure
</anti_pattern>

<anti_pattern name="Destructive Actions Without Confirmation">
**Problem:** Delete button with no undo/confirm

**Why it fails:**
- Accidental deletion
- User panic
- Data loss

**Instead:** Swipe to delete (requires intention), confirmation alert for important data, undo option
</anti_pattern>

<anti_pattern name="Non-Standard Gestures">
**Problem:** Triple-tap to activate, diagonal swipe, complex multi-finger gestures

**Why it fails:**
- Undiscoverable
- Conflicts with system gestures
- Accessibility issues

**Instead:** Use standard iOS gestures (tap, swipe, long press, pinch, rotate)
</anti_pattern>
</interaction_antipatterns>

<visual_antipatterns>
## Visual Design Mistakes

<anti_pattern name="Too Many Colors">
**Problem:** Rainbow explosion, 10+ colors

**Why it fails:**
- Visual chaos
- No hierarchy
- Looks amateur

**Instead:** 1-2 accent colors + system grays, semantic colors only
</anti_pattern>

<anti_pattern name="Poor Contrast">
**Problem:** Light gray text on white background, colored on colored

**Why it fails:**
- Unreadable
- Accessibility failure
- Fails WCAG standards

**Instead:** Use semantic colors (.primary, .secondary), test contrast ratios (4.5:1 minimum)
</anti_pattern>

<anti_pattern name="Inconsistent Typography">
**Problem:** 8 different font sizes, 5 different weights, mixing fonts

**Why it fails:**
- No hierarchy
- Visual noise
- Unprofessional

**Instead:** 3-4 text styles per screen, 2-3 weights, system fonts
</anti_pattern>

<anti_pattern name="Fixed Font Sizes">
**Problem:** .font(.system(size: 17)) instead of .font(.body)

**Why it fails:**
- Doesn't scale with Dynamic Type
- Accessibility failure
- Breaks for vision-impaired users

**Instead:** Always use text styles (.body, .title, .headline)
</anti_pattern>

<anti_pattern name="No Dark Mode Support">
**Problem:** App looks broken in dark mode

**Why it fails:**
- App Store rejection
- Blinding white screens at night
- Unprofessional

**Instead:** Use semantic colors, test in both modes, asset catalog color sets
</anti_pattern>

<anti_pattern name="Cluttered Layouts">
**Problem:** Everything crammed together, no breathing room

**Why it fails:**
- Cognitive overload
- Can't parse information
- Overwhelming

**Instead:** 8pt grid, generous spacing (16-24pt), white space is design
</anti_pattern>
</visual_antipatterns>

<animation_antipatterns>
## Animation Mistakes

<anti_pattern name="Linear Easing Curves">
**Problem:** .linear(duration: 0.3) for UI animations

**Why it fails:**
- Mechanical feel
- Unnatural motion
- Not iOS-like

**Instead:** Always use spring animations (.spring())
</anti_pattern>

<anti_pattern name="Inconsistent Timing">
**Problem:** Button 1 is 0.2s, button 2 is 0.5s, button 3 is 0.35s

**Why it fails:**
- Feels random
- No coherence
- Amateur

**Instead:** Pick 2-3 durations (0.15s, 0.3s, 0.6s) and use consistently
</anti_pattern>

<anti_pattern name="Over-Animation">
**Problem:** Everything bounces, spins, explodes

**Why it fails:**
- Animation fatigue
- Distracting
- Nothing feels special

**Instead:** Animate user-triggered actions and state changes only
</anti_pattern>

<anti_pattern name="No Animation">
**Problem:** State changes instantly, no transition

**Why it fails:**
- Jarring
- Disconnected
- Feels broken

**Instead:** Wrap state changes in withAnimation()
</anti_pattern>

<anti_pattern name="Too Much Bounce">
**Problem:** .spring(duration: 0.3, bounce: 0.8)

**Why it fails:**
- Gimmicky
- Distracting
- Not premium

**Instead:** 0.0-0.2 bounce for professional feel, 0.3-0.4 only for celebrations
</anti_pattern>
</animation_antipatterns>

<content_antipatterns>
## Content Mistakes

<anti_pattern name="Lorem Ipsum in Production">
**Problem:** Placeholder text shipped to users

**Why it fails:**
- Looks broken
- Unprofessional
- Confusing

**Instead:** Real content or meaningful placeholders
</anti_pattern>

<anti_pattern name="Generic Empty States">
**Problem:** "No items" with no guidance

**Why it fails:**
- Dead end
- User doesn't know what to do

**Instead:** Helpful message + clear action ("Tap + to add your first item")
</anti_pattern>

<anti_pattern name="Jargon and Technical Language">
**Problem:** "Error 403: Forbidden" shown to user

**Why it fails:**
- Confusing
- Unhelpful
- Creates anxiety

**Instead:** Human language ("You don't have permission to view this")
</anti_pattern>

<anti_pattern name="Wall of Text">
**Problem:** Paragraph after paragraph, no hierarchy

**Why it fails:**
- Overwhelming
- Nobody reads it
- Information lost

**Instead:** Break into sections, use hierarchy, be concise
</anti_pattern>
</content_antipatterns>

<accessibility_antipatterns>
## Accessibility Mistakes

<anti_pattern name="Images Without Labels">
**Problem:** VoiceOver says "image"

**Why it fails:**
- Blind users don't know what it is
- Accessibility failure

**Instead:** .accessibilityLabel() on every meaningful image
</anti_pattern>

<anti_pattern name="Color as Only Indicator">
**Problem:** Red vs green status, no text/icon

**Why it fails:**
- Color-blind users can't distinguish
- Accessibility failure

**Instead:** Icon + color + text label
</anti_pattern>

<anti_pattern name="Non-Standard Controls">
**Problem:** Custom UI that doesn't work with VoiceOver

**Why it fails:**
- Accessibility failure
- Blind users can't use app

**Instead:** Use standard controls or implement full accessibility support
</anti_pattern>

<anti_pattern name="Auto-Playing Video/Audio">
**Problem:** Video starts playing automatically

**Why it fails:**
- Startling
- Accessibility issue
- Annoying

**Instead:** User-initiated playback only
</anti_pattern>
</accessibility_antipatterns>

<performance_antipatterns>
## Performance Mistakes

<anti_pattern name="Unoptimized Images">
**Problem:** 5MB PNG for small icon

**Why it fails:**
- Slow loading
- Memory issues
- App bloat

**Instead:** Proper compression, @2x/@3x assets, use SF Symbols when possible
</anti_pattern>

<anti_pattern name="Laggy Animations">
**Problem:** Animations drop below 60fps

**Why it fails:**
- Feels broken
- Not premium
- Frustrating

**Instead:** Simplify, optimize, profile with Instruments, use .drawingGroup()
</anti_pattern>

<anti_pattern name="No Loading States">
**Problem:** Blank screen while loading

**Why it fails:**
- Looks broken
- No feedback
- User confusion

**Instead:** Skeleton screens, progress indicators, optimistic updates
</anti_pattern>
</performance_antipatterns>

<ux_writing_antipatterns>
## UX Writing Mistakes

<anti_pattern name="Passive Voice">
**Problem:** "The file has been deleted"

**Why it fails:**
- Unclear who did what
- Wordy

**Instead:** "Deleted file" or "You deleted the file"
</anti_pattern>

<anti_pattern name="Asking for Permissions Without Context">
**Problem:** Alert appears: "Allow notifications?"

**Why it fails:**
- User doesn't know why
- Likely to deny

**Instead:** Show value first ("Get notified when tasks are due"), then request permission
</anti_pattern>

<anti_pattern name="Ambiguous Button Labels">
**Problem:** "OK" and "Cancel" when deleting (which is which?)

**Why it fails:**
- Confusing
- Accidental destructive actions

**Instead:** Specific labels ("Delete" and "Keep")
</anti_pattern>
</ux_writing_antipatterns>

<nielsen_norman_findings>
## Research-Backed Anti-Patterns

**From Nielsen Norman Group testing:**

**Page Control Dots:**
- Problem: Only sequential access, no content preview
- Users get frustrated
- Better: Thumbnails or tabs

**Submit at Top:**
- Problem: Users expect submit at bottom (after content)
- Causes confusion
- Better: Bottom placement

**Plus (+) Icon Ambiguity:**
- Problem: Could mean add, expand, zoom
- Context-dependent interpretation
- Better: Specific icon or label

**Source:** [iOS Design Rules to Break - NN/g](https://www.nngroup.com/articles/4-ios-rules-break/)
</nielsen_norman_findings>

<job_completion_antipatterns>
## Job Completion Mistakes

These anti-patterns prevent users from completing their jobs, even when the UI is technically "correct."

<anti_pattern name="Word Repetition">
**Problem:** "Combine" in title, nav button, AND description (3x)

**Why it fails:**
- Each repetition dilutes meaning
- Visual noise
- Wastes screen space

**Rule:** Action word once in title, once on primary button. Never more.
</anti_pattern>

<anti_pattern name="Navigation Bar as Action Bar">
**Problem:** Primary CTA in top navigation bar

**Why it fails:**
- Nav bar is for orientation ("where am I?"), not actions
- Critical actions belong in thumb zone
- Hard to reach on large phones

**Rule:** Move primary CTAs to bottom on modal sheets
</anti_pattern>

<anti_pattern name="Negative Framing">
**Problem:** "Cards to Delete" instead of "Cards to Combine"

**Why it fails:**
- Focuses on loss, not gain
- Creates anxiety
- Users came to consolidate, not destroy

**Rule:** Frame around the outcome user wants, not the side effect
</anti_pattern>

<anti_pattern name="Process Preview Instead of Result Preview">
**Problem:** Preview shows nested chrome (cards within cards)

**Why it fails:**
- Shows mechanism, not destination
- Confusing hierarchy
- Doesn't inspire confidence

**Rule:** Preview the destination state, not the process
</anti_pattern>

<anti_pattern name="Stats Without Context">
**Problem:** "2 Total Capsules, 0 Unique Tags" - so what?

**Why it fails:**
- Doesn't inform decision
- Visual clutter
- Cognitive load without value

**Rule:** Only show information that changes user's choice
</anti_pattern>

<anti_pattern name="Depth Hiding Critical Actions">
**Problem:** Combine buried 2+ taps deep

**Why it fails:**
- Depth ≠ importance
- Critical actions should surface when needed
- Users won't hunt for features

**Rule:** Surface contextual actions when trigger conditions are met (e.g., 2+ cards selected → show Combine option)
</anti_pattern>
</job_completion_antipatterns>

<meta_principle>
## The Meta-Rule

**Every screen element should answer: "Does this help the user complete their job?"**

If the answer is no, it's noise. Remove it.

This applies to:
- Labels and text
- Buttons and controls
- Stats and metadata
- Preview content
- Navigation elements

If it doesn't serve the job, it actively hurts the job by competing for attention.
</meta_principle>

<sources>
Based on research from:
- [iOS Design Rules to Break - Nielsen Norman Group](https://www.nngroup.com/articles/4-ios-rules-break/)
- [Mobile Design Anti-Patterns - SitePoint](https://www.sitepoint.com/examples-mobile-design-anti-patterns/)
- [Bad App Design Mistakes - UXPin](https://www.uxpin.com/studio/blog/bad-app-design/)
- [Common UI Design Mistakes - Mindinventory](https://www.mindinventory.com/blog/ui-design-mistakes/)
- Mindcraft "Combine Cards" case study (2024)
</sources>
