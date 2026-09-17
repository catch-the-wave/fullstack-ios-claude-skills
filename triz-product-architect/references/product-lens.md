# TRIZ Product Lens

## Product Parameters (39 → Product)

The original 39 TRIZ parameters are for physical systems. Here's the product translation.
Use these to map your contradiction to the matrix and find relevant principles.

### Core Product Parameters

| # | Original | Product Translation | Examples |
|---|----------|---------------------|----------|
| 1 | Weight (moving) | **Cognitive load** | Mental effort to use feature, learning curve |
| 2 | Weight (stationary) | **Technical debt** | Code complexity, maintenance burden |
| 3 | Length (moving) | **User journey length** | Steps to complete task, tap count |
| 4 | Length (stationary) | **Codebase size** | Lines of code, number of files |
| 5 | Area (moving) | **Screen real estate (active)** | Space used by interactive elements |
| 6 | Area (stationary) | **Screen real estate (passive)** | Space used by static/structural elements |
| 7 | Volume (moving) | **Data in motion** | Network payload, sync volume |
| 8 | Volume (stationary) | **Data at rest** | Storage footprint, cache size |
| 9 | Speed | **Responsiveness** | Latency, frame rate, perceived speed |
| 10 | Force | **User effort** | Physical/mental effort per action |
| 11 | Stress/pressure | **System load** | Concurrent users, peak traffic, memory pressure |
| 12 | Shape | **Information architecture** | Navigation structure, content hierarchy |
| 13 | Stability | **State consistency** | Data integrity, sync reliability |
| 14 | Strength | **Robustness** | Crash resistance, edge case handling |
| 15 | Duration (moving) | **Session duration** | How long users engage per session |
| 16 | Duration (stationary) | **Product longevity** | How long product stays relevant |
| 17 | Temperature | **Emotional tone** | Urgency, delight, anxiety level of UI |
| 18 | Illumination | **Information clarity** | How well UI communicates state/meaning |
| 19 | Energy (moving) | **Battery/resource use** | Power consumption during active use |
| 20 | Energy (stationary) | **Background resource use** | Background sync, idle consumption |
| 21 | Power | **Processing intensity** | CPU/GPU per operation |
| 22 | Energy loss | **Wasted computation** | Unnecessary fetches, redundant processing |
| 23 | Substance loss | **Data loss** | Lost user input, failed saves |
| 24 | Information loss | **Context loss** | Losing user's place, forgetting state |
| 25 | Time loss | **User time wasted** | Waiting, re-doing, navigating back |
| 26 | Quantity | **Feature count** | Number of capabilities, settings |
| 27 | Reliability | **Reliability** | Uptime, consistency, predictability |
| 28 | Measurement accuracy | **Analytics precision** | How well you understand user behavior |
| 29 | Manufacturing precision | **Implementation quality** | Code correctness, pixel perfection |
| 30 | External harm | **External disruption tolerance** | Handles network loss, OS interrupts |
| 31 | Harmful factors | **Negative side effects** | Notification fatigue, distraction, anxiety |
| 32 | Ease of manufacture | **Development velocity** | How fast team can build/iterate |
| 33 | Ease of operation | **Usability** | Intuitiveness, discoverability, learnability |
| 34 | Ease of repair | **Debuggability** | How easy to diagnose and fix issues |
| 35 | Adaptability | **Flexibility** | Supports diverse use cases, extensibility |
| 36 | Complexity | **System complexity** | Architecture complexity, moving parts |
| 37 | Detectability | **Observability** | Logging, monitoring, user feedback signals |
| 38 | Automation | **Intelligence** | AI/ML features, auto-behavior |
| 39 | Productivity | **User throughput** | Tasks completed per unit time |

---

## Top 15 Principles for Product Work

These are the principles that solve product problems most often.
For each: what it means, and a real product example.

### #1 Segmentation — Break into independent parts
**Product**: Split monolithic feature into composable pieces.
- One mega-settings screen → categorized settings panels
- One search → search + filters + smart search as separate capabilities
- Monolithic editor → modular capsule-based editor (Mindcraft!)

### #2 Taking Out — Extract the interfering part
**Product**: Remove the thing that creates the contradiction.
- Remove "save" button entirely (auto-save eliminates save/lose dilemma)
- Extract destructive actions from the main flow (archive instead of delete)
- Separate creation from organization (capture now, organize later)

### #3 Local Quality — Different parts serve different functions
**Product**: Don't make everything uniform.
- Card surface: minimal. Card swipe-reveal: full actions. (Mindcraft!)
- List view for scanning, detail view for reading
- Compact mode for power users, spacious mode for new users

### #6 Universality — One element, multiple functions
**Product**: Fuller's "more with less" — the highest-leverage principle.
- Swipe gesture = navigate + reveal actions + select (Mindcraft!)
- Search bar = search + filter + command palette
- Tag = organization + navigation + discovery

### #10 Preliminary Action — Do the work before it's needed
**Product**: Pre-compute, pre-fetch, pre-arrange.
- Generate embeddings at capture time, not search time
- Pre-load related cards while viewing current card
- Auto-tag during import, not as a separate step

### #13 Inversion — Do it the opposite way
**Product**: Challenge "how it's always done."
- Don't navigate TO content; bring content TO user (feed vs browse)
- Don't organize then find; find then organization emerges
- Don't ask user to categorize; infer from behavior

### #15 Dynamics — Make it adaptive
**Product**: Static → dynamic → contextual → anticipatory.
- Fixed toolbar → contextual toolbar based on content
- Static sort → sort adapts to what user usually picks
- Fixed layout → layout responds to content density

### #17 Another Dimension — Add a dimension
**Product**: Use layers, depth, time as new axes.
- 2D list → depth via swipe-reveal layers (Mindcraft!)
- Single timeline → split by content type (stream types)
- Flat tags → tag graph with relationships

### #22 Blessing in Disguise — Turn harm into benefit
**Product**: The constraint IS the feature.
- Small screen → forces focus → single-purpose screens are better UX
- No internet → offline-first → faster, more reliable
- Limited context → forces progressive disclosure → less overwhelming

### #24 Intermediary — Use a mediating element
**Product**: Don't connect directly; use an adapter/broker.
- API gateway between client and services
- NavigationCoordinator between views and destinations
- ViewModel between data model and UI

### #25 Self-Service — System serves/repairs itself
**Product**: Eliminate maintenance burden.
- Self-healing sync (detect + resolve conflicts automatically)
- Auto-cleanup of orphaned data
- Smart defaults that improve over time

### #26 Copying — Use a lightweight representation
**Product**: Don't use the real thing when a proxy works.
- Thumbnail instead of full image during scroll
- Card preview instead of full editor for selection
- Cached embedding instead of re-computing similarity

### #28 Mechanics Substitution — Replace with a different field
**Product**: Change the interaction modality entirely.
- Tap buttons → swipe gesture (Mindcraft!)
- Type search → voice search
- Manual organization → AI-driven organization

### #35 Parameter Changes — Change the form/state
**Product**: Transform the data or interaction model.
- Text → structured data (plain notes → capsules)
- Synchronous → asynchronous (blocking save → background sync)
- Explicit → implicit (manual tag → inferred tag)

### #40 Composite — Combine different materials
**Product**: Hybrid approaches that get the best of both.
- Local + cloud storage (speed + backup)
- Manual + AI organization (control + efficiency)
- Gesture + menu (speed + discoverability)

---

## Common Product Contradictions

These contradiction pairs appear in almost every product. Each links to
the most productive principles.

### UX Contradictions

| Improving | Worsens | Try Principles |
|-----------|---------|---------------|
| Feature richness (#26) | Usability (#33) | #1 Segmentation, #3 Local Quality, #15 Dynamics |
| Discoverability (#18) | Clean UI (#5,#6) | #17 Another Dimension, #15 Dynamics, #3 Local Quality |
| Personalization (#35) | Privacy (#31) | #2 Taking Out, #35 Parameter Changes, #26 Copying |
| Power user efficiency (#39) | Beginner friendliness (#33) | Physical Contradiction → Separate in Condition |
| Engagement/session (#15) | Respect for time (#25) | #22 Blessing in Disguise, #13 Inversion |
| Information density (#18) | Cognitive load (#1) | #1 Segmentation, #15 Dynamics, #17 Another Dimension |

### Architecture Contradictions

| Improving | Worsens | Try Principles |
|-----------|---------|---------------|
| Flexibility (#35) | Performance (#9) | #10 Preliminary Action, #15 Dynamics |
| Reliability (#27) | Complexity (#36) | #1 Segmentation, #25 Self-Service |
| Development speed (#32) | Code quality (#29) | #10 Preliminary Action, #24 Intermediary |
| Offline capability (#30) | Data freshness (#13) | #35 Parameter Changes, #19 Periodic Action |
| Real-time sync (#9) | Battery life (#19) | #19 Periodic Action, #15 Dynamics |

### Business Contradictions

| Improving | Worsens | Try Principles |
|-----------|---------|---------------|
| Revenue (#39) | User experience (#33) | #3 Local Quality, #15 Dynamics |
| Growth (#39) | Quality (#29) | #1 Segmentation, #10 Preliminary Action |
| Customization (#35) | Scalability (#36) | #1 Segmentation, #35 Parameter Changes |
| Speed to market (#32) | Technical debt (#2) | #10 Preliminary Action, #24 Intermediary |

---

## Physical Contradiction Patterns in Product

These are "must be X AND not-X" situations. Resolution always uses separation.

| Contradiction | Separation | Product Solution |
|---------------|-----------|------------------|
| Must be visible AND hidden | **In Time**: Visible when needed, hidden otherwise | Search bar appears on pull-down, hides on scroll |
| Must be simple AND powerful | **In Condition**: Simple for beginners, powerful for experts | Progressive disclosure, pro mode |
| Must be fast AND thorough | **In Scale**: Fast at surface, thorough underneath | Instant UI response, background processing |
| Must be flexible AND consistent | **In Space**: Flexible in content area, consistent in chrome | Fixed navigation + customizable content |
| Must be personal AND social | **In Condition**: Personal by default, social on share | Private-first with explicit sharing |
| Must be dense AND readable | **In Time**: Dense in list, readable on tap/expand | Compact cards that expand to detail |
| Must save everything AND stay fast | **In Scale**: Save everything at data layer, show subset at UI layer | Lazy loading, pagination, virtualization |
