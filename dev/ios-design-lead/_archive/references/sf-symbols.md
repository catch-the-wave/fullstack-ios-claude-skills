<overview>
SF Symbols is Apple's icon system with 5000+ configurable symbols that integrate seamlessly with San Francisco font. Symbols scale with text, match font weight, support rendering modes, and adapt to Dark Mode automatically.
</overview>

<basics>
## Using SF Symbols

```swift
// Basic symbol
Image(systemName: "star")

// With text (auto-aligns)
Label("Favorite", systemImage: "star.fill")

// Sized to match text
HStack {
    Image(systemName: "heart")
    Text("Like")
}
.font(.title) // Both scale together
```

**Key advantage:** Symbols match font size and weight automatically
</basics>

<weights>
## Symbol Weights

**Match your text weight:**

```swift
Text("Regular text")
    .font(.body) // Regular weight

Image(systemName: "star")
    .font(.body) // Matches regular weight

Text("Bold headline")
    .font(.headline.weight(.semibold))

Image(systemName: "star")
    .font(.headline.weight(.semibold)) // Matches semibold
```

**Available weights:** Ultralight, Thin, Light, Regular, Medium, Semibold, Bold, Heavy, Black

**For premium:** Use Regular, Medium, Semibold primarily
</weights>

<rendering_modes>
## Symbol Rendering Modes

<mode name="Monochrome (Default)">
```swift
Image(systemName: "heart")
    .symbolRenderingMode(.monochrome)
    .foregroundColor(.red)
```

**Use for:** Standard icons, simple representations
</mode>

<mode name="Hierarchical">
```swift
Image(systemName: "heart.fill")
    .symbolRenderingMode(.hierarchical)
    .foregroundColor(.red)
```

**Effect:** Multiple opacity layers create depth
**Use for:** Icons that need subtle dimension
</mode>

<mode name="Palette">
```swift
Image(systemName: "person.crop.circle.badge.checkmark")
    .symbolRenderingMode(.palette)
    .foregroundStyle(.blue, .green, .red)
```

**Effect:** Up to 3 colors in one symbol
**Use for:** Status indicators, complex icons
</mode>

<mode name="Multicolor">
```swift
Image(systemName: "heart.fill")
    .symbolRenderingMode(.multicolor)
```

**Effect:** Pre-defined colors (e.g., red heart)
**Use for:** Recognizable colored symbols (flags, app icons)
</mode>
</rendering_modes>

<symbol_variants>
## Symbol Variants

**Fill vs. Outline:**
```swift
Image(systemName: "star")        // Outline
Image(systemName: "star.fill")   // Filled
```

**Use fill for:**
- Selected/active states
- Primary actions
- Emphasis

**Use outline for:**
- Unselected/inactive states
- Secondary actions
- Subtle presence

**Enclosed variants:**
```swift
Image(systemName: "star.circle")      // Star in circle outline
Image(systemName: "star.circle.fill") // Star in filled circle
Image(systemName: "star.square")      // Star in square
```

**Use for:** Toolbar buttons, tab bar icons
</symbol_variants>

<sf_symbols_5>
## SF Symbols 5 Features (Latest)

**Animations:**
```swift
Image(systemName: "heart.fill")
    .symbolEffect(.bounce, value: isLiked)

Image(systemName: "arrow.down")
    .symbolEffect(.pulse)

Image(systemName: "wifi")
    .symbolEffect(.variableColor.iterative)
```

**Effects available:**
- `.bounce` - Celebratory emphasis
- `.pulse` - Attention-getting
- `.variableColor` - Loading/processing
- `.scale` - Size emphasis
- `.replace` - Smooth icon transitions

**Use for:** Microinteractions, status feedback, delightful moments
</sf_symbols_5>

<custom_symbols>
## Creating Custom Symbols

**When to create:**
- Brand-specific icons
- Domain-specific glyphs
- Custom app actions

**How:**
1. Export template from SF Symbols app
2. Design in vector (Sketch, Figma, Illustrator)
3. Follow Apple's template guidelines
4. Import to Xcode asset catalog

**Must maintain:**
- Multiple weights (Regular, Medium, Semibold minimum)
- Alignment with SF Pro
- Center alignment
- Consistent style with system symbols

**Alternative:** Use system symbols + custom image assets
</custom_symbols>

<best_practices>
## SF Symbols Best Practices

**Sizing:**
```swift
// Good - scales with Dynamic Type
Image(systemName: "star")
    .font(.body)

// Bad - fixed size
Image(systemName: "star")
    .resizable()
    .frame(width: 20, height: 20)
```

**Accessibility:**
```swift
// Add label for VoiceOver
Image(systemName: "heart.fill")
    .accessibilityLabel("Favorite")

// Or use Label (includes text automatically)
Label("Favorite", systemImage: "heart.fill")
```

**Color:**
```swift
// Semantic color (adapts to dark mode)
Image(systemName: "star")
    .foregroundColor(.accentColor)

// Not fixed color
```

**Consistency:**
- Use same rendering mode throughout app
- Match weights to adjacent text
- Choose fill vs. outline systematically (e.g., fill = active)
</best_practices>

<anti_patterns>
## SF Symbols Mistakes

<anti_pattern name="Misaligned Symbols and Text">
**Problem:** Symbol doesn't match text baseline

**Fix:** Use Label or same font size/weight
```swift
Label("Text", systemImage: "star") // Auto-aligned
```
</anti_pattern>

<anti_pattern name="Fixed Sizes">
**Problem:** Symbol doesn't scale with Dynamic Type

**Fix:** Use .font() instead of .frame()
</anti_pattern>

<anti_pattern name="Missing Accessibility Labels">
**Problem:** VoiceOver just says "image"

**Fix:** Always add .accessibilityLabel()
</anti_pattern>

<anti_pattern name="Wrong Semantic Meaning">
**Problem:** Using "trash" icon for archive action

**Fix:** Choose symbols that match action meaning
- "archivebox" for archive
- "trash" for delete
- "square.and.arrow.up" for share
</anti_pattern>
</anti_patterns>

<sources>
Based on research from:
- [SF Symbols - Apple HIG](https://developer.apple.com/design/human-interface-guidelines/sf-symbols)
- [Typography - Apple HIG](https://developers.apple.com/design/human-interface-guidelines/foundations/typography/)
- [Complete Guide to SF Symbols - Hacking with Swift](https://www.hackingwithswift.com/articles/237/complete-guide-to-sf-symbols)
</sources>
