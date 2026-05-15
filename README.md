# Nool User Guide: Semantic-Agentic Version Control

**Current Version**: v1.33.0 — Synthesis Multi-file Knots, Jira Integration, and Recursive Search.  
This guide documents the latest stable release. Feature sections note when they were introduced; all features listed below are available in v1.33.0 and later.

Nool is not just a replacement for Git — it is a shift from tracking lines of text to tracking semantic logic and intent. This guide covers what you can do with Nool, who it is for, and how it differs from traditional version control.

Everything runs on your local machine. Nothing gets uploaded to any server.  
**Note**: This is still beta. If you find any bugs, create issues on this repo.

## Quick Links

- [Skills.md](./Skills.md) - Comprehensive reference for all 50+ nool commands with examples and best practices
- [SKILL.md](./SKILL.md) - Agent-optimized skill file for Claude Code integration

## What's New in v1.33.0

### Invisible Bridge & Daemonized Sync
- **nool-daemon**: A new background process that provides zero-touch synchronization. Standard Git commands (`commit`, `checkout`, `merge`) are implicitly translated into Nool Knot DAG transformations.
- **Bidirectional Git Flow**: Full support for parallel causal timelines; Nool now natively understands and projects Git branch divergence.

### Interactive DAG Introspection
- **nool ui**: A robust, interactive TUI application for visual DAG exploration. Select any Knot to introspect its TOON metadata, reasoning, and semantic blast radius.
- **High-Fidelity Telemetry**: Visualize the "Cognitive State" of the repository as agents and humans collaborate.

### Autonomous Substrate Hardening
- **Self-Healing Ledger**: The storage layer now autonomously reconciles referential drift and database corruption using background triggers and a dedicated repair queue.
- **Metabolic GC**: Automated garbage collection of reification scratchpads resolves disk pressure (ENOSPC) risks in high-concurrency environments.

### Token-Optimized Coordination
- **TOON Metadata**: All manifests and handoffs now use Token-Oriented Object Notation, saving 30-50% in context window usage for agentic rehydration.
- **Adaptive Zstd**: Automatic dictionary training learns agent-generated mutation patterns for maximum storage density.

## What's New in v1.31.0

### Persona-Aware CLI
- **Role-Based Experience**: Added `--persona` flag (developer, user, agent). Commands and output are now filtered and optimized for your specific role. Agents get a high-density, code-synthesis-optimized interface.
- **Environment Variable**: Set `NOOL_PERSONA` to lock your preferred experience across sessions.

### Discovery & Collaboration Panels
- **nool discover**: New toolset for identifying conflicts, retrieving context, searching learnings, and finding similar work across the DAG.
- **nool announce**: Multi-agent coordination tool to announce intent and capture relevant context before starting work, reducing duplicate effort in multi-agent environments.
- **Web Console Tabs**: The nool console now includes dedicated tabs for Discovery, Collaboration, and Intent Announcement.

### Enhanced Diagnostics & Monitoring
- **Timeline Visualization**: `nool dag` and `nool log` now detect and highlight parallel branches and potential semantic divergence.
- **Replica Topology**: `nool status --topology` shows all known remotes, their sync health, and the overall mesh structure.
- **Usage & Token Tracking**: `nool usage` provides detailed analytics on token consumption, agent performance, and thread-level costs.

### Infrastructure & DX
- **Shell Completion**: Added `nool completion` for bash, zsh, fish, and powershell.
- **Fast Mode Hardening**: Improved background validation (`nool validate`) for quarantined Knots.
- **Reliability**: Replaced heuristic-based impact detection with exact DAG-based causal tracking for blast radius analysis.

## Steps to install

```bash
./install_tar.sh nool-release-1.31.1.tar.gz
```

### For Agent Integration

Copy the skill files to your agent directories:

```bash
# Claude Code
cp skills/nool-commands/SKILL.md ~/.claude/skills/nool-commands/SKILL.md

# Agent Framework
cp skills/nool-commands/SKILL.md ~/.agents/skills/nool-commands/SKILL.md
```

### For All Agents to Use

To enable all agents to reference the full Nool command documentation:

```bash
# Make Skills.md available to all agents
cp Skills.md ~/.claude/skills/nool-commands/Commands.md
cp Skills.md ~/.agents/skills/nool-commands/Commands.md
```

This ensures agents can reference:
- **SKILL.md** - Quick reference (agent-optimized, compact)
- **Commands.md** - Full documentation (detailed examples and workflows)

## Prompting Your Agent to Use Nool

The key to effective Nool usage is framing tasks so the agent understands what to track, when to validate, and how to reason about impact. Here are proven prompt patterns:

### System Prompt Addition

Add this to your agent's system prompt or `.claude.md`:

> You are a Nool-powered agent. Strictly use nool cli for all your VCS and task management.
>
> **Workflow:**
> 1. **Coordination**: Before starting, use `nool announce intent --intent "<what>"` to prevent collisions.
> 2. **Context**: Use `nool discover context` and `nool discover learnings` to rehydrate task context.
> 3. **Propose**: Use `nool propose --fast --intent "<why>"`.
> 4. **Verify**: Use `nool ui` to visualize causality and `nool status` to check health.
> 5. **Handoff**: Use `nool thread handoff --to <agent_id>` to transfer responsibility.
> 6. **Knowledge**: Use `nool learn` to record decisions and findings for future sessions.

#### Pre-requisite
1. Check if `.nool` folder exists. If not, use `nool init` to initialise the repo for nool.
2. If not synced already, use `nool import-git <branch>` to sync commits to nool.

#### Before changes
1. Run `nool status` to understand current state.
2. Use `nool discover context` to find related work and dependencies.
3. Use `nool announce --intent "Working on <feature>"` to coordinate with other agents.
4. Use `nool dag` to see the causal graph.

#### During changes
1. Propose multi-file changes: `nool propose --fast --intent "<rationale>" --path src/file1.rs src/file2.rs`
2. Iterate quickly: `nool solidify --fast`
3. Debug with causality: `nool why <knot_id>` and `nool debug blame`

#### After changes
1. Final validation: `nool solidify --full` before pushing.
2. Push work: `nool push origin`
3. Document learnings: `nool learn --kind decision --content "Used <pattern> because <reason>"`

### Task-Specific Prompts

#### Refactoring Task
"Refactor the authentication module in src/auth/. Before touching any file:
1. Run `nool announce --intent \"Refactoring auth module\"`
2. Run `nool discover context --path src/auth/` to see recent changes and active threads
3. Run `nool query blast-radius <node_id>` to understand dependencies
4. Propose changes using `nool propose --intent \"Simplify token validation\" --path src/auth/tokens.rs src/auth/utils.rs\"
5. Solidify only after reviewing what Nool's integrity driver reports"

#### Bug Fix Task
"Fix the memory leak in the connection pool:
1. Use `nool query search \"connection pool\"` to find related changes (recursive search enabled)
2. Create a thread: `nool thread create \"Fix Memory Leak Q2\"\"
3. Set active thread: `nool thread active \"Fix Memory Leak Q2\"\"
4. Propose the fix: `nool propose --intent \"Close connections in finally block\" --path db/pool.rs\"
5. Link to bug: `nool bug link <bug_id> --fix <knot_id>\"

#### Session Rehydration Prompt
"You are resuming work from a previous session. Recover context and continue:
1. Overview: `nool status` (30 sec)
2. Recent work: `nool query recent-knots --limit 10` (1 min)
3. Active context: `nool discover context` and `nool discover learnings` (2 min)
4. Knowledge check: `nool findings \"topic\"\" (1 min)
5. Visualise: `nool dag` (1 min)
After 5 minutes, you'll have full context and can resume work."

#### Multi-Agent Collaboration Prompt
"1. Check announcements: `nool discover context` to see what other agents are doing.
2. Announce work: `nool announce --intent \"Building UI components\"\" to prevent overlap.
3. Coordinate: `nool thread chat \"Thread Name\"\" to discuss architectural decisions.
4. Pull latest: `nool sync origin && nool pull` frequently."

#### Review & Rollback Prompt
"Review recent changes:
1. Run `nool log | head -20` to see what was done
2. For each knot: `nool why <id>` to understand causality
3. If issues found: `nool pluck \"Thread Name\"\" to preview without the problematic changes
Before merging to main:
1. `nool doctor` - check health (causal-aware diagnostics)
2. `nool validate` - validate fast-mode knots
3. `nool solidify --full` - full validation"

#### Emergency Response Prompt
"Something broke in production. Trace the issue:
1. `nool query search \"production bug\"\" - find related knots (recursive search)
2. `nool debug blame` - trace the causal chain to the root failure
3. `nool query blast-radius <problematic_knot_id>` - find what else was affected
4. `nool audit` - full compliance report for post-mortem"

## Tutorial

Click here to learn how to use it: [Nool Tutorial](https://www.nool.dev/docs)

## Who Is Nool For?

Nool is designed for everyone who touches software — not just engineers.

| Persona | What Nool gives you |
|---------|---------------------|
| **Developer** | Semantic mutations, stable NodeIDs across refactors, intent-linked history, offline-first CRDT sync |
| **Product Manager** | Intent Threads that tell the story of a feature; Changelog in plain language |
| **Designer / Writer** | Searchable history by meaning, not SHA; Approval Workflows on intent threads |
| **Legal / Compliance** | Signed audit trail: who changed what, when, and why — exportable as a report |
| **AI Agent** | MCP server for context rehydration; intent_ref links every mutation to its rationale |

## Core Concepts

### Knot — The Atomic Mutation
A Knot is the fundamental unit of change. It is not a diff of lines; it is a cryptographically signed semantic mutation of an AST node. Every Knot carries:
- A `KnotHeader` with its Blake3 self-hash, parent DAG edges, HLC timestamp, vector clock, and commutativity class.
- A `SemanticTransform` payload — a Mutation, Tag, Release, or Raw operation.
- An Ed25519 signature from the author.
- An optional `intent_ref` pointing to a record in the Intent Index.

### Intent Thread — The Logical Story
Knots are grouped into named Intent Threads — e.g. "Auth Refactor Q2" or "Fix Payment Edge Case". Threads are the product-facing unit of work. They drive the Changelog, enable Approval Workflows, and give non-developers a navigable view of history.

### Intent Index — The Why
The LanceDBIndex stores the human/agent rationale behind each Knot as a searchable record. The `nool search` command queries this index by text. Future versions support vector similarity search for semantic queries like "find all changes that touched authentication after the PCI audit."

### Knot DAG — The Source of Truth
Knots form a Directed Acyclic Graph. The canonical replay order is: Vector Clock → HLC Timestamp → Knot ID. Every replica sorts identically — this is the D-SSEC guarantee, formally verified in TLA+.

## Polyglot Support

Nool includes built-in language identification for over 30 languages and formats. This includes:
- **Programming Languages**: Rust, Python, JS/TS, Go, C++, Ruby, Erlang, Elixir, Clojure, and more.
- **Configuration & Markup**: JSON, TOML, YAML, XML, HTML, CSS, Markdown.

### Custom Language Support (Plugins)

If your language is not supported out of the box, you can add support via Language Plugins or Simple Configurations.

#### 1. Simple Configurations (nool.toml)
For languages that only require basic comment-stripping for stable NodeID calculation, you can define them directly in your `nool.toml` file:

```toml
[[languages]]
name = "my-simple-lang"
extensions = ["msl", "simple"]
comment_prefixes = ["//", "--"]
```

#### 2. Language Plugins (WASM)
For more complex languages requiring custom normalization or syntax validation, use the WASM-based plugin system.

## Speculative Reification: The "Verified Runnable" Guarantee

Unlike Git, which accepts any text as a commit, Nool performs Speculative Reification before a Knot can be solidified.

- **Shadow-Root Construction**: On `nool propose`, Nool creates a transient "Scratchpad Workspace" in `.nool/tmp/reify` using Git worktrees. This allows for lightning-fast (<200ms) materialization of your project's state without copying heavy dependencies.
- **The Integrity Driver**: Nool identifies the file extension and executes the appropriate language-native check (e.g., `cargo check`, `go vet`, `tsc --noEmit`).
- **Ghost-Run (Testing)**: If enabled, Nool doesn't just check for compilation; it runs the specific unit test suite associated with the mutated module within the scratchpad.
- **Cascade Reification**: If a mutation occurs in a shared definition file (like a .proto or schema), Nool triggers reification for all downstream dependent modules across different languages.

## Semantic Stability & Canonicalization

One of Nool's core strengths is its ability to ignore "noise"—changes that don't affect the logic or structure of the system.

### 1. Configuration Stability (JSON, TOML, YAML)
In traditional VCS, reordering keys in a configuration file results in a merge conflict or a noisy diff. Nool understands the semantics of these formats:
- **JSON & YAML**: Keys are recursively sorted before hashing.
- **TOML**: Structural reordering is canonicalized to ensure a stable identity.

### 2. Comment & Style Invariance
For programming languages, Nool's GenericLanguageAdapter performs smart normalization:
- **Comment Stripping**: Language-specific comments are stripped before calculating IDs.
- **Separator Normalization**: Stylistic separators are normalized.
- **Whitespace Invariance**: All remaining whitespace is stripped before the final hash.

## What You Can Do

### 1. Propose and Solidify Knots
Use `nool propose` to create a candidate mutation. Nool runs a dry-run through the Aram Gate (WASM sandbox) and performs Speculative Reification to ensure the code is valid.

```bash
nool propose \
  --intent "Add rate limiting to the login endpoint" \
  --path "src/auth/login.rs" \
  --kind function \
  --thread "Security Hardening"
```

### 2. Understand Repository State
```bash
nool status
```

### 3. Try Branches (Ephemeral Experimentation)
```bash
nool try new my_experiment
nool try promote my_experiment  # Merge back to main
```

### 4. Query the DAG
```bash
nool query resolve-intent "Add rate limiting"
nool query neighbors <node_id>
nool query blast-radius <node_id>
nool why <node_id>
nool dag
nool log
```

### 5. Threads, Tasks & Bugs
```bash
# Threads
nool thread create "Security Hardening"
nool thread status "Security Hardening" --active

# Tasks
nool task create --name "Fix login rate limit"
nool task pick <id>
nool task finish <id>

# Bugs
nool bug report --title "Login fails" --severity high
nool bug link <bug_id> --fix <knot_id>
```

### 6. Tags & Releases
```bash
nool tag v1.0.0
nool release 1.0.0
nool changelog
```

### 7. Git Bridge
```bash
nool bridge status
nool bridge watch
```

### 8. Context & Knowledge
```bash
nool learn --about "rate limit bug" --kind root_cause --content "..."
nool findings "rate limit"
```

### 9. Health, Validation & Maintenance
```bash
nool doctor
nool doctor --fix      # Auto-repair referential drift
nool validate
nool admin gc         # metabolic garbage collection
nool admin train-dict  # optimize compression
nool admin reconcile   # manual self-healing loop
nool ui               # Interactive DAG explorer
```

### 10. Daemonized Bridge
```bash
nool daemon start     # Start Invisible Bridge
nool daemon status
nool daemon stop
```
```

## Other Commands

- `nool languages` - List supported languages
- `nool quickstart` - Quick-start guide
- `nool guide` - Detailed guide
- `nool upgrade` - Upgrade CLI
- `nool version` - Print version
- `nool audit` - Compliance report
