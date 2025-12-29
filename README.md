# Claude Code Skills

A collection of specialized skills and agents for [Claude Code](https://claude.ai/claude-code) — Anthropic's CLI for AI-assisted software development.

These skills encode domain expertise, thinking frameworks, and best practices learned through real-world product development. They're designed to make Claude a better thinking partner, not just a code generator.

## What's Inside

### 🎨 ios-design-lead
World-class iOS interface design with consciousness, minimalism, and premium feel.

**Capabilities:**
- Scenario-based development (implement → build → verify → next)
- Physics-based animations (springs, haptics, gestures)
- Accessibility-first design (Dynamic Type, VoiceOver)
- AJTBD integration for job-driven design decisions

**Workflows:** Design new interfaces, refine existing designs, add animations, gesture interactions, accessibility audits, design systems, microinteractions, code review.

### 🧠 ajtbd (Advanced Jobs To Be Done)
Product analysis methodology for understanding what customers actually need.

**Capabilities:**
- Job hierarchy analysis (Big Job → Core Job → Micro Jobs)
- Segment discovery (B2B/B2C)
- Risk analysis (RAT framework)
- Landing page generation
- Grounding analysis in UI reality

**Key insight:** "What IS this thing?" comes before "What features does it need?"

### 🏗️ system-architect
Backend architecture, API design, and ML/AI systems expertise.

**Capabilities:**
- API design patterns and anti-patterns
- ML pipeline architecture (embeddings, RAG, vector DBs)
- Trade-off analysis methodology
- Mandatory research via Perplexity before decisions
- Security & health audits (via agent)

**Core principle:** Backend owns business logic, clients stay dumb.

**Agents:**
- `codebase-analyzer` — Base agent that builds persistent knowledge (`.claude/CODEBASE.md`)
- `security-auditor` — Security scans with vulnerability tracking (`.claude/SECURITY.md`)

## Philosophy

### Rules Are Strong Defaults, Not Laws

Every skill includes a self-improvement loop:
```
📝 **Learning:** [observation from this task]
🔧 **Skill update?** [yes/no] — [what to change]
```

The skills evolve through use. When a principle clashes with reality, we update the principle.

### Think, Don't Just Execute

These skills emphasize:
- **First principles thinking** — Question the category, not just the instance
- **Sharp questions** — Find the fork that determines everything downstream
- **Outside-in design** — User intent over system constraints
- **Semantic identity** — Name things correctly before designing features

### Research Before Guessing

The system-architect skill mandates Perplexity research for:
- New technologies
- Best practice decisions
- Performance-critical architecture
- Security-sensitive designs

## Installation

```bash
# Clone to your Claude skills directory
git clone https://github.com/YOUR_USERNAME/claude-skills.git ~/.claude/skills

# Or if you have existing skills, clone elsewhere and symlink
git clone https://github.com/YOUR_USERNAME/claude-skills.git ~/claude-skills
ln -s ~/claude-skills/* ~/.claude/skills/
```

Restart Claude Code to load the skills.

## Usage

### Invoke via slash commands
```
/ios-design      → iOS design expertise
/system-architect → Backend/ML architecture
```

### Or naturally in conversation
```
"Help me design a new screen for task management"
→ ios-design-lead activates automatically

"Should we use Pinecone or pgvector?"
→ system-architect researches via Perplexity, builds trade-off table
```

### Spawn agents for autonomous tasks
```
"Audit my backend for security issues"
→ security-auditor agent scans codebase, produces report
```

## Structure

```
~/.claude/skills/
├── README.md
├── ios-design-lead/
│   ├── SKILL.md              # Core principles & routing
│   ├── workflows/            # Step-by-step processes
│   │   ├── design-new-interface.md
│   │   ├── refine-existing-design.md
│   │   ├── add-animation.md
│   │   └── ...
│   ├── references/           # Domain knowledge
│   │   ├── animations.md
│   │   ├── gestures.md
│   │   ├── accessibility.md
│   │   └── ...
│   └── templates/
├── ajtbd/
│   ├── skills/
│   │   └── ajtbd-methodology/
│   │       └── SKILL.md
│   ├── agents/
│   │   └── product-analyst.md
│   ├── book/                 # Full AJTBD methodology (5 parts)
│   └── claude-project-instruction.md  # For Claude Projects
└── system-architect/
    ├── SKILL.md              # API + ML/AI principles
    ├── references/
    │   └── endpoint-patterns.md
    └── agents/
        ├── codebase-analyzer.md  # Base: persistent knowledge
        └── security-auditor.md   # Security + vulnerability tracking
```

## Key Learnings Encoded

These skills capture hard-won lessons:

| Learning | Encoded In |
|----------|------------|
| Word repetition = visual noise | ios-design-lead anti-patterns |
| Nav bar ≠ action bar | ios-design-lead anti-patterns |
| Friction reveals model mismatch | ajtbd, ios-design-lead |
| "Simplest" isn't simple if users can't find it | ajtbd grounding checks |
| Magic params = anti-pattern | system-architect |
| Data shuttling = architecture smell | system-architect |
| LLM service copy-paste = abstraction needed | system-architect |
| Consistency > Novelty | ios-design-lead |
| AJTBD is a tool, not an oracle | ajtbd |
| Agents need persistent knowledge | codebase-analyzer |

## Contributing

These skills evolve through use. If you have learnings to contribute:

1. Fork the repo
2. Add your learning to the appropriate skill
3. Include the context (what happened, why it matters)
4. Submit a PR

## License

MIT — Use freely, contribute back if you can.

---

Built with [Claude Code](https://claude.ai/claude-code) for Claude Code.
