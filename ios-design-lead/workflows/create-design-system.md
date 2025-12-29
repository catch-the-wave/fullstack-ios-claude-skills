# Workflow: Create or Extend Design System

<required_reading>
**Read these reference files NOW:**
1. references/color-system.md
2. references/typography.md
3. references/layout-spatial.md
4. references/philosophy.md
</required_reading>

<process>
## Step 1: Define Design Tokens

**Color tokens:**
```swift
extension Color {
    // Semantic tokens (not "blue500", but "actionPrimary")
    static let actionPrimary = Color("ActionPrimary")
    static let actionSecondary = Color("ActionSecondary")

    static let statusSuccess = Color("StatusSuccess")
    static let statusWarning = Color("StatusWarning")
    static let statusError = Color("StatusError")

    static let surfaceBackground = Color("SurfaceBackground")
    static let surfaceElevated = Color("SurfaceElevated")
    static let surfaceCard = Color("SurfaceCard")

    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let textTertiary = Color("TextTertiary")
}
```

**Create asset catalog colors:**
- Colors.xcassets/ActionPrimary.colorset
- Define 4 variants: Light, Dark, High Contrast Light, High Contrast Dark

**Spacing tokens:**
```swift
extension CGFloat {
    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 16
    static let spacingL: CGFloat = 24
    static let spacingXL: CGFloat = 32
    static let spacingXXL: CGFloat = 48
}
```

**Corner radius tokens:**
```swift
extension CGFloat {
    static let radiusS: CGFloat = 8
    static let radiusM: CGFloat = 12
    static let radiusL: CGFloat = 16
    static let radiusFull: CGFloat = 9999
}
```

## Step 2: Create Typography System

**Text style extensions:**
```swift
extension Font {
    // Semantic text styles
    static let heading1 = Font.largeTitle.weight(.semibold)
    static let heading2 = Font.title2.weight(.semibold)
    static let heading3 = Font.title3.weight(.medium)

    static let bodyRegular = Font.body
    static let bodyEmphasis = Font.body.weight(.medium)

    static let captionRegular = Font.caption
    static let captionEmphasis = Font.caption.weight(.medium)
}

// Usage
Text("Title")
    .font(.heading2)
```

**Typography documentation:**
```markdown
# Typography System

## Hierarchy
- Heading 1: Large Title, Semibold (Page titles)
- Heading 2: Title 2, Semibold (Section headers)
- Heading 3: Title 3, Medium (Subsections)
- Body Regular: Body (Primary content)
- Body Emphasis: Body Medium (Emphasis)
- Caption: Caption (Metadata)

## Rules
- Max 3 levels per screen
- Always use semantic names
- Support Dynamic Type
```

## Step 3: Create Reusable Components

**Button styles:**
```swift
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.bodyEmphasis)
            .foregroundColor(.white)
            .padding(.horizontal, .spacingL)
            .padding(.vertical, .spacingM)
            .background(Color.actionPrimary)
            .cornerRadius(.radiusM)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(duration: 0.1, bounce: 0), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.bodyEmphasis)
            .foregroundColor(.actionPrimary)
            .padding(.horizontal, .spacingL)
            .padding(.vertical, .spacingM)
            .background(Color.actionPrimary.opacity(0.1))
            .cornerRadius(.radiusM)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(duration: 0.1, bounce: 0), value: configuration.isPressed)
    }
}

// Usage
Button("Primary Action") {}
    .buttonStyle(PrimaryButtonStyle())
```

**Card component:**
```swift
struct CardView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(.spacingL)
            .background(Color.surfaceCard)
            .cornerRadius(.radiusM)
            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}

// Usage
CardView {
    VStack(alignment: .leading, spacing: .spacingM) {
        Text("Title")
            .font(.heading3)
        Text("Content")
            .font(.bodyRegular)
    }
}
```

**Input field component:**
```swift
struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.bodyRegular)
            .padding(.spacingM)
            .background(Color.surfaceElevated)
            .cornerRadius(.radiusM)
            .overlay(
                RoundedRectangle(cornerRadius: .radiusM)
                    .stroke(Color.actionPrimary.opacity(0.3), lineWidth: 1)
            )
    }
}
```

## Step 4: Define Animation Standards

**Animation constants:**
```swift
extension Animation {
    static let standard = Animation.spring(duration: 0.3, bounce: 0)
    static let quick = Animation.spring(duration: 0.15, bounce: 0)
    static let dramatic = Animation.spring(duration: 0.6, bounce: 0.2)
}

// Usage
.animation(.standard, value: isExpanded)
```

## Step 5: Create Haptic Manager

**Centralized haptics:**
```swift
class HapticManager {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }

    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    static func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
```

## Step 6: Document the System

**Create DesignSystem.md:**
```markdown
# Design System

## Principles
- Consciousness: Intentional, meaningful interactions
- Minimalism: Essential elements only
- Premium: Polish in every detail

## Colors
[Color tokens with hex values and usage]

## Typography
[Text styles with examples]

## Spacing
[8pt grid system]

## Components
[All reusable components]

## Animations
[Timing standards]

## Examples
[Screenshots of components in use]
```

## Step 7: Create SwiftUI Previews

**Component showcase:**
```swift
#Preview("Buttons") {
    VStack(spacing: .spacingL) {
        Button("Primary") {}
            .buttonStyle(PrimaryButtonStyle())

        Button("Secondary") {}
            .buttonStyle(SecondaryButtonStyle())

        Button("Destructive") {}
            .buttonStyle(DestructiveButtonStyle())
    }
    .padding()
}

#Preview("Colors - Light") {
    ColorGrid()
        .preferredColorScheme(.light)
}

#Preview("Colors - Dark") {
    ColorGrid()
        .preferredColorScheme(.dark)
}
```

## Step 8: Ensure Consistency

**Code review checklist:**
- [ ] Using semantic tokens (not hardcoded values)
- [ ] Using defined components (not custom one-offs)
- [ ] Following spacing system (8pt grid)
- [ ] Using standard animations (.standard, .quick)
- [ ] Dark mode support (semantic colors)
- [ ] Accessibility (Dynamic Type, labels)

**SwiftLint rules (optional):**
- Warn on hardcoded colors
- Warn on hardcoded spacing
- Enforce font styles

## Step 9: Migrate Existing Code

**Gradually refactor:**
```swift
// Before
.foregroundColor(Color(red: 0.2, green: 0.5, blue: 1.0))
.padding(14)

// After
.foregroundColor(.actionPrimary)
.padding(.spacingM)
```

**Track progress:**
- [ ] Home screen migrated
- [ ] Settings migrated
- [ ] Detail views migrated
- [ ] Modals migrated

## Step 10: Maintain and Evolve

**Regular audits:**
- Monthly design system review
- Add new patterns as they emerge
- Deprecate unused components
- Update documentation

**Versioning:**
- Semantic versioning for major changes
- Changelog for updates
- Migration guides for breaking changes

</process>

<anti_patterns>
Avoid:
- Too many tokens (keep it simple)
- Naming by appearance ("blue500" → "actionPrimary")
- Not documenting (no one will use it)
- Inconsistent usage (enforce with reviews)
- Creating one-off components (reuse existing)
- Ignoring accessibility
- No dark mode variants
</anti_patterns>

<success_criteria>
Effective design system:
- All colors are semantic tokens
- All spacing uses 8pt grid constants
- All text uses defined styles
- Reusable components for common patterns
- Fully documented with examples
- Works in light and dark mode
- Accessible by default
- Team actually uses it
- Reduces decision fatigue
- Creates visual consistency
</success_criteria>
