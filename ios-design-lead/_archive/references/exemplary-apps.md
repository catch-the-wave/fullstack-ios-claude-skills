<overview>
Study the masters. These apps represent world-class iOS design: AI Writer (text editing mastery), Things (gesture fluency), Cosmos.so (minimalism), Craft.do (animation excellence). Learn their patterns, understand their philosophy, then create your own.
</overview>

<ai_writer>
## AI Writer - Text Editing Mastery

**What to study:**
- Thoughtful text input handling
- Cursor positioning precision
- Selection feedback
- Keyboard shortcuts
- Text formatting controls

**Key patterns:**
- **Smart editing:** Auto-formatting, intelligent suggestions
- **Contextual tools:** Format bar appears when selecting text
- **Gesture efficiency:** Swipe to select, long-press for cursor placement
- **Minimal chrome:** Interface fades, content shines

**Design lessons:**
- Text editing is complex - make it feel simple
- Progressive disclosure (advanced features hidden until needed)
- Haptic feedback confirms selection/formatting
- Typography is the hero

**When designing text-heavy apps:** Study how AI Writer handles edge cases (long documents, complex formatting, multi-language)
</ai_writer>

<things>
## Things 3 - Gesture Mastery & Fluid Interaction

**What to study:**
- Open the app and interact with tasks
- Notice every micro-moment
- Feel the haptics
- Study the animations

**Signature interactions:**

**Magic Plus Button:**
- Floats above content
- Draggable to any position
- Inserts task where dropped
- Feels physical, alive

**Swipe Gestures:**
- Left: Select (boundaries materialize)
- Right: Schedule (calendar slides in)
- Visual feedback immediate
- Haptic confirms threshold

**Drag to Reorder:**
- Long press activates
- Shadow appears (elevation)
- Other items shift with spring
- Drop feels satisfying

**Task Completion:**
- Tap checkbox
- Checkmark animates in
- Success haptic
- Strikethrough animates
- Feels rewarding

**Design lessons:**
- Objects have physical properties (weight, boundaries, momentum)
- Every gesture has visual + haptic feedback
- Consistent physics creates literacy
- Polish is in the details
- Animations use same timing (0.3s spring)

**Implementation notes:**
```swift
// Things-style task completion
.onTapGesture {
    HapticManager.impact(.medium)

    withAnimation(.spring(duration: 0.3, bounce: 0)) {
        isCompleted.toggle()
    }
}
```

**When designing productivity apps:** Study Things for gesture vocabulary, object-based thinking, completion feedback
</things>

<cosmos>
## Cosmos.so - Pure Minimalism & Breathing Room

**What to study:**
- Open cosmos.so in browser
- Notice the generous spacing
- Feel the calm
- Study the restraint

**Signature characteristics:**
- **Single column layouts:** No grid clutter
- **Massive spacing:** 32-48pt between sections
- **Content max-width:** ~600pt (centered, readable)
- **Color restraint:** One accent color (blue)
- **Typography hierarchy:** 3 levels maximum
- **White space as design:** Ma (negative space) philosophy

**Visual language:**
- Minimal borders
- Subtle shadows
- Flat colors (no gradients)
- SF Pro typography
- System icons

**Design lessons:**
- Less is actually more
- White space creates premium feel
- Restraint requires discipline
- Calm interfaces elevate consciousness
- One thing per screen

**Implementation:**
```swift
VStack(spacing: 48) {  // Generous!
    HeaderView()

    ContentView()
        .frame(maxWidth: 600)  // Readable width

    FooterView()
}
.padding(40)  // Breathing room
```

**When designing content-focused apps:** Study Cosmos for spacing, hierarchy, minimalism
</cosmos>

<craft>
## Craft.do - Animation Excellence & Innovative UI

**What to study:**
- Download Craft app
- Create a document
- Notice every transition
- Feel the smoothness

**Signature animations:**

**Block Insertion:**
- Scales up from 0.95 → 1.0
- Appears to "land" into place
- 0.6s duration, 0.2 bounce
- Smooth, satisfying

**Modal Presentation:**
- Scales up from 0.98
- Backdrop fades in simultaneously
- Content animates in sequence
- Dismissal follows same physics (reversed)

**Drag Handles:**
- Fade in on hover (progressive disclosure)
- Haptic on grab
- Items shift with fluid motion
- Drop confirms with subtle bounce

**Text Editing:**
- Cursor blinks naturally
- Selection expands smoothly
- Format changes animate
- Undo/redo feels immediate

**Design lessons:**
- Consistent timing (0.6s everywhere)
- Subtle bounce (0.2) adds life
- Combined transitions (scale + opacity + position)
- Every state change is animated
- Polish is respect for user

**Implementation:**
```swift
// Craft-style block insertion
.scaleEffect(isVisible ? 1.0 : 0.95)
.opacity(isVisible ? 1.0 : 0)
.animation(.spring(duration: 0.6, bounce: 0.2), value: isVisible)
```

**When designing creative tools:** Study Craft for animation timing, transitions, progressive disclosure
</craft>

<comparative_analysis>
## Comparative Patterns

| Aspect | Things | Cosmos | Craft | AI Writer |
|--------|--------|--------|-------|-----------|
| **Philosophy** | Fluid objects | Minimal calm | Smooth motion | Text mastery |
| **Spacing** | Comfortable | Generous | Balanced | Minimal |
| **Animation** | 0.3s spring | Minimal | 0.6s spring | Subtle |
| **Gestures** | Extensive | Minimal | Moderate | Text-focused |
| **Color** | Blue + contextual | Single blue | Purple | Restrained |
| **Haptics** | Rich vocabulary | Minimal | Moderate | Text feedback |

**Common threads:**
- All use spring animations (no linear)
- All respect platform conventions
- All have intentional design language
- All prioritize content over chrome
- All feel premium
</comparative_analysis>

<other_exemplars>
## Other Apps Worth Studying

**Halide (Camera):**
- Professional tools, consumer polish
- Gesture-based focus/exposure
- Information density without clutter
- Pro mode progressive disclosure

**Darkroom (Photo Editing):**
- Non-destructive editing
- Spatial awareness
- Histogram as always-visible feedback
- Touch precision for fine adjustments

**Ivory/Tweetbot (Social):**
- Timeline perfection
- Swipe gestures for actions
- Micro-detail attention
- Native iOS excellence

**Reeder (RSS):**
- Content-first minimalism
- Reading-optimized typography
- Gesture vocabulary
- Clean, focused interface

**Flighty (Flight Tracking):**
- Information density done right
- Playful but professional
- Widget excellence
- Personality without gimmicks
</other_exemplars>

<exercise>
## Reverse Engineering Exercise

**Pick one exemplary app:**
1. Use it for 10 minutes
2. Note every micro-interaction
3. Measure spacing (screenshot + overlay grid)
4. Time animations (record + slow-motion)
5. Feel haptic patterns
6. Sketch the flow

**Document:**
- Animation durations
- Haptic vocabulary
- Spacing system
- Color palette
- Typography hierarchy
- Gesture vocabulary

**Then:** Implement one signature pattern in your app
</exercise>
