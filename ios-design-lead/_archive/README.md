# iOS Design Lead

> World-class iOS interface design with consciousness, minimalism, and premium feel.

A comprehensive Claude Code skill that embodies the expertise of a senior iOS design lead. Create fluid animations, masterful gestures, and delightful microinteractions inspired by the best apps in the ecosystem.

## Philosophy

This skill is built on four core tenets:

### 🧘 Consciousness
Design for awareness elevation, not just task completion. Every interaction should feel intentional, meaningful, and alive.

### 🌌 Cosmic Aesthetic
Find beauty in universal patterns—sacred geometry in layouts, natural rhythms in animations, golden ratios in proportions.

### 🎯 Minimalism
Remove until only the essential remains. White space is not empty—it's breathing room for consciousness.

### ✨ Premium Polish
The difference between good and exceptional is in the microinteractions. Haptics, spring animations, and delightful details transform functional into premium.

## Inspirations

This skill is curated from exemplary iOS apps:

- **AI Writer** - Text editing mastery, thoughtful input handling
- **Things 3** - Gesture fluency, object-based interaction perfection
- **Cosmos.so** - Pure minimalism, generous breathing room
- **Craft.do** - Animation excellence, innovative UI patterns

Plus design philosophy from:
- **Jony Ive** - Ruthless simplicity, "inevitable" design
- **Mike Matas** - Physics-based interactions, fluid motion
- **Dieter Rams** - "Less but better"
- **Swiss Design** - Grid systems, typography as hero
- **Japanese Ma** - Negative space, wabi-sabi

## What's Included

### 📚 15 Comprehensive Reference Files

**Foundations:**
- `philosophy.md` - Consciousness design framework, cosmic aesthetics
- `hig-principles.md` - Apple HIG essentials (Clarity, Deference, Depth)
- `layout-spatial.md` - 8pt grid, golden ratio spacing, spatial hierarchy

**Architecture & Code:**
- `swiftui-architecture.md` - MVVM, MV, state management, async patterns
- `code-organization.md` - Project structure, file organization, modularity

**Visual Design:**
- `typography.md` - SF Pro system, Dynamic Type, hierarchy
- `color-system.md` - Semantic colors, dark mode, design tokens
- `sf-symbols.md` - Icon system, rendering modes, custom symbols

**Motion & Interaction:**
- `animations.md` - Spring curves, fluid motion, timing precision
- `gestures.md` - SwiftUI gestures, Things 3 patterns, haptic feedback
- `haptics.md` - Taptic Engine, feedback vocabulary, synchronization
- `microinteractions.md` - 200-400ms timing, delightful details

**Quality:**
- `accessibility.md` - VoiceOver, Dynamic Type, WCAG compliance
- `exemplary-apps.md` - Deep analysis of AI Writer, Things, Cosmos, Craft
- `anti-patterns.md` - Common mistakes to avoid

### 🛠️ 8 Practical Workflows

1. **design-new-interface.md** - Create screens from scratch
2. **refine-existing-design.md** - Polish and improve existing designs
3. **add-animation.md** - Implement fluid motion and transitions
4. **design-gesture-interaction.md** - Things 3-level gesture design
5. **audit-accessibility.md** - VoiceOver, contrast, Dynamic Type testing
6. **create-design-system.md** - Build design tokens and components
7. **polish-microinteractions.md** - Add premium details
8. **review-code.md** - Review code for bugs, architecture, and design issues

## Installation

```bash
# Clone or copy the skill directory to:
~/.claude/skills/expertise/ios-design-lead/

# Verify structure:
ls ~/.claude/skills/expertise/ios-design-lead/
# Should show: SKILL.md, references/, workflows/, README.md
```

## Usage

### Direct Invocation

In Claude Code, invoke the skill:

```
ios-design-lead
```

The skill will present you with options:

```
What would you like to do?

1. Design a new interface (screen/feature/flow)
2. Refine an existing design
3. Add animations and transitions
4. Design gesture-based interactions
5. Audit and improve accessibility
6. Create or extend design system
7. Polish microinteractions and details
8. Review code and identify issues
9. Something else
```

Select your task, and the skill will:
1. Load relevant reference knowledge
2. Guide you through the workflow
3. Provide SwiftUI code examples
4. Ensure accessibility compliance
5. Apply premium polish standards

### Example Sessions

**Designing a new task list:**
```
User: ios-design-lead
Skill: What would you like to design?
User: 1 (Design a new interface)
Skill: [Loads philosophy, HIG, layout, typography, color references]
Skill: Let's design your task list interface...
```

**Adding animations:**
```
User: ios-design-lead
Skill: What would you like to design?
User: 3 (Add animations)
Skill: [Loads animations, microinteractions, exemplary-apps references]
Skill: Let's make your interface feel alive with spring animations...
```

## Key Principles

### Architecture Standards
- **MVVM for complexity** - ViewModels for business logic
- **Local @State for simplicity** - Simple UI state
- **Dependency injection** - Protocol-based, testable
- **Feature-based structure** - Group by feature, not type
- **Files under 300 lines** - Split when too large

### Animation Standards
- **Spring animations always** (no linear easing)
- **Standard timing:** 0.3s for most UI transitions
- **Quick feedback:** 0.15s for button presses
- **Celebrations:** 0.6s with 0.2-0.4 bounce

### Layout System
- **8pt grid** (4, 8, 16, 24, 32, 48)
- **Fibonacci spacing** for hierarchy (8, 13, 21, 34, 55)
- **44x44pt minimum** touch targets
- **Generous spacing** (24-48pt between sections)

### Typography
- **3 text styles maximum** per screen
- **Dynamic Type** support always
- **SF Pro** system fonts
- **Clear hierarchy** (size + weight + color)

### Color
- **1-2 accent colors** maximum
- **Semantic colors** (adapt to dark mode)
- **4.5:1 contrast ratio** minimum
- **System grays** for neutrals

### Haptics
- **Light impact:** Button presses, selection
- **Medium impact:** State changes, confirmations
- **Heavy impact:** Completions, significant events
- **Success/Warning/Error:** Semantic feedback

## Code Examples

### Spring Animation
```swift
.animation(.spring(duration: 0.3, bounce: 0), value: isExpanded)
```

### Button Press Feedback
```swift
@State private var isPressed = false

Button("Action") {
    HapticManager.impact(.medium)
    performAction()
}
.scaleEffect(isPressed ? 0.95 : 1.0)
.animation(.spring(duration: 0.1, bounce: 0), value: isPressed)
```

### Task Completion
```swift
Circle()
    .fill(isCompleted ? Color.green : Color.gray.opacity(0.3))
    .overlay {
        if isCompleted {
            Image(systemName: "checkmark")
                .transition(.scale.combined(with: .opacity))
        }
    }
.animation(.spring(duration: 0.6, bounce: 0.4), value: isCompleted)
.onTapGesture {
    HapticManager.notification(.success)
    isCompleted.toggle()
}
```

### Swipe Gesture
```swift
ItemRow(item)
    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
        Button(role: .destructive) {
            HapticManager.impact(.medium)
            deleteItem(item)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
```

## Requirements

- **Claude Code** - This is a Claude Code skill
- **iOS/SwiftUI knowledge** - Basic familiarity recommended
- **Xcode** - For building and testing on device
- **Test device** - Real device testing is essential (gestures, haptics, performance)

## Testing on Device

The skill integrates with your Xcode build workflow:

```bash
# Build for device (iPhone 16e - Stargazer)
xcodebuild -scheme YourScheme \
  -destination 'id=00008140-001220421AD0801C' \
  -quiet build
```

**Always test on device:**
- Gestures feel different than simulator
- Haptics only work on device
- Performance differs (animations, 60fps requirement)
- Dynamic Type scaling
- Real-world ergonomics

## Features

✅ **Comprehensive Research** - Based on 10+ sources from 2024-2025
✅ **SwiftUI Code Examples** - Copy-paste ready implementations
✅ **Architecture Guidance** - MVVM, state management, code organization
✅ **Code Review** - Identify bugs, architectural issues, design problems
✅ **Accessibility First** - VoiceOver, Dynamic Type, WCAG compliance
✅ **Haptic Integration** - Complete haptic vocabulary and patterns
✅ **Animation Standards** - Spring curves, timing precision
✅ **Real App Studies** - Things 3, Craft.do, AI Writer, Cosmos.so
✅ **Anti-Patterns** - Learn what NOT to do (design + code)
✅ **Design Tokens** - Build reusable design systems
✅ **Progressive Disclosure** - Loads only relevant knowledge

## Review Checklist

Before shipping any design/code created with this skill:

**Architecture:**
- [ ] Logic in ViewModels, not Views
- [ ] Correct @State/@StateObject/@ObservedObject usage
- [ ] Dependencies injected (testable)
- [ ] Files under 300 lines
- [ ] Feature-based organization

**Design:**
- [ ] Uses spring animations (no linear easing)
- [ ] Follows 8pt grid spacing
- [ ] 3-4 text styles maximum per screen
- [ ] 1-2 accent colors maximum
- [ ] Supports Dynamic Type
- [ ] Works in dark mode
- [ ] All touch targets ≥44x44pt
- [ ] VoiceOver labels on all images
- [ ] Contrast ratios ≥4.5:1
- [ ] Haptic feedback on key interactions

**Code Quality:**
- [ ] No retain cycles (weak self in closures)
- [ ] Proper error handling
- [ ] No magic numbers (use constants)
- [ ] No force unwrapping without safety
- [ ] Animations run at 60fps+ on device

**UX:**
- [ ] Empty states are helpful
- [ ] Error messages are human-friendly
- [ ] Loading states show structure
- [ ] Tested on actual device

## Contributing

This skill embodies a specific philosophy and aesthetic. If you'd like to contribute:

1. Maintain the consciousness-focused approach
2. Keep the minimalist aesthetic
3. Ensure all additions are research-backed
4. Include SwiftUI code examples
5. Test on real devices
6. Follow the XML structure standards

## Philosophy in Practice

> "Design is not decoration—it's the articulation of consciousness itself. Every tap, swipe, and transition should feel intentional, meaningful, alive."

This skill teaches you to:
- Think in objects, not screens
- Use physics-based motion (springs, momentum)
- Create haptic vocabulary (learned patterns)
- Respect negative space (Ma - breathing room)
- Polish microinteractions (200-400ms moments)
- Design for everyone (accessibility as foundation)
- Remove until only essence remains

## License

This skill is provided as-is for iOS design work. The philosophy, patterns, and code examples are freely shareable.

## Credits

**Research Sources:**
- Apple Human Interface Guidelines
- WWDC Sessions (2018, 2023, 2024)
- SwiftUI Animation guides
- Nielsen Norman Group studies
- Things 3 by Cultured Code
- Craft.do by Luki Labs
- AI Writer, Cosmos.so

**Design Philosophy:**
- Jony Ive's design principles
- Dieter Rams' ten principles
- Japanese Ma (negative space)
- Swiss design movement
- Mike Matas' fluid interfaces

---

**Made with consciousness, minimalism, and premium polish.**
For iOS designers who care about every pixel, every millisecond, every microinteraction.
