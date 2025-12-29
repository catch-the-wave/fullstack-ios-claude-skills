<overview>
Well-organized code is maintainable code. Structure projects by feature, keep files focused (200-300 lines max), group related code, and use clear naming. Organization reduces cognitive load and accelerates development.
</overview>

<project_structure>
## Recommended Project Structure

**Feature-based organization (recommended for medium-large apps):**

```
YourApp/
├── App/
│   ├── YourAppApp.swift          # App entry point
│   └── AppDelegate.swift         # If needed
│
├── Core/
│   ├── Models/
│   │   ├── Task.swift
│   │   ├── User.swift
│   │   └── Project.swift
│   │
│   ├── Services/
│   │   ├── TaskService.swift
│   │   ├── NetworkService.swift
│   │   └── StorageService.swift
│   │
│   ├── Utilities/
│   │   ├── HapticManager.swift
│   │   ├── DateFormatter+Extensions.swift
│   │   └── Color+Extensions.swift
│   │
│   └── DesignSystem/
│       ├── Colors.swift
│       ├── Typography.swift
│       ├── Spacing.swift
│       └── Components/
│           ├── PrimaryButton.swift
│           ├── CardView.swift
│           └── CustomTextField.swift
│
├── Features/
│   ├── TaskList/
│   │   ├── Views/
│   │   │   ├── TaskListView.swift
│   │   │   ├── TaskRow.swift
│   │   │   └── EmptyTaskListView.swift
│   │   ├── ViewModels/
│   │   │   └── TaskListViewModel.swift
│   │   └── Models/              # Feature-specific models if needed
│   │
│   ├── TaskDetail/
│   │   ├── Views/
│   │   │   ├── TaskDetailView.swift
│   │   │   └── TaskDetailHeader.swift
│   │   └── ViewModels/
│   │       └── TaskDetailViewModel.swift
│   │
│   └── Settings/
│       ├── Views/
│       │   └── SettingsView.swift
│       └── ViewModels/
│           └── SettingsViewModel.swift
│
└── Resources/
    ├── Assets.xcassets/
    ├── Localizable.strings
    └── Info.plist
```

**Small apps (simpler structure):**

```
YourApp/
├── YourAppApp.swift
├── Views/
│   ├── TaskListView.swift
│   ├── TaskDetailView.swift
│   └── SettingsView.swift
├── ViewModels/
│   ├── TaskListViewModel.swift
│   └── TaskDetailViewModel.swift
├── Models/
│   └── Task.swift
├── Services/
│   └── TaskService.swift
└── Resources/
```

**Key principles:**
- Group by feature (not by type)
- Keep related code together
- Clear boundaries between features
- Shared code in Core/
</project_structure>

<file_organization>
## File Structure Standards

**Single responsibility:**
- One primary type per file (one View, one ViewModel, one Model)
- File name matches type name
- Keep files under 300 lines (200 ideal)

**Good file structure:**

```swift
// TaskListView.swift

import SwiftUI

// MARK: - Main View
struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Tasks")
                .toolbar { toolbarContent }
        }
        .task { await viewModel.loadTasks() }
    }

    // MARK: - Subviews
    private var content: some View {
        List(viewModel.tasks) { task in
            TaskRow(task: task)
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button("Add", systemImage: "plus") {
                viewModel.showAddTask = true
            }
        }
    }
}

// MARK: - Supporting Types
private struct TaskRow: View {
    let task: Task

    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    TaskListView()
}
```

**MARK comments for organization:**
- `// MARK: - Main View`
- `// MARK: - Subviews`
- `// MARK: - Actions`
- `// MARK: - Supporting Types`
- `// MARK: - Preview`
</file_organization>

<naming_conventions>
## Naming Standards

**Views:**
```swift
TaskListView.swift       // Screen/container
TaskRow.swift           // List item
TaskDetailHeader.swift  // Component
EmptyTaskListView.swift // State view
```

**ViewModels:**
```swift
TaskListViewModel.swift
TaskDetailViewModel.swift
```

**Models:**
```swift
Task.swift
User.swift
Project.swift
```

**Services:**
```swift
TaskService.swift       // Domain service
NetworkService.swift    // Infrastructure
StorageService.swift    // Infrastructure
```

**Extensions:**
```swift
Color+App.swift         // App-specific colors
Date+Formatting.swift   // Helper methods
View+Extensions.swift   // SwiftUI view modifiers
```

**Protocols:**
```swift
TaskServiceProtocol.swift
Identifiable.swift
```
</naming_conventions>

<view_decomposition>
## Breaking Down Large Views

**Extract subviews when:**
- Body method >50 lines
- Repeated UI patterns
- Complex logic in one section
- Testing individual components

**Before (monolithic):**
```swift
struct TaskListView: View {
    var body: some View {
        VStack {
            // Header (30 lines)
            // Search bar (20 lines)
            // Filter chips (25 lines)
            // Task list (40 lines)
            // Empty state (20 lines)
            // Footer (15 lines)
        }
    }
}
```

**After (decomposed):**
```swift
struct TaskListView: View {
    var body: some View {
        VStack {
            TaskListHeader()
            SearchBar(text: $searchText)
            FilterChips(selected: $filter)

            if viewModel.tasks.isEmpty {
                EmptyTaskListView()
            } else {
                TaskList(tasks: viewModel.tasks)
            }

            TaskListFooter()
        }
    }
}

// Each in separate file or private subview
private struct TaskListHeader: View { }
private struct SearchBar: View { }
private struct FilterChips: View { }
private struct TaskList: View { }
private struct EmptyTaskListView: View { }
private struct TaskListFooter: View { }
```
</view_decomposition>

<modularity>
## Reusable Components

**Create reusable components in DesignSystem:**

```swift
// Core/DesignSystem/Components/PrimaryButton.swift

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(12)
        }
    }
}

// Use throughout app
PrimaryButton(title: "Save", action: save)
```

**ViewModifiers for repeated patterns:**

```swift
// Core/DesignSystem/ViewModifiers/CardStyle.swift

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}

// Use anywhere
VStack { }
    .cardStyle()
```
</modularity>

<dependency_management>
## Managing Dependencies

**Protocol-based services:**

```swift
// Core/Services/TaskServiceProtocol.swift
protocol TaskServiceProtocol {
    func fetchTasks() async throws -> [Task]
    func createTask(_ task: Task) async throws
}

// Core/Services/TaskService.swift
class TaskService: TaskServiceProtocol {
    static let shared = TaskService()

    func fetchTasks() async throws -> [Task] {
        // Implementation
    }
}

// Core/Services/MockTaskService.swift (for previews/tests)
class MockTaskService: TaskServiceProtocol {
    func fetchTasks() async throws -> [Task] {
        [
            Task(id: "1", title: "Sample task"),
            Task(id: "2", title: "Another task")
        ]
    }
}
```

**Dependency injection:**

```swift
// ViewModel
class TaskListViewModel: ObservableObject {
    private let taskService: TaskServiceProtocol

    init(taskService: TaskServiceProtocol = TaskService.shared) {
        self.taskService = taskService
    }
}

// In preview
#Preview {
    TaskListView(
        viewModel: TaskListViewModel(taskService: MockTaskService())
    )
}
```
</dependency_management>

<constants>
## Constants Organization

**Centralize magic numbers and strings:**

```swift
// Core/Utilities/Constants.swift

enum AppConstants {
    enum Layout {
        static let cornerRadius: CGFloat = 12
        static let cardPadding: CGFloat = 16
        static let sectionSpacing: CGFloat = 24
    }

    enum Animation {
        static let standardDuration: Double = 0.3
        static let quickDuration: Double = 0.15
        static let standardSpring = Animation.spring(duration: 0.3, bounce: 0)
    }

    enum API {
        static let baseURL = "https://api.example.com"
        static let timeout: TimeInterval = 30
    }
}

// Usage
.cornerRadius(AppConstants.Layout.cornerRadius)
.animation(AppConstants.Animation.standardSpring, value: isExpanded)
```

**Or use extensions:**

```swift
// Core/DesignSystem/Spacing.swift
extension CGFloat {
    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 16
    static let spacingL: CGFloat = 24
    static let spacingXL: CGFloat = 32
}

// Usage
.padding(.spacingL)
```
</constants>

<extensions>
## Extensions Organization

**Group by domain:**

```swift
// Core/Utilities/Color+App.swift
extension Color {
    static let actionPrimary = Color("ActionPrimary")
    static let actionSecondary = Color("ActionSecondary")
}

// Core/Utilities/View+Extensions.swift
extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}

// Core/Utilities/Date+Formatting.swift
extension Date {
    func formatted(as format: DateFormat) -> String {
        // Custom formatting
    }
}
```
</extensions>

<previews>
## Preview Organization

**Preview at bottom of file:**

```swift
// MARK: - Preview
#Preview {
    TaskListView()
}

#Preview("Empty State") {
    TaskListView(
        viewModel: TaskListViewModel(taskService: EmptyMockService())
    )
}

#Preview("Dark Mode") {
    TaskListView()
        .preferredColorScheme(.dark)
}
```

**Preview helpers:**

```swift
// Core/Utilities/PreviewHelpers.swift

struct PreviewContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            content
        }
    }
}

// Usage
#Preview {
    PreviewContainer {
        TaskListView()
    }
}
```
</previews>

<anti_patterns>
## Organization Anti-Patterns

<anti_pattern name="God Files">
**Problem:** Single file with 1000+ lines, multiple types

**Fix:** One primary type per file, extract to separate files
</anti_pattern>

<anti_pattern name="Organized by Type">
**Problem:** All views together, all models together (breaks feature cohesion)

```
Views/
  TaskListView.swift
  TaskDetailView.swift
  SettingsView.swift
Models/
  Task.swift
  Setting.swift
```

**Fix:** Organize by feature
```
Features/
  TaskList/
    TaskListView.swift
    TaskListViewModel.swift
  TaskDetail/
    TaskDetailView.swift
```
</anti_pattern>

<anti_pattern name="Deeply Nested Folders">
**Problem:** Features/Tasks/Views/Components/Buttons/Primary/

**Fix:** Keep nesting shallow (2-3 levels max)
</anti_pattern>

<anti_pattern name="Unclear Naming">
**Problem:** View1.swift, Manager.swift, Helper.swift

**Fix:** Descriptive names: TaskListView.swift, TaskService.swift, DateFormatter+Extensions.swift
</anti_pattern>

<anti_pattern name="No Constants">
**Problem:** Magic numbers scattered throughout code

```swift
.padding(16)  // File 1
.padding(18)  // File 2
.padding(14)  // File 3
```

**Fix:** Centralize constants
```swift
.padding(.spacingM)  // Everywhere
```
</anti_pattern>
</anti_patterns>

<file_templates>
## File Templates

**View template:**

```swift
// FeatureView.swift

import SwiftUI

// MARK: - Main View
struct FeatureView: View {
    @StateObject private var viewModel = FeatureViewModel()

    var body: some View {
        content
            .navigationTitle("Title")
    }

    // MARK: - Subviews
    private var content: some View {
        VStack {
            // Content here
        }
    }
}

// MARK: - Preview
#Preview {
    FeatureView()
}
```

**ViewModel template:**

```swift
// FeatureViewModel.swift

import Foundation

@MainActor
class FeatureViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var items: [Item] = []
    @Published var isLoading = false
    @Published var error: Error?

    // MARK: - Private Properties
    private let service: ServiceProtocol

    // MARK: - Initialization
    init(service: ServiceProtocol = Service.shared) {
        self.service = service
    }

    // MARK: - Public Methods
    func loadItems() async {
        isLoading = true
        defer { isLoading = false }

        do {
            items = try await service.fetchItems()
        } catch {
            self.error = error
        }
    }
}
```
</file_templates>

<checklist>
## Organization Checklist

Before committing code:

- [ ] Files under 300 lines
- [ ] One primary type per file
- [ ] File name matches type name
- [ ] Organized by feature (not by type)
- [ ] MARK comments for sections
- [ ] Extracted reusable components
- [ ] Constants defined (no magic numbers)
- [ ] Extensions organized by domain
- [ ] Preview included
- [ ] Clear, descriptive names
- [ ] Dependencies injected (not hardcoded)
- [ ] No deeply nested folders
</checklist>
