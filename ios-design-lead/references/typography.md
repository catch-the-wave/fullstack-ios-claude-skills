<overview>
Typography is the primary visual element of iOS design. SF Pro is Apple's humanist sans-serif, optimized for legibility at all sizes. Dynamic Type ensures accessibility by scaling text to user preferences. Typography creates hierarchy, rhythm, and personality.
</overview>

<sf_pro_system>
## San Francisco Font Family

**SF Pro Display:** 20pt and larger (Display sizes)
**SF Pro Text:** 19pt and smaller (Reading sizes)

**System automatically switches** between Display and Text variants

**Weights available:**
- Ultralight, Thin, Light (rarely used)
- Regular (body text)
- Medium (emphasis without heaviness)
- Semibold (subheadings)
- Bold (headings)
- Heavy, Black (rare, headlines only)

**For premium feel:** Use Regular, Medium, Semibold primarily. Avoid extremes (Ultralight, Black).
</sf_pro_system>

<text_styles>
## iOS Text Styles (Dynamic Type)

**Always use text styles, not fixed sizes**

```swift
// Good
Text("Heading")
    .font(.largeTitle)

// Bad
Text("Heading")
    .font(.system(size: 34))
```

**Standard hierarchy:**

| Style | Default Size | Use for |
|-------|--------------|---------|
| `.largeTitle` | 34pt | Page titles |
| `.title` | 28pt | Section headers |
| `.title2` | 22pt | Subsection headers |
| `.title3` | 20pt | Group titles |
| `.headline` | 17pt (Semibold) | List items, emphasis |
| `.body` | 17pt | Primary content |
| `.callout` | 16pt | Secondary content |
| `.subheadline` | 15pt | Tertiary content |
| `.footnote` | 13pt | Metadata, timestamps |
| `.caption` | 12pt | Image captions |
| `.caption2` | 11pt | Fine print |

**Design constraint:** Use maximum 3-4 styles per screen for clear hierarchy
</text_styles>

<dynamic_type>
## Supporting Dynamic Type

**Accessibility requirement:** Text must scale with user preference

```swift
// Automatic scaling
Text("Content")
    .font(.body) // Scales automatically

// Custom font with scaling
Text("Content")
    .font(.custom("YourFont", size: 17, relativeTo: .body))
```

**Size categories:**
- xSmall, Small, Medium (default)
- Large, xLarge, xxLarge, xxxLarge
- Accessibility sizes: AX1-AX5 (huge)

**Test your app at:**
- Default (Medium)
- xxxLarge (common for older users)
- AX3 (accessibility extreme)

**Handling large sizes:**
```swift
// Allow multi-line wrapping
Text("Long content")
    .lineLimit(nil) // Don't truncate

// Scale down if necessary (use sparingly)
@ScaledMetric var spacing: CGFloat = 16 // Scales with Dynamic Type

// Truncate only non-essential text
Text("Optional detail")
    .lineLimit(1)
    .minimumScaleFactor(0.8)
```
</dynamic_type>

<hierarchy>
## Creating Typographic Hierarchy

<principle name="Size + Weight">
**3 levels maximum per screen:**

1. **Primary:** `.title` or `.largeTitle`, Semibold/Bold
2. **Secondary:** `.headline` or `.body`, Medium
3. **Tertiary:** `.subheadline` or `.footnote`, Regular

**Example (Things 3):**
```
[Large Title, Bold]     "Today"
[Headline, Medium]      Task name
[Footnote, Regular]     Due date, tags
```
</principle>

<principle name="Color for Hierarchy">
**3 levels of emphasis:**

```swift
// Primary (most important)
.foregroundColor(.primary) // Black in light, white in dark

// Secondary (supporting)
.foregroundColor(.secondary) // Gray

// Tertiary (metadata)
.foregroundColor(.tertiary) // Lighter gray
```

**Combine with weight:**
- Title: Primary color, Semibold
- Body: Primary color, Regular
- Metadata: Secondary color, Regular
</principle>

<principle name="Spacing for Rhythm">
**Vertical spacing creates rhythm:**

```swift
VStack(spacing: 8) {
    Text("Title")
        .font(.title2)
    Text("Body content")
        .font(.body)
        .padding(.top, 4)
    Text("Metadata")
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.top, 8)
}
```

**Common spacings:**
- 4pt: Between related elements
- 8pt: Between paragraphs
- 16pt: Between sections
- 24pt: Between major groups
</principle>
</hierarchy>

<line_spacing>
## Line Height and Letter Spacing

**SwiftUI defaults are excellent** - rarely need adjustment

**When to adjust:**

```swift
// Increase readability for long-form content
Text("Long article text...")
    .lineSpacing(4) // Add 4pt between lines

// Tighten for headlines
Text("Headline")
    .tracking(-0.5) // Reduce letter spacing slightly
```

**Guidelines:**
- Body text: 120-145% line height (SwiftUI default is good)
- Headlines: 100-120% line height
- Never go below 100% (overlapping lines)
- Tracking: -1 to +1 pt maximum (subtle adjustments only)
</line_spacing>

<premium_typography>
## Premium Typographic Details

<detail name="Optical Alignment">
**Align text to cap height, not baseline**

```swift
Text("A")
    .alignmentGuide(.top) { d in d[.top] }
```

**When:** Headlines next to icons or geometric shapes
</detail>

<detail name="Number Formatting">
**Use monospaced digits for tabular data**

```swift
Text("$1,234.56")
    .monospacedDigit() // Numbers align vertically
```

**When:** Prices, scores, tables
</detail>

<detail name="Smart Punctuation">
**iOS handles automatically:**
- Curly quotes: "text" instead of "text"
- Em dashes: — instead of --
- Ellipses: … instead of ...

**Ensure enabled** in Text Field settings
</detail>

<detail name="Contextual Alternatives">
**SF Pro has alternate glyphs for specific contexts**

```swift
// Example: Stylistic alternatives
Text("g")
    .font(.system(.body, design: .rounded)) // Rounded variant
```

**Variants:**
- `.default` - Standard SF Pro
- `.rounded` - Softer, friendlier
- `.serif` - New York (editorial feel)
- `.monospaced` - SF Mono (technical)
</detail>
</premium_typography>

<anti_patterns>
## Typography Mistakes

<anti_pattern name="Fixed Font Sizes">
**Problem:** Doesn't scale with Dynamic Type

**Fix:** Always use text styles (.body, .title, etc.)
</anti_pattern>

<anti_pattern name="Too Many Weights/Sizes">
**Problem:** Visual chaos, no hierarchy

**Fix:** Limit to 3-4 styles per screen, 2-3 weights
</anti_pattern>

<anti_pattern name="Poor Contrast">
**Problem:** Gray text on gray background

**Fix:** Use semantic colors (.primary, .secondary) - they adapt to dark mode
</anti_pattern>

<anti_pattern name="Truncating Important Text">
**Problem:** "Click here to..." (truncated)

**Fix:** Allow wrapping for critical content
```swift
.lineLimit(nil)
```
</anti_pattern>

<anti_pattern name="Ignoring Accessibility Sizes">
**Problem:** Layout breaks at AX3 size

**Fix:** Test at extreme sizes, use @ScaledMetric for spacing
</anti_pattern>
</anti_patterns>

<sources>
Based on research from:
- [Typography - Apple HIG](https://developers.apple.com/design/human-interface-guidelines/foundations/typography/)
- [Typography and Dynamic Type - Design+Code](https://designcode.io/ios-design-handbook-typography-and-dynamic-type/)
- [Dynamic Type Guide - Kamran Madatli](https://medium.com/design-bootcamp/a-product-designers-guide-to-dynamic-type-in-ios-a105dda39a95)
</sources>
