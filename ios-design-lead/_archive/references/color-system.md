<overview>
iOS color system is semantic and adaptive. Colors have meaning (primary, secondary, error) and automatically adapt to light/dark mode and accessibility settings. Premium apps use restrained color palettes with intentional accent colors.
</overview>

<semantic_colors>
## System Semantic Colors

**Always use semantic colors, not fixed RGB values**

```swift
// Good - Adapts to dark mode automatically
.foregroundColor(.primary)
.background(.secondarySystemBackground)

// Bad - Fixed color, looks wrong in dark mode
.foregroundColor(Color(red: 0, green: 0, blue: 0))
```

**Text colors:**
- `.primary` - Black (light) / White (dark) - Main content
- `.secondary` - Gray - Supporting text
- `.tertiary` - Lighter gray - Metadata

**Background colors:**
- `.systemBackground` - White / Black - Primary background
- `.secondarySystemBackground` - Light gray / Dark gray - Elevated surfaces
- `.tertiarySystemBackground` - Lighter gray / Darker gray - Grouped content

**Fill colors** (for buttons, controls):
- `.systemFill`, `.secondarySystemFill`, `.tertiarySystemFill`, `.quaternarySystemFill`

**Grouped backgrounds** (for lists, settings):
- `.systemGroupedBackground`, `.secondarySystemGroupedBackground`, `.tertiarySystemGroupedBackground`
</semantic_colors>

<dark_mode>
## Dark Mode Support

**Required for App Store** - All apps must support dark mode

**Four color definitions per token:**
1. Light mode
2. Dark mode
3. Light mode high contrast (accessibility)
4. Dark mode high contrast (accessibility)

**Example asset catalog structure:**
```
Colors.xcassets/
├── AccentColor.colorset/
│   ├── Contents.json
│   └── (4 color variants defined)
```

**Testing:**
```swift
// Force dark mode for preview
#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

// Test high contrast
.environment(\.accessibilityContrast, .high)
```

**Design rules:**
- Never pure black (#000000) or pure white (#FFFFFF)
- Dark mode background: #1C1C1E or similar
- Maintain contrast ratios (4.5:1 text, 3:1 UI)
- Invert luminance, not just hue
</dark_mode>

<accent_colors>
## Accent Color Strategy

**Minimalist approach:** 1-2 accent colors maximum

**Cosmos.so:** Single blue accent
**Things 3:** Blue accent + contextual colors (red for today, yellow for upcoming)
**Craft.do:** Purple primary, subtle secondary colors

**Choosing accent:**
- Blue: Trust, productivity (default iOS)
- Purple: Creativity, premium
- Green: Growth, success
- Red: Urgency, importance
- Orange: Energy, warmth
- Yellow: Happiness, attention

**Usage:**
```swift
// Primary accent
Button("Action") {}
    .tint(.accentColor) // Uses app's accent color

// Semantic colors for specific meanings
Text("Error")
    .foregroundColor(.red)
Text("Success")
    .foregroundColor(.green)
```

**For premium feel:**
- Use accent sparingly (5-10% of UI)
- Reserve for primary actions and key information
- Most UI should be neutral grays
</accent_colors>

<color_tokens>
## Building a Color System

**Design tokens approach:**

```swift
extension Color {
    // Brand colors
    static let brandPrimary = Color("BrandPrimary")
    static let brandSecondary = Color("BrandSecondary")

    // Semantic tokens
    static let actionPrimary = Color("ActionPrimary")
    static let actionSecondary = Color("ActionSecondary")
    static let statusSuccess = Color("StatusSuccess")
    static let statusWarning = Color("StatusWarning")
    static let statusError = Color("StatusError")

    // Surface colors
    static let surfaceBackground = Color("SurfaceBackground")
    static let surfaceElevated = Color("SurfaceElevated")
    static let surfaceCard = Color("SurfaceCard")
}
```

**Token naming:**
- Semantic names (actionPrimary) over descriptive (blueButton)
- Purpose-driven (statusError) over color-driven (red500)
- Allows theme changes without code changes
</color_tokens>

<contrast_ratios>
## Accessibility Contrast Requirements

**WCAG 2.1 standards:**
- **Text:** 4.5:1 minimum (AA), 7:1 ideal (AAA)
- **Large text** (18pt+): 3:1 minimum
- **UI elements:** 3:1 minimum

**Testing tools:**
- Accessibility Inspector (Xcode)
- Color Contrast Analyzer
- Test in sunlight (real-world conditions)

**Common mistakes:**
- Light gray on white: Usually fails
- Colored text on colored background: Often fails
- Thin fonts: Need higher contrast

**Fix:**
```swift
// Automatic contrast boost for accessibility
@Environment(\.accessibilityContrast) var contrast

var textColor: Color {
    contrast == .high ? .primary : .secondary
}
```
</contrast_ratios>

<gradients>
## Using Gradients

**iOS aesthetic:** Subtle, natural gradients

```swift
// Subtle background gradient
LinearGradient(
    colors: [
        Color(.systemBackground),
        Color(.secondarySystemBackground)
    ],
    startPoint: .top,
    endPoint: .bottom
)
```

**Premium gradients:**
- 2-3 stops maximum
- Adjacent hues (blue → purple, not blue → orange)
- Subtle transitions (5-10% luminance difference)
- Avoid harsh color stops

**Craft.do style:**
- Mesh gradients (soft, organic)
- Glassmorphism effects
- Subtle depth cues

**When to avoid:**
- Body text backgrounds
- Primary surfaces (keep flat)
- Overuse (one per screen maximum)
</gradients>

<vibrancy>
## Vibrancy and Materials

**iOS blur effects:**

```swift
// Frosted glass effect
.background(.ultraThinMaterial)
.background(.thinMaterial)
.background(.regularMaterial)
.background(.thickMaterial)
.background(.ultraThickMaterial)
```

**Vibrancy levels:**
- Primary: Standard text on materials
- Secondary: Supporting text
- Tertiary: Subtle text

**Use for:**
- Overlays
- Sheets
- Context menus
- Navigation bars

**Cosmos.so approach:** Minimal materials, mostly flat colors
</vibrancy>

<anti_patterns>
## Color System Mistakes

<anti_pattern name="Fixed Colors">
**Problem:** Hard-coded RGB doesn't adapt

**Fix:** Use semantic system colors or asset catalog colors with dark mode variants
</anti_pattern>

<anti_pattern name="Too Many Colors">
**Problem:** Rainbow chaos, no coherence

**Fix:** 1-2 accent colors + system grays
</anti_pattern>

<anti_pattern name="Poor Contrast">
**Problem:** Can't read text

**Fix:** Test with contrast analyzer, use semantic colors
</anti_pattern>

<anti_pattern name="Ignoring Dark Mode">
**Problem:** App looks broken in dark mode

**Fix:** Every color needs light + dark variant
</anti_pattern>

<anti_pattern name="Color as Only Indicator">
**Problem:** Color-blind users can't distinguish

**Fix:** Use icons, shapes, text labels in addition to color
</anti_pattern>
</anti_patterns>

<sources>
Based on research from:
- [iOS Dark Mode and Semantic Colors](https://github.com/cocoacontrols/SemanticUI)
- [Towards a Design System in iOS: Colors - GoodNotes](https://medium.com/engineering-at-goodnotes/towards-a-design-system-in-ios-colors-63a3a0289ad7)
- [Designing Dark Mode - Chethan KVS](https://blog.prototypr.io/designing-a-dark-mode-for-your-ios-app-the-ultimate-guide-6b043303b941)
- [Color tokens guide - Victoria Serebrennikova](https://medium.com/design-bootcamp/color-tokens-guide-to-light-and-dark-modes-in-design-systems-146ab33023ac)
</sources>
