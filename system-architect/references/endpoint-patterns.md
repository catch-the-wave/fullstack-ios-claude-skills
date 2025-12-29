# Endpoint Design Patterns

## Pattern: Client-Specific Unified Endpoints

When different clients have different storage needs but share processing logic:

```
┌─────────────────────────────────────────────────────────────┐
│                     BACKEND (Shared Logic)                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   Internal: transcribe() + analyze()                        │
│   (reusable functions, not exposed directly)                │
│                                                             │
│   /transcribe                      /telegram/voice          │
│   ─────────────                    ────────────────         │
│   For: iOS, generic clients        For: Telegram bot        │
│   Does: transcribe + analyze       Does: transcribe +       │
│   Returns: all data                      analyze + STORE    │
│   Storage: client's job            Returns: transcript      │
│                                    Storage: PostgreSQL      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Why this works:**
- Shared logic (transcribe, analyze) is internal
- Each endpoint is explicit about what it does
- No magic params, no implicit behavior
- Client calls ONE endpoint, gets exactly what it needs

## Pattern: Command vs Query Separation

```
# QUERIES (GET) - Read, no side effects
GET /capsules           → List capsules
GET /capsules/{id}      → Get one capsule
GET /search?q=...       → Search capsules

# COMMANDS (POST/PUT/DELETE) - Write, has side effects
POST /capsules          → Create capsule
PUT /capsules/{id}      → Update capsule
DELETE /capsules/{id}   → Delete capsule

# OPERATIONS (POST) - Complex actions
POST /transcribe        → Process audio → return result
POST /telegram/voice    → Process audio → store → return
```

**Rule:** GET never mutates. POST/PUT/DELETE always mutates.

## Pattern: Atomic Operations

If an operation requires multiple steps, make ONE endpoint that does all steps atomically.

```python
# BAD: Client coordinates
# 1. Client: POST /transcribe
# 2. Client: POST /analyze
# 3. Client: POST /store
# Problem: What if step 2 fails? Inconsistent state.

# GOOD: Backend coordinates
# Client: POST /telegram/voice
# Backend internally: transcribe → analyze → store (all or nothing)
```

**Rule:** If steps must succeed together, they're one endpoint.

## Pattern: Resource-Based vs Action-Based

**Resource-based (RESTful):**
```
POST /capsules              → Create
GET /capsules/{id}          → Read
PUT /capsules/{id}          → Update
DELETE /capsules/{id}       → Delete
```

**Action-based (RPC-style):**
```
POST /transcribe            → Transcribe audio
POST /analyze               → Analyze text
POST /telegram/voice        → Full telegram flow
```

**When to use which:**
- CRUD operations → Resource-based
- Complex processing → Action-based
- Mix is fine, be consistent within each domain

## Anti-Pattern: Verb in URL for CRUD

```
# BAD
POST /createCapsule
POST /deleteCapsule
POST /updateCapsule

# GOOD
POST /capsules
DELETE /capsules/{id}
PUT /capsules/{id}
```

**Exception:** Action endpoints are fine:
```
POST /transcribe      ← This is an action, not CRUD
POST /analyze         ← This is an action, not CRUD
```

## Pattern: Consistent Response Shapes

```python
# Success
{
    "success": true,
    "data": { ... }
}

# Error
{
    "success": false,
    "error": {
        "code": "INVALID_AUDIO",
        "message": "Audio file is corrupted"
    }
}
```

**Or simpler:**
- 2xx status + data for success
- 4xx/5xx status + error object for failure

Pick one, use it everywhere.

## Pattern: Pagination

```
GET /capsules?limit=20&offset=0

Response:
{
    "items": [...],
    "total": 150,
    "limit": 20,
    "offset": 0,
    "has_more": true
}
```

## Pattern: Filtering and Search

```
# Simple filters as query params
GET /capsules?emotion=happy&category=task

# Complex search as POST (when query string gets unwieldy)
POST /capsules/search
{
    "query": "productivity tips",
    "filters": { "emotion": "happy" },
    "limit": 20
}
```
