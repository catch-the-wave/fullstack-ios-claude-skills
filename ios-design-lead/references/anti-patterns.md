<anti_patterns>
**Never do these:**

| Anti-Pattern | Why | Fix |
|--------------|-----|-----|
| Word repetition | "Task" header + "Tasks" section + "Task" card = noise | Vary: header "Tasks", card shows task, no label |
| Nav bar as action bar | Nav = navigation, not feature actions | Move actions to content area or toolbar |
| Negative framing | "Cards to Delete" focuses on loss | Frame as outcome: "Cards to Combine" |
| Inventing patterns | Creating new when existing works | Search codebase, copy proven patterns |
| Magic numbers | `height: 56` without context | Use semantic: `.padding()`, design tokens |
| Linear animations | `.linear` feels robotic | `.spring()` always |
| Hardcoded colors | `Color.blue` breaks dark mode | Semantic colors or asset catalog |
| Multiple accents | Rainbow UI = visual chaos | Single accent color per screen |
| Decoration over function | Elements that don't clarify | "What does this help user understand?" |
| Fashion over timeless | Trendy effects without purpose | Default to flat/minimal, add depth only if functional |
| Haptic spam | Vibrating on every scroll/minor state | Only significant actions get haptics |
| Haptic-visual mismatch | Haptic fires before/after visual change | Synchronize exactly with visual moment |
</anti_patterns>

<code_anti_patterns>
**Architecture:**
- Files over 300 lines → split by responsibility
- @StateObject in child views → pass as @ObservedObject
- Business logic in views → move to ViewModel
- Hardcoded strings → use constants/localization

**SwiftUI:**
- GeometryReader everywhere → use `.frame()` or layout priorities
- Explicit heights → use `.padding()` and intrinsic sizing
- Force unwrapping optionals → use `if let` or `guard`
- Nested NavigationStack → single root NavigationStack

**Performance:**
- Heavy computation in body → use `.task` or computed properties
- Unnecessary @State → derive from source of truth
- Missing `Equatable` on ViewModels → add for diff optimization
</code_anti_patterns>
