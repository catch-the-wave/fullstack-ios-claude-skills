# Knowledge File Template

Template for `.claude/CODEBASE.md` created by codebase-analyzer agent.

## Full Template

```markdown
# [Project Name]

**Last analyzed:** [date]
**Stack:** [languages, frameworks]
**Clients:** [what consumes this]

## Architecture

[2-5 bullet points max. Entry points, core abstractions, data flow]

- Entry: `app/main.py` → FastAPI
- Structure: Feature-based (`app/{feature}/`)
- Data: PostgreSQL + SQLAlchemy async
- Auth: Supabase JWT validation
- Background: Celery + Redis

## Patterns

[Conventions this codebase follows. Be specific with file:line refs]

| Pattern | Example | Notes |
|---------|---------|-------|
| LLM fallback | `services/enhancer.py:45` | Groq → OpenAI |
| Repository pattern | `app/*/repository.py` | All DB access |
| Pydantic schemas | `app/*/schemas.py` | Request/response |

## Smells

[Checkbox list. Check when fixed. Include severity]

- [ ] **HIGH** DRY: `enhancer.py` ≈ `paragraph_splitter.py` (90% identical)
- [ ] **MED** God file: `main.py` (245 lines, mix of concerns)
- [ ] **LOW** Magic numbers: `services/transcription.py:78`
- [x] ~~API versioning missing~~ Fixed in commit abc123

## Decisions

[Why things are the way they are. Prevents "why did they do this?" questions]

| Decision | Rationale | Source |
|----------|-----------|--------|
| Groq as primary LLM | 10x cheaper than OpenAI | `# Cost optimization` comment |
| No ORM relationships | Explicit joins for performance | PR #42 discussion |
| Celery over asyncio | Long-running transcription tasks | Architecture doc |

## API Surface

[Key endpoints, grouped by feature]

### Auth
- `POST /auth/register` - Create account
- `POST /auth/login` - Get JWT

### [Feature Name]
- `GET /resource` - List resources
- `POST /resource` - Create resource
- `POST /resource/{id}/action` - Trigger action

## Dependencies

[External services and their purpose]

| Service | Purpose | Config |
|---------|---------|--------|
| Supabase | Auth + Storage | `SUPABASE_URL` |
| Groq | Primary LLM | `GROQ_API_KEY` |
| OpenAI | Fallback LLM | `OPENAI_API_KEY` |
| Redis | Celery broker | `REDIS_URL` |
```

## Section Guidelines

### Architecture
- Max 5 bullet points
- Focus on: entry point, structure pattern, data layer, auth, background jobs
- Use arrow notation for flow: `main.py` → FastAPI

### Patterns
- Use tables for scannability
- Always include file:line reference
- Group by pattern type (data access, API, processing)

### Smells
- Use checkbox format: `- [ ]` open, `- [x]` fixed
- Severity prefix: **HIGH**, **MED**, **LOW**
- Include location and brief description
- Strike through when fixed: `~~description~~`

### Decisions
- Capture the "why" not the "what"
- Source can be: comment, PR, commit, doc, verbal
- Helps future developers understand intent

### API Surface
- Group by feature/domain
- Format: `METHOD /path` - description
- Only include key endpoints, not exhaustive list

### Dependencies
- External services only
- Include config env var name
- Brief purpose description
