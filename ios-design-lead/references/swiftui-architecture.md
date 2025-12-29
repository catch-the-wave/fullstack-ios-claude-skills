<overview>
SwiftUI enables multiple architectural patterns. Choose based on complexity: simple views use local @State, complex features use MVVM with ObservableObject, large apps may need TCA or similar. Always prioritize clarity over dogma.
</overview>

<architecture_patterns>
## When to Use Each Pattern

<pattern name="Simple View (Local State)">
**When:** Single view, minimal logic, no reuse needed

```swift
struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
            Button("Increment") {
                count += 1
            }
        }
    }
}
```

**Use for:**
- Simple toggles, counters
- UI-only state (expanded/collapsed)
- No business logic
- Self-contained views

**Don't use for:**
- Shared state across views
- Network requests
- Complex business logic
</pattern>

<pattern name="MVVM (Model-View-ViewModel)">
**When:** Complex views, business logic, testability needed

```swift
// ViewModel
@MainActor
class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading = false

    private let taskService: TaskService

    init(taskService: TaskService = .shared) {
        self.taskService = taskService
    }

    func loadTasks() async {
        isLoading = true
        defer { isLoading = false }

        do {
            tasks = try await taskService.fetchTasks()
        } catch {
            // Handle error
        }
    }

    func completeTask(_ task: Task) {
        // Business logic here
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
        }
    }
}

// View
struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()

    var body: some View {
        List(viewModel.tasks) { task in
            TaskRow(task: task, onComplete: {
                viewModel.completeTask(task)
            })
        }
        .task {
            await viewModel.loadTasks()
        }
    }
}
```

**Use for:**
- Network requests
- Business logic
- Multiple views sharing state
- Testable code
- Data transformations

**Benefits:**
- Clear separation of concerns
- Testable (can test ViewModel in isolation)
- Reusable logic
- SwiftUI friendly (@Published)
</pattern>

<pattern name="MV (Model-View)">
**When:** Apple's recommendation - simpler than MVVM for many cases

```swift
// Model (with logic)
@Observable
class TaskStore {
    var tasks: [Task] = []

    func addTask(_ task: Task) {
        tasks.append(task)
    }

    func completeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted = true
        }
    }
}

// View
struct TaskListView: View {
    @State private var store = TaskStore()

    var body: some View {
        List(store.tasks) { task in
            TaskRow(task: task) {
                store.completeTask(task)
            }
        }
    }
}
```

**iOS 17+ with @Observable macro:**
- Simpler than MVVM
- Less boilerplate
- Automatic dependency tracking
- Apple's modern recommendation

**Use for:**
- iOS 17+ apps
- Medium complexity
- When MVVM feels over-engineered
</pattern>
</architecture_patterns>

<state_management>
## State Management Rules

<rule name="@State">
**Use for:** Local, private view state

```swift
@State private var isExpanded = false
@State private var searchText = ""
```

**When:**
- UI-only state (expand/collapse, selection)
- Private to this view
- Simple values
- Not shared with other views
</rule>

<rule name="@StateObject">
**Use for:** View owns the object lifecycle

```swift
@StateObject private var viewModel = TaskListViewModel()
```

**When:**
- View creates and owns the object
- Object should survive view updates
- First time creating the observable object in this view

**Critical:** Only use when THIS view is the owner
</rule>

<rule name="@ObservedObject">
**Use for:** View observes object owned by parent

```swift
@ObservedObject var viewModel: TaskListViewModel
```

**When:**
- Object passed from parent view
- View doesn't own the object
- Object created elsewhere

**Don't:** Create object here (use @StateObject instead)
</rule>

<rule name="@EnvironmentObject">
**Use for:** Deeply nested shared state

```swift
@EnvironmentObject var appState: AppState

// In parent:
.environmentObject(appState)
```

**Use for:**
- App-wide state (user, theme, settings)
- Avoiding prop drilling
- Shared across many views

**Warning:** Will crash if not provided - ensure parent injects it
</rule>

<rule name="@Environment">
**Use for:** System-provided values

```swift
@Environment(\.dismiss) var dismiss
@Environment(\.colorScheme) var colorScheme
```

**Common values:**
- .dismiss (close sheet)
- .colorScheme (light/dark)
- .accessibilityReduceMotion
- .managedObjectContext (Core Data)
</rule>
</state_management>

<data_flow>
## Data Flow Patterns

**Unidirectional flow (recommended):**

```
User Action → ViewModel method → Update @Published property → View updates
```

**Example:**
```swift
// User taps button
Button("Add Task") {
    viewModel.addTask(newTask)  // 1. Action
}

// ViewModel
func addTask(_ task: Task) {
    tasks.append(task)  // 2. Update published property
}

// View automatically updates  // 3. SwiftUI re-renders
```

**Anti-pattern (two-way binding overuse):**
```swift
// Don't expose mutable published properties directly
TextField("Title", text: $viewModel.taskTitle)  // Risky

// Better: Controlled component
TextField("Title", text: $title)
    .onChange(of: title) { _, newValue in
        viewModel.updateTitle(newValue)
    }
```
</data_flow>

<dependency_injection>
## Dependency Injection

**Constructor injection (recommended):**

```swift
class TaskListViewModel: ObservableObject {
    private let taskService: TaskServiceProtocol

    init(taskService: TaskServiceProtocol = TaskService.shared) {
        self.taskService = taskService
    }
}
```

**Benefits:**
- Testable (inject mock service)
- Explicit dependencies
- Default value for production

**Protocol-based (for testing):**

```swift
protocol TaskServiceProtocol {
    func fetchTasks() async throws -> [Task]
}

class TaskService: TaskServiceProtocol {
    static let shared = TaskService()

    func fetchTasks() async throws -> [Task] {
        // Real implementation
    }
}

class MockTaskService: TaskServiceProtocol {
    func fetchTasks() async throws -> [Task] {
        // Mock data for tests
    }
}

// In tests:
let viewModel = TaskListViewModel(taskService: MockTaskService())
```
</dependency_injection>

<async_patterns>
## Modern Async/Await Patterns

**Loading data:**

```swift
class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading = false
    @Published var error: Error?

    func loadTasks() async {
        isLoading = true
        error = nil

        defer { isLoading = false }

        do {
            tasks = try await taskService.fetchTasks()
        } catch {
            self.error = error
        }
    }
}

// In view:
.task {
    await viewModel.loadTasks()
}
.refreshable {
    await viewModel.loadTasks()
}
```

**Multiple concurrent requests:**

```swift
func loadData() async {
    async let tasks = taskService.fetchTasks()
    async let user = userService.fetchUser()

    do {
        self.tasks = try await tasks
        self.user = try await user
    } catch {
        self.error = error
    }
}
```
</async_patterns>

<error_handling>
## Error Handling Patterns

**ViewModel handles errors:**

```swift
@Published var error: Error?
@Published var showError = false

func loadTasks() async {
    do {
        tasks = try await taskService.fetchTasks()
    } catch {
        self.error = error
        self.showError = true
    }
}

// View displays:
.alert("Error", isPresented: $viewModel.showError) {
    Button("OK") { viewModel.showError = false }
} message: {
    Text(viewModel.error?.localizedDescription ?? "Unknown error")
}
```

**Result type for complex flows:**

```swift
enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}

@Published var tasksState: LoadingState<[Task]> = .idle

func loadTasks() async {
    tasksState = .loading

    do {
        let tasks = try await taskService.fetchTasks()
        tasksState = .loaded(tasks)
    } catch {
        tasksState = .failed(error)
    }
}

// View handles all states:
switch viewModel.tasksState {
case .idle:
    EmptyView()
case .loading:
    ProgressView()
case .loaded(let tasks):
    TaskList(tasks: tasks)
case .failed(let error):
    ErrorView(error: error)
}
```
</error_handling>

<performance_patterns>
## Performance Best Practices

**Lazy initialization:**

```swift
// Don't create expensive objects in init
class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    private lazy var expensiveProcessor = HeavyProcessor()

    func process() {
        // Only created when first used
        expensiveProcessor.process(tasks)
    }
}
```

**Computed properties (avoid heavy work):**

```swift
// Bad: Heavy computation in computed property
var filteredTasks: [Task] {
    tasks.filter { /* complex logic */ }  // Recalculates on every access
}

// Good: Cache the result
@Published var filteredTasks: [Task] = []

func updateFilter() {
    filteredTasks = tasks.filter { /* complex logic */ }
}
```

**Debouncing search:**

```swift
import Combine

@Published var searchText = ""
private var cancellables = Set<AnyCancellable>()

init() {
    $searchText
        .debounce(for: 0.3, scheduler: DispatchQueue.main)
        .sink { [weak self] text in
            self?.performSearch(text)
        }
        .store(in: &cancellables)
}
```
</performance_patterns>

<testing>
## Making Code Testable

**ViewModel tests:**

```swift
@MainActor
class TaskListViewModelTests: XCTestCase {
    func testLoadTasks() async {
        // Arrange
        let mockService = MockTaskService()
        let viewModel = TaskListViewModel(taskService: mockService)

        // Act
        await viewModel.loadTasks()

        // Assert
        XCTAssertEqual(viewModel.tasks.count, 3)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testCompleteTask() {
        // Arrange
        let viewModel = TaskListViewModel()
        viewModel.tasks = [Task(id: "1", title: "Test")]

        // Act
        viewModel.completeTask(viewModel.tasks[0])

        // Assert
        XCTAssertTrue(viewModel.tasks[0].isCompleted)
    }
}
```

**Keys to testability:**
- Dependency injection (inject mock services)
- Protocol-based dependencies
- ViewModels contain logic (not views)
- Async methods are testable with async/await
</testing>

<decision_tree>
## Choosing Architecture

**Start here:**

1. **Is it a single view with minimal logic?**
   → Use @State (local state)

2. **Does it need business logic or network requests?**
   → Use MVVM with ObservableObject

3. **iOS 17+ and medium complexity?**
   → Consider MV with @Observable

4. **Is it app-wide state (user, theme)?**
   → Use @EnvironmentObject

5. **Large app with complex state?**
   → Consider TCA (The Composable Architecture) or similar

**When uncertain:** Start with MVVM. It's battle-tested and widely understood.
</decision_tree>

<anti_patterns>
## Architecture Anti-Patterns

<anti_pattern name="Massive ViewModels">
**Problem:** ViewModel has 1000+ lines, does everything

**Fix:** Split into multiple ViewModels or extract services
```swift
// Instead of one massive TaskViewModel:
TaskListViewModel  // List operations
TaskDetailViewModel  // Detail operations
TaskService  // Network/data logic
```
</anti_pattern>

<anti_pattern name="Views with Business Logic">
**Problem:** Complex logic in view's body or methods

```swift
// Bad
var body: some View {
    Button("Add") {
        // 50 lines of business logic here
    }
}

// Good
Button("Add") {
    viewModel.addTask()
}
```
</anti_pattern>

<anti_pattern name="@StateObject vs @ObservedObject Confusion">
**Problem:** Using @ObservedObject when view owns object

```swift
// Bad: Object recreated on every view update
@ObservedObject private var viewModel = TaskListViewModel()

// Good: Object persists
@StateObject private var viewModel = TaskListViewModel()
```
</anti_pattern>

<anti_pattern name="Retain Cycles">
**Problem:** ViewModel retains view, view retains viewModel

```swift
// Bad
class TaskListViewModel: ObservableObject {
    var onUpdate: (() -> Void)?  // Strong reference
}

// Good: Use weak self in closures
$searchText
    .sink { [weak self] text in
        self?.performSearch(text)
    }
    .store(in: &cancellables)
```
</anti_pattern>
</anti_patterns>

<sources>
Based on modern SwiftUI best practices (2024-2025):
- [Modern iOS Architecture - Medium](https://medium.com/@csmax/the-ultimate-guide-to-modern-ios-architecture-in-2025-9f0d5fdc892f)
- [SwiftUI Design Patterns - Best Practices](https://medium.com/@gongati/swiftui-design-patterns-best-practices-and-architectures-2d5123c9560f)
- [Choosing a Design Pattern for SwiftUI](https://medium.com/@alexanderson_16451/choosing-a-design-pattern-for-your-swiftui-app-163c06ffcd9b)
- Apple's SwiftUI documentation and WWDC sessions
</sources>
