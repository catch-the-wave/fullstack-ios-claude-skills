# Workflow: Review Code and Identify Issues

<critical_mindset>
## BE BRUTALLY HONEST

**DO NOT give generic praise like:**
- "Everything is well maintained" ❌
- "Your code is well structured" ❌
- "Looks good to me" ❌

**If there are issues, CALL THEM OUT SPECIFICALLY:**
- "This file has 5 hardcoded magic numbers that should use design tokens"
- "Components are scattered - need reorganization into DesignSystem structure"
- "Naming is inconsistent - SelectionToolbar should be CardSelectionToolbar"

**Your job is to find REAL problems, not to make the user feel good.**

If the code is truly excellent, say so with specifics. If not, be honest about what needs fixing.
</critical_mindset>

<required_reading>
**Read these reference files NOW:**
1. **references/critical-review-mindset.md** (CRITICAL - read first)
2. references/swiftui-architecture.md
3. references/code-organization.md
4. references/anti-patterns.md
5. references/accessibility.md
6. references/animations.md
</required_reading>

<process>
## Step 0: Critical Pre-Check (DO THIS FIRST)

**Before anything else, check for these COMMON REAL-WORLD ISSUES:**

### Design System Organization (CRITICAL)
- [ ] Are components in correct DesignSystem structure?
  - Components should be in `DesignSystem/Components/[Category]/`
  - NOT scattered in `Features/[Feature]/Components/`
- [ ] Are design tokens being used or are values hardcoded?
  - Check for magic numbers: `16`, `54`, `0.3`, etc.
  - Should use `UIConstants.Spacing.m`, `UIConstants.Toolbar.buttonHeight`, etc.
- [ ] Is file organization following conventions?
  - `DesignSystem/Tokens/` for constants
  - `DesignSystem/Components/` for reusable UI
  - `Features/[Feature]/` for feature-specific code

**Example of what to catch:**
```swift
// ❌ BAD - Found in real code review that was missed:
let toolbarButtonH: CGFloat = 54  // Hardcoded magic number
.padding(16)                       // Hardcoded spacing
.font(.system(size: 18))          // Hardcoded font size

// This file: Features/Navigation/Components/Bottom Toolbar/BottomToolbar.swift
// Should be: DesignSystem/Components/Toolbars/Bottom/BottomToolbar.swift

// ✅ GOOD - What it should be:
.frame(height: UIConstants.Toolbar.buttonHeight)
.padding(UIConstants.Spacing.m)
.font(.body)
```

### Naming Consistency (CRITICAL)
- [ ] Are component names clear and consistent?
  - `SelectionToolbar` vs `CardSelectionToolbar` - which one makes the purpose clear?
  - Are related components following same naming pattern?
- [ ] Do file names match their contents?
  - File: `SelectionToolbar.swift` → Type: `SelectionToolbar` ✓
  - File: `CardSelection.swift` → Type: `SelectionToolbar` ✗

### Component Placement (CRITICAL)
- [ ] Are components in the right folder for their purpose?
  - `SelectionToolbar.swift` in `DesignSystem/Components/Cards/` ✗
  - `SelectionToolbar.swift` in `DesignSystem/Components/Toolbars/` ✓

**IF YOU FIND THESE ISSUES, REPORT THEM IMMEDIATELY.**
**DO NOT SAY "code is well maintained" if these issues exist.**

## Step 1: Understand the Code

**Ask user:**
- Which file(s) to review?
- Specific concerns? (bugs, performance, design, architecture)
- Context (new feature, refactoring, fixing issues)

**Read the code:**
- Use Read tool to examine the file(s)
- Understand the feature/functionality
- Note the architecture pattern used

**Check project structure:**
```bash
# See if DesignSystem exists and is being used
ls -la DesignSystem/Components/
ls -la DesignSystem/Tokens/

# Check if components are scattered
find . -name "*Toolbar*.swift" -o -name "*Button*.swift" | head -20
```

## Step 2: Architecture Review

**Check for architectural issues:**

### MVVM/MV Pattern Violations
- [ ] Business logic in views (should be in ViewModel)
- [ ] @StateObject vs @ObservedObject misuse
- [ ] ViewModels creating other ViewModels (tight coupling)
- [ ] No dependency injection (hardcoded dependencies)
- [ ] Massive ViewModels (>300 lines, doing too much)

**Example issues:**

```swift
// ❌ Bad: Business logic in view
Button("Add Task") {
    let newTask = Task(title: taskTitle)
    tasks.append(newTask)
    taskService.save(newTask)
    showSuccess = true
}

// ✅ Good: Logic in ViewModel
Button("Add Task") {
    viewModel.addTask(title: taskTitle)
}
```

### State Management Issues
- [ ] @ObservedObject when should be @StateObject
- [ ] Creating objects that should persist
- [ ] Missing @MainActor on ViewModels
- [ ] Retain cycles (strong references in closures)

```swift
// ❌ Bad: Object recreated on every view update
@ObservedObject private var viewModel = TaskListViewModel()

// ✅ Good: Persistent object
@StateObject private var viewModel = TaskListViewModel()
```

## Step 3: Code Quality Review

**Check for code smells:**

### Naming Issues
- [ ] Unclear variable names (x, temp, data)
- [ ] Inconsistent naming (camelCase vs snake_case)
- [ ] Misleading names (isLoading = true after loading completes)

### Complexity Issues
- [ ] Functions >50 lines
- [ ] Nested if statements >3 levels deep
- [ ] Repeated code (DRY violation)
- [ ] Magic numbers/strings (not constants)

```swift
// ❌ Bad: Magic number
.padding(16)

// ✅ Good: Named constant
.padding(.spacingM)  // spacingM defined in design system
```

### Error Handling
- [ ] No error handling on async calls
- [ ] Silent failures (catch { })
- [ ] Force unwrapping (!) without safety
- [ ] Force try! without justification

```swift
// ❌ Bad: Silent failure
do {
    tasks = try await taskService.fetchTasks()
} catch {
    // Empty catch - user sees nothing
}

// ✅ Good: Handle error
do {
    tasks = try await taskService.fetchTasks()
} catch {
    self.error = error
    self.showError = true
}
```

## Step 4: Performance Review

**Check for performance issues:**

### Memory Leaks
- [ ] Retain cycles in closures (missing [weak self])
- [ ] Observers not removed
- [ ] Combine subscriptions not stored

```swift
// ❌ Bad: Retain cycle
timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
    self.updateTime()  // Strong reference to self
}

// ✅ Good: Weak reference
timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
    self?.updateTime()
}
```

### Expensive Operations
- [ ] Heavy computation in computed properties
- [ ] Network calls on main thread
- [ ] Image loading blocking UI
- [ ] Missing lazy initialization
- [ ] No debouncing on search/input

```swift
// ❌ Bad: Heavy work in computed property
var filteredTasks: [Task] {
    tasks.filter { /* complex filtering */ }  // Runs every access
}

// ✅ Good: Cached result
@Published var filteredTasks: [Task] = []

func updateFilter() {
    filteredTasks = tasks.filter { /* complex filtering */ }
}
```

## Step 5: Design/UX Review

**Check for design issues:**

### Visual Design Problems
- [ ] Fixed font sizes (not using text styles)
- [ ] Hardcoded colors (not semantic)
- [ ] Inconsistent spacing (not 8pt grid)
- [ ] No dark mode support
- [ ] Poor contrast ratios
- [ ] Inconsistent corner radius

```swift
// ❌ Bad: Fixed size, hardcoded color
Text("Title")
    .font(.system(size: 18))
    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))

// ✅ Good: Semantic styles
Text("Title")
    .font(.headline)
    .foregroundColor(.primary)
```

### Animation Issues
- [ ] Linear easing (should be springs)
- [ ] Inconsistent timing (random durations)
- [ ] Missing animations (jarring state changes)
- [ ] Too much bounce (>0.4)
- [ ] No reduce motion support

```swift
// ❌ Bad: Linear animation
.animation(.linear(duration: 0.3), value: isExpanded)

// ✅ Good: Spring animation
.animation(.spring(duration: 0.3, bounce: 0), value: isExpanded)
```

### Interaction Issues
- [ ] Touch targets <44x44pt
- [ ] No button press feedback
- [ ] No haptic feedback on actions
- [ ] Missing loading states
- [ ] Generic empty states
- [ ] No error feedback

```swift
// ❌ Bad: Tiny touch target
Button("×") {
    dismiss()
}
.font(.system(size: 14))  // ~20x20pt tappable area

// ✅ Good: Expanded touch target
Button("×") {
    dismiss()
}
.font(.system(size: 14))
.frame(minWidth: 44, minHeight: 44)
.contentShape(Rectangle())
```

## Step 6: Accessibility Review

**Check for accessibility issues:**

- [ ] Images without labels
- [ ] Color as only indicator
- [ ] Fixed font sizes (no Dynamic Type)
- [ ] Missing VoiceOver hints
- [ ] Gesture-only critical features
- [ ] Poor contrast (<4.5:1)

```swift
// ❌ Bad: No label
Image(systemName: "trash")

// ✅ Good: Accessible
Image(systemName: "trash")
    .accessibilityLabel("Delete")

// ❌ Bad: Color only
Circle()
    .fill(isActive ? .green : .red)

// ✅ Good: Icon + color
HStack {
    Image(systemName: isActive ? "checkmark.circle" : "xmark.circle")
    Text(isActive ? "Active" : "Inactive")
}
.foregroundColor(isActive ? .green : .red)
```

## Step 7: Security Review

**Check for security issues:**

- [ ] Sensitive data in logs
- [ ] Hardcoded API keys/secrets
- [ ] No input validation
- [ ] SQL injection risks (if using SQL)
- [ ] XSS vulnerabilities (if rendering web content)
- [ ] Insecure data storage

```swift
// ❌ Bad: API key in code
let apiKey = "sk_live_abc123..."

// ✅ Good: Key from environment/keychain
let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
```

## Step 8: Testing Review

**Check testability:**

- [ ] No tests for business logic
- [ ] ViewModels not testable (hardcoded dependencies)
- [ ] Complex logic in views (untestable)
- [ ] No mock services for testing
- [ ] Async operations not testable

```swift
// ❌ Bad: Hardcoded dependency (can't test)
class TaskListViewModel: ObservableObject {
    let taskService = TaskService()  // Can't inject mock
}

// ✅ Good: Injectable dependency
class TaskListViewModel: ObservableObject {
    private let taskService: TaskServiceProtocol

    init(taskService: TaskServiceProtocol = TaskService.shared) {
        self.taskService = taskService
    }
}
```

## Step 9: Generate Report

**Categorize findings by severity:**

### 🔴 Critical Issues (Fix immediately)
- Crashes, memory leaks
- Security vulnerabilities
- Accessibility blockers
- Data loss risks

### 🟡 Important Issues (Fix soon)
- Performance problems
- Architecture violations
- Poor error handling
- UX friction points

### 🟢 Minor Issues (Nice to have)
- Code style inconsistencies
- Missing comments
- Optimization opportunities
- Refactoring suggestions

**Report format:**

```markdown
## Code Review: TaskListView.swift

### 🔴 Critical Issues

**1. Memory Leak - Retain Cycle**
Location: Line 45
```swift
timer = Timer.scheduledTimer(...) { _ in
    self.updateTime()  // Strong reference
}
```
Fix: Use [weak self]

**2. Accessibility Violation**
Location: Line 78
Missing VoiceOver label on delete button
Fix: Add .accessibilityLabel("Delete task")

### 🟡 Important Issues

**3. Performance - Heavy Computation**
Location: Line 102
Filtering tasks in computed property runs on every access
Fix: Cache filtered results in @Published property

**4. Design - Fixed Font Size**
Location: Line 34
Using .font(.system(size: 18)) instead of text styles
Fix: Use .font(.headline) for Dynamic Type support

### 🟢 Minor Issues

**5. Code Organization**
File is 450 lines - consider splitting into smaller components
Fix: Extract subviews for header, list, empty state

**6. Magic Numbers**
Multiple hardcoded spacing values (14, 18, 22)
Fix: Use design system constants
```

## Step 10: Provide Fixes

**For each issue, provide:**
1. Explanation of the problem
2. Why it's problematic
3. How to fix it (with code)
4. Better alternative pattern

**Example:**

```markdown
### Issue: Business Logic in View

**Problem:**
```swift
Button("Complete") {
    // 20 lines of business logic here
    let updatedTask = task
    updatedTask.isCompleted = true
    taskService.update(updatedTask)
    // ...
}
```

**Why it's bad:**
- View is not testable
- Logic can't be reused
- Violates separation of concerns
- Hard to maintain

**Fix:**
```swift
// In ViewModel
func completeTask(_ task: Task) {
    var updatedTask = task
    updatedTask.isCompleted = true

    Task {
        do {
            try await taskService.update(updatedTask)
            // Update local state
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                tasks[index] = updatedTask
            }
        } catch {
            self.error = error
        }
    }
}

// In View
Button("Complete") {
    viewModel.completeTask(task)
}
```

**Benefits:**
- Testable (can test ViewModel separately)
- Reusable (can call from multiple places)
- Clear separation of concerns
- Proper error handling
```

</process>

<review_checklist>
## Complete Review Checklist

**Architecture:**
- [ ] Logic in ViewModels, not Views
- [ ] Correct use of @State/@StateObject/@ObservedObject
- [ ] Dependency injection used
- [ ] No massive files (>300 lines)
- [ ] Clear separation of concerns

**Code Quality:**
- [ ] Clear, descriptive naming
- [ ] Functions <50 lines
- [ ] No deep nesting (>3 levels)
- [ ] DRY principle followed
- [ ] Constants defined (no magic numbers)
- [ ] Proper error handling

**Design System (CRITICAL):**
- [ ] Components in correct DesignSystem folders
- [ ] Design tokens used (not hardcoded values)
- [ ] File organization follows conventions
- [ ] Naming is consistent and clear
- [ ] Components in right category folders

**Performance:**
- [ ] No retain cycles
- [ ] Weak self in closures
- [ ] Async operations on background
- [ ] No heavy work in computed properties
- [ ] Debouncing on user input

**Design:**
- [ ] Text styles (not fixed sizes)
- [ ] Semantic colors
- [ ] 8pt grid spacing
- [ ] Spring animations
- [ ] Dark mode support
- [ ] Touch targets ≥44pt
- [ ] Haptic feedback

**Accessibility:**
- [ ] VoiceOver labels
- [ ] Dynamic Type support
- [ ] Contrast ratios ≥4.5:1
- [ ] Not color-only indicators
- [ ] Reduce motion support

**Security:**
- [ ] No hardcoded secrets
- [ ] Input validation
- [ ] Secure data storage
- [ ] No sensitive data in logs

**Testing:**
- [ ] ViewModels testable
- [ ] Dependencies injectable
- [ ] Mock services available
</review_checklist>

<anti_patterns>
**Review anti-patterns to avoid:**

- **Generic praise** ("everything is well maintained", "code is well structured")
  → If there are issues, call them out specifically. Don't sugarcoat.
- **Missing real issues** (not checking design system usage, file organization)
  → Actually inspect for hardcoded values, component placement, naming
- Being too nitpicky (focus on impactful issues)
- No prioritization (critical vs minor)
- No solutions (always provide fixes)
- Vague feedback ("this is bad" - explain why)
- Style only (check substance too)

**CRITICAL:** If code has problems, be BRUTALLY HONEST. Your job is to find real issues, not to make the user feel good. Generic praise when there are obvious problems is worse than no review at all.
</anti_patterns>

<success_criteria>
A good code review:
- **Is brutally honest** - calls out real issues specifically
- **Checks design system usage** - magic numbers, tokens, file organization
- **Verifies component placement** - correct folder structure
- Finds critical bugs before production
- Identifies architectural issues
- Improves code quality
- Ensures accessibility
- Maintains design standards
- Provides clear, actionable fixes
- Prioritizes issues by impact
- Teaches better patterns
- Is respectful but NOT sugar-coated
- **NEVER gives generic praise** when there are obvious problems

**Example of good review:**
> "Found 5 critical issues:
> 1. Magic number `54` on line 12 should use UIConstants.Toolbar.buttonHeight
> 2. Component in wrong folder: Features/Navigation/ → should be DesignSystem/Components/Toolbars/
> 3. Inconsistent naming: SelectionToolbar → should be CardSelectionToolbar for clarity
> 4. Hardcoded padding values (16, 12, 8) → use design tokens
> 5. File organization doesn't follow DesignSystem conventions"

**Example of bad review:**
> "Everything looks good! Your code is well maintained and structured nicely." (when there are obvious issues)
</success_criteria>
