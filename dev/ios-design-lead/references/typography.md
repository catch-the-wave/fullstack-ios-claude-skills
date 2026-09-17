<overview>
Typography is the primary instrument of visual hierarchy. In industrial minimalism, type does the heavy lifting — no decorative elements, just weight, size, and opacity working in concert.

**Philosophy:** Monochrome palette + weight variation + size contrast = delicious hierarchy without noise.

**Font personality spectrum:**
- Geometric sans (Montserrat, Gilroy, Avenir) → Industrial precision, modern
- Humanist sans (SF Pro) → Friendly, readable, iOS native
- Monospace (SF Mono) → Technical, code, tags, precision data
- Serif (New York) → Editorial, classic, literary
</overview>

<hierarchy_craft>
## Monochrome Hierarchy: The Art

**Principle:** Create rich hierarchy using ONLY weight, size, and opacity. No color variety needed.

<layer name="The Three Tools">
**1. Weight** — Bold/Semibold for headers, Regular for body, creates vertical rhythm
**2. Size** — Generous jumps (not 2pt, think 8-12pt) for clear separation
**3. Opacity** — Primary (100%), Secondary (60%), Tertiary (40%) for depth

Together they create hierarchy richer than any color palette.
</layer>

<example name="Delicious Stack">
```swift
VStack(alignment: .leading, spacing: 4) {
    // HEADER: Bold, large, full opacity
    Text("Project Overview")
        .font(.system(size: 28, weight: .bold))
        .foregroundColor(.primary)

    // SUBHEADER: Semibold, medium, slightly reduced
    Text("Q4 Planning")
        .font(.system(size: 17, weight: .semibold))
        .foregroundColor(.primary.opacity(0.85))

    // BODY: Regular, comfortable, full opacity
    Text("Strategic initiatives for the upcoming quarter...")
        .font(.system(size: 15, weight: .regular))
        .foregroundColor(.primary)
        .padding(.top, 8)

    // METADATA: Regular, small, reduced opacity
    Text("Last updated 2 hours ago")
        .font(.system(size: 13, weight: .regular))
        .foregroundColor(.secondary) // or .primary.opacity(0.5)
}
```

**Result:** Four distinct levels, zero color, pure typography.
</example>

<principle name="Weight Preference">
**For industrial minimalism, prefer:**
- **Bold** — Headers, titles, primary actions
- **Semibold** — Subheaders, emphasis, interactive labels
- **Medium** — Secondary emphasis (use sparingly)
- **Regular** — Body text, descriptions

**Avoid:**
- Light/Ultralight — Too wispy, lacks presence
- Black/Heavy — Too aggressive, shouts instead of speaks

**Why semibold matters:** It's the secret weapon. Heavier than regular but not aggressive. Perfect for UI labels, buttons, list item titles.
</principle>

<principle name="Size Jumps">
**"Juicy but not distracting" headers:**

| Level | Size | Weight | Opacity | Feel |
|-------|------|--------|---------|------|
| Hero | 34pt | Bold | 100% | Commanding, singular |
| Title | 24-28pt | Bold | 100% | Strong presence |
| Subtitle | 17-20pt | Semibold | 85-100% | Clear hierarchy |
| Body | 15-17pt | Regular | 100% | Comfortable reading |
| Caption | 13pt | Regular | 60% | Supporting, quiet |
| Micro | 11pt | Medium | 50% | Metadata, timestamps |

**The jump matters:**
- 2pt difference = barely perceptible
- 6-8pt difference = clear hierarchy
- 10-12pt difference = strong separation

**"Juicy"** = generous size, bold weight, but restrained by single color and breathing room.
</principle>
</hierarchy_craft>

<italic_usage>
## Italics for Dynamic Content

**Principle:** Italics signal "this content is variable" — distinguishing user-generated or dynamic content from static UI chrome.

<use_case name="User Input Echo">
Search: "Showing results for *quantum physics*"
Filter: "Filtered by *high priority*"
Empty: "No tasks matching *project cleanup*"

**Why:** Draws eye to what user typed, confirms system understood input.

```swift
HStack(spacing: 4) {
    Text("Showing results for")
        .foregroundColor(.secondary)
    Text(searchQuery)
        .italic()
        .foregroundColor(.primary)
}
```
</use_case>

<use_case name="Variable Values">
Status: "Last synced *2 minutes ago*"
Attribution: "Created by *Sarah Chen*"
State: "Currently *in progress*"

**Why:** Distinguishes dynamic timestamp/name from static label.

```swift
Text("Last synced ")
    .foregroundColor(.secondary)
+ Text(timeAgo)
    .italic()
    .foregroundColor(.secondary)
```
</use_case>

<use_case name="Placeholder and Hint Text">
Input hint: "*Enter task name...*"
Suggestion: "*Try searching for topics*"

```swift
TextField("", text: $input, prompt: Text("Enter task name...")
    .italic()
    .foregroundColor(.tertiary))
```
</use_case>

<use_case name="Emphasis in Prose">
"This is *really* important"
"The *only* way to achieve this"

**Sparingly** — for genuine emphasis, not decoration.
</use_case>

<anti_pattern name="Italic Overuse">
**Problem:** Entire paragraphs in italics, or italicizing static labels
**Result:** Loses meaning, harder to read
**Fix:** Only italicize the specific variable/dynamic portion
</anti_pattern>
</italic_usage>

<monospace_usage>
## Monospace for Technical Contexts

**Fonts:** SF Mono (iOS system), or custom monospace
**Character:** Precision, technical, code-like, OP-1 display aesthetic

<use_case name="Tags and Labels" priority="high">
Tags: `#physics` `#science` `#learning`
Categories: `@work` `@personal` `@urgent`

**Why:** Tags are identifiers/objects, monospace signals "this is a distinct thing you can interact with."

```swift
Text("#physics")
    .font(.system(.subheadline, design: .monospaced))
    .foregroundColor(.secondary)
    .padding(.horizontal, 8)
    .padding(.vertical, 4)
    .background(Color.primary.opacity(0.08))
    .cornerRadius(4)
```

**TE connection:** Like the OP-1 display — technical data rendered with precision typography.
</use_case>

<use_case name="Codes and Identifiers">
Confirmation: `A7X-2K9P`
Device: `iPhone-16e`
Version: `v2.1.0`
ID: `usr_12345`

**Why:** Monospace prevents character confusion (0 vs O, 1 vs l, I vs l).

```swift
Text("A7X-2K9P")
    .font(.system(.body, design: .monospaced))
    .tracking(1) // slight letter spacing for readability
```
</use_case>

<use_case name="Technical Data">
File size: `2.4 MB`
Duration: `00:03:45`
Coordinates: `37.7749° N`
Memory: `128 GB`

**Why:** Numbers align, creates technical precision feel.

```swift
Text("2.4 MB")
    .font(.system(.caption, design: .monospaced))
    .foregroundColor(.secondary)
```
</use_case>

<use_case name="Code and Commands">
Inline code: `print("Hello")`
Keyboard shortcuts: `⌘ + S`
File paths: `/Users/Documents/`

```swift
Text("⌘ + S")
    .font(.system(.caption, design: .monospaced))
    .padding(.horizontal, 6)
    .padding(.vertical, 2)
    .background(Color.primary.opacity(0.1))
    .cornerRadius(4)
```
</use_case>

<styling name="Mono Tag Pattern">
**Complete tag component:**

```swift
struct TagView: View {
    let tag: String

    var body: some View {
        Text(tag)
            .font(.system(.subheadline, design: .monospaced))
            .fontWeight(.medium)
            .foregroundColor(.primary.opacity(0.7))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.primary.opacity(0.06))
            .cornerRadius(6)
    }
}

// Usage
TagView(tag: "#physics")
```
</styling>
</monospace_usage>

<font_pairing>
## Fresh Font Pairing

**iOS system fonts provide 4 design variants:**
- `.default` — SF Pro (humanist sans)
- `.rounded` — SF Pro Rounded (friendly)
- `.serif` — New York (editorial)
- `.monospaced` — SF Mono (technical)

<pairing name="Industrial Technical" recommended="true">
**SF Pro + SF Mono**

| Element | Font | Weight |
|---------|------|--------|
| Headers | SF Pro | Bold |
| Body | SF Pro | Regular |
| Tags/codes | SF Mono | Medium |
| Data | SF Mono | Regular |

**Feel:** Professional, precise, developer-friendly
**Best for:** Productivity apps, technical tools, data-heavy interfaces
**TE alignment:** Matches OP-1 precision aesthetic

```swift
// Header
Text("Dashboard")
    .font(.system(size: 28, weight: .bold))

// Tag
Text("#active")
    .font(.system(.subheadline, design: .monospaced, weight: .medium))
```
</pairing>

<pairing name="Editorial Premium">
**New York + SF Pro**

| Element | Font | Weight |
|---------|------|--------|
| Headlines | New York | Bold |
| Body | SF Pro | Regular |
| Captions | SF Pro | Regular |

**Feel:** Sophisticated, magazine-like, premium
**Best for:** Reading apps, content platforms, publishing tools

```swift
Text("Article Title")
    .font(.system(.title, design: .serif, weight: .bold))

Text("Body content...")
    .font(.body)
```
</pairing>

<pairing name="Friendly Modern">
**SF Rounded + SF Pro**

| Element | Font | Weight |
|---------|------|--------|
| Headers | SF Rounded | Semibold |
| Body | SF Pro | Regular |
| Buttons | SF Rounded | Semibold |

**Feel:** Approachable, warm, consumer-friendly
**Best for:** Lifestyle apps, wellness, social

```swift
Text("Welcome!")
    .font(.system(.largeTitle, design: .rounded, weight: .semibold))
```
</pairing>

<decision_tree>
**Which pairing for your app?**

| App Type | Primary | Accent | Mono |
|----------|---------|--------|------|
| Productivity/Technical | SF Pro | — | SF Mono (tags, data) |
| Editorial/Reading | New York | SF Pro | — |
| Consumer/Lifestyle | SF Rounded | SF Pro | — |
| Developer Tools | SF Pro | — | SF Mono (heavy use) |
| Data/Analytics | SF Pro | — | SF Mono (numbers) |

**Industrial Minimalism default:** SF Pro + SF Mono
</decision_tree>
</font_pairing>

<custom_fonts>
## Custom Font Integration

**Geometric sans-serifs for industrial feel:**
- **Montserrat** — Open source, geometric, many weights
- **Gilroy** — Modern geometric, premium feel
- **Avenir Next** — Apple classic, balanced geometric
- **Inter** — Optimized for screens, open source

<implementation name="Custom Font Setup">
```swift
// 1. Add font files to project (TTF/OTF)
// 2. Add to Info.plist under "Fonts provided by application"
// 3. Use with Dynamic Type scaling:

extension Font {
    static func avenirNext(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
        let size = UIFont.preferredFont(forTextStyle: style.uiKit).pointSize
        return .custom("AvenirNext-\(weight.avenirName)", size: size, relativeTo: style)
    }
}

extension Font.Weight {
    var avenirName: String {
        switch self {
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "DemiBold"
        case .bold: return "Bold"
        default: return "Regular"
        }
    }
}

// Usage
Text("Header")
    .font(.avenirNext(.title, weight: .bold))
```
</implementation>

<principle name="Custom + System Hybrid">
**Pattern:** Custom font for display, system for UI chrome

| Element | Font |
|---------|------|
| Hero titles | Custom (Avenir, Montserrat) |
| Section headers | Custom |
| Body text | Custom or SF Pro |
| Buttons/labels | SF Pro (native feel) |
| Tags/codes | SF Mono |
| System UI | SF Pro (nav bars, etc.) |

**Why hybrid:** Maintains iOS native feel for interactive elements while establishing brand personality in content.
</principle>
</custom_fonts>

<mindcraft_typography>
## Mindcraft-Specific Typography

**Current font:** Avenir Next
**Character:** Geometric, balanced, timeless — sits between cold precision and warm friendliness.

<system name="Mindcraft Type System">
| Element | Font | Weight | Size | Notes |
|---------|------|--------|------|-------|
| Screen titles | Avenir Next | Bold | 28pt | Juicy but restrained |
| Section headers | Avenir Next | Semibold | 20pt | Clear hierarchy |
| Card titles | Avenir Next | Semibold | 17pt | Scannable |
| Body text | Avenir Next | Regular | 15pt | Comfortable |
| Tags | SF Mono | Medium | 13pt | `#topic` `#theme` |
| Metadata | Avenir Next | Regular | 13pt | Secondary opacity |
| Timestamps | SF Mono | Regular | 11pt | Technical precision |
</system>

<pattern name="Mindcraft Tags">
Tags are identifiers — treat them as objects, not decoration.

```swift
struct MindcraftTag: View {
    let name: String

    var body: some View {
        Text("#\(name)")
            .font(.system(.subheadline, design: .monospaced))
            .fontWeight(.medium)
            .foregroundColor(.primary.opacity(0.65))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.primary.opacity(0.06))
            .cornerRadius(6)
    }
}
```

**Why mono for tags:**
- Visual distinction from regular text
- Signals "this is a category/filter/object"
- TE-inspired precision feel
- Aligns with industrial minimalism
</pattern>

<pattern name="Mindcraft Hierarchy">
```swift
VStack(alignment: .leading, spacing: 6) {
    // Card title — semibold, primary
    Text("Quantum Computing Basics")
        .font(.custom("AvenirNext-DemiBold", size: 17, relativeTo: .headline))
        .foregroundColor(.primary)

    // Preview — regular, secondary
    Text("Introduction to qubits and quantum gates...")
        .font(.custom("AvenirNext-Regular", size: 15, relativeTo: .body))
        .foregroundColor(.secondary)
        .lineLimit(2)

    // Tags — mono, grouped
    HStack(spacing: 6) {
        MindcraftTag(name: "physics")
        MindcraftTag(name: "learning")
    }
    .padding(.top, 4)

    // Metadata — small, tertiary
    Text("Created 3 days ago")
        .font(.system(.caption, design: .monospaced))
        .foregroundColor(.tertiary)
}
```
</pattern>

<palette name="Mindcraft Type Colors">
Using monochrome hierarchy:

```swift
extension Color {
    static let mcPrimary = Color.primary           // 100% - titles, body
    static let mcSecondary = Color.primary.opacity(0.65)  // 65% - subtitles
    static let mcTertiary = Color.primary.opacity(0.45)   // 45% - metadata
    static let mcTag = Color.primary.opacity(0.6)         // 60% - tag text
    static let mcTagBg = Color.primary.opacity(0.06)      // 6% - tag background
}
```
</palette>
</mindcraft_typography>

<sf_pro_reference>
## SF Pro Quick Reference

**Weights (prefer middle range):**
| Weight | Use | iOS Constant |
|--------|-----|--------------|
| Regular | Body text | `.regular` |
| Medium | Light emphasis | `.medium` |
| Semibold | Subheads, labels | `.semibold` |
| Bold | Headers | `.bold` |

**Design variants:**
```swift
.font(.system(.body, design: .default))     // SF Pro
.font(.system(.body, design: .rounded))     // SF Pro Rounded
.font(.system(.body, design: .serif))       // New York
.font(.system(.body, design: .monospaced))  // SF Mono
```

**Dynamic Type styles:**
| Style | Default Size | Best For |
|-------|--------------|----------|
| `.largeTitle` | 34pt | Screen titles |
| `.title` | 28pt | Section headers |
| `.title2` | 22pt | Subsections |
| `.title3` | 20pt | Group titles |
| `.headline` | 17pt semi | List item titles |
| `.body` | 17pt | Primary content |
| `.callout` | 16pt | Secondary content |
| `.subheadline` | 15pt | Supporting text |
| `.footnote` | 13pt | Metadata |
| `.caption` | 12pt | Captions |
| `.caption2` | 11pt | Fine print |
</sf_pro_reference>

<anti_patterns>
## Typography Mistakes

<anti_pattern name="Too Many Weights">
**Problem:** Using Light, Regular, Medium, Semibold, Bold, Heavy all on one screen
**Result:** No clear hierarchy, visual noise
**Fix:** Max 3 weights per screen (Regular, Semibold, Bold)
</anti_pattern>

<anti_pattern name="Tiny Size Jumps">
**Problem:** 15pt header, 14pt body, 13pt caption
**Result:** Hierarchy invisible, everything looks same
**Fix:** Generous jumps: 24pt → 17pt → 13pt
</anti_pattern>

<anti_pattern name="Ignoring Monospace Opportunities">
**Problem:** Tags rendered in regular font, look like plain text
**Result:** Users don't recognize them as interactive/filterable
**Fix:** Use SF Mono for tags, codes, IDs, technical data
</anti_pattern>

<anti_pattern name="Fixed Sizes">
**Problem:** `fontSize: 16` hardcoded everywhere
**Result:** Breaks Dynamic Type accessibility
**Fix:** Always use `.font(.body)` or `.font(.custom(..., relativeTo: .body))`
</anti_pattern>

<anti_pattern name="Color-Based Hierarchy">
**Problem:** Blue headers, green subheads, purple body
**Result:** Visual chaos, fights with accent color
**Fix:** Monochrome hierarchy (weight + size + opacity)
</anti_pattern>
</anti_patterns>

<view_audit_checklist>
## Typography Audit Checklist

When reviewing SwiftUI views, check:

**Hierarchy:**
- [ ] Clear size jumps between levels (6pt+ difference)
- [ ] Max 3 weights used
- [ ] Monochrome color hierarchy (primary/secondary/tertiary)
- [ ] Headers feel "juicy" but not aggressive

**Dynamic Content:**
- [ ] User input/variables use italics
- [ ] Search queries echoed in italics
- [ ] Timestamps/relative times styled consistently

**Technical Content:**
- [ ] Tags use monospace
- [ ] Codes/IDs use monospace
- [ ] Numbers in tables use `.monospacedDigit()`

**Accessibility:**
- [ ] All text uses Dynamic Type (text styles or relativeTo:)
- [ ] Tested at xxxLarge and AX3
- [ ] No fixed font sizes

**Consistency:**
- [ ] Same font pairing throughout app
- [ ] Same weight meanings (semibold = always subheads)
- [ ] Same opacity levels for hierarchy
</view_audit_checklist>

<sources>
Based on:
- [Typography - Apple HIG](https://developer.apple.com/design/human-interface-guidelines/typography)
- [SF Font Family - Apple](https://developer.apple.com/fonts/)
- [Dynamic Type - Apple](https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically)
- Teenage Engineering OP-1 display typography
- Dieter Rams / Braun product typography
</sources>
