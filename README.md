# Nool 

[![Version](https://img.shields.io/badge/version-2.2.4-blue.svg)](https://github.com/nool-dev/nool)
[![Status](https://img.shields.io/badge/status-beta-yellow.svg)](https://github.com/nool-dev/nool)

**Operational Continuity Infrastructure for Autonomous Engineering**

**Current Version**: v2.2.4 — Semantic Planning (RFC-0001), Algebraic DAG, and Structural Verification.  
This guide documents the latest stable release. Feature sections note when they were introduced; all features listed below are available in v2.2.4 and later.

Git stores your code state. **Nool stores your engineering operational state.** 

As coding agents become long-running autonomous systems, engineering teams require a persistent state layer to capture intent, preserve continuity, and rehydrate context across every session, branch, and thread. Nool provides that layer—tracking semantic mutations of logic rather than just text diffs.

Everything runs on your local machine. Nothing gets uploaded to any server.  
**Note**: This is still beta. If you find any bugs, create issues on this repo.

---

## 📑 Table of Contents
- [Quick Links](#-quick-links)
- [What's New](#-whats-new)
  - [v2.0.0](#whats-new-in-v200)
  - [v1.34.0](#whats-new-in-v1340)
  - [v1.33.0](#whats-new-in-v1330)
  - [v1.31.0](#whats-new-in-v1310)
- [Installation](#-installation)
- [Prompting Your Agent](#-prompting-your-agent-to-use-nool)
- [Who Is Nool For?](#-who-is-nool-for)
- [Core Concepts](#-core-concepts)
- [Polyglot Support](#-polyglot-support)
- [Speculative Reification](#-speculative-reification-the-verified-runnable-guarantee)
- [Semantic Stability & Canonicalization](#-semantic-stability--canonicalization)
- [Command Reference](#️-command-reference)

---

## 🔗 Quick Links

- [Skills.md](./Skills.md) - Comprehensive reference for the current Nool CLI command surface, with examples and best practices
- [SKILL.md](./skills/nool-commands/SKILL.md) - Agent-optimized skill file for Claude Code integration
- [GOVERNANCE.md](./docs/GOVERNANCE.md) - Deep dive into Nool's multi-layered enforcement model (WASM, Contracts, Reification)
- [Nool Tutorial](https://www.nool.dev/docs) - Learn how to use Nool

---

## 🚀 What's New

### What's New in v2.2.4

#### Enhanced Agent Handoff Context
- **`nool thread show --full`**: Major upgrade to handoff rehydration.
  - **Internal Dependency Map**: Visualize how touched files within a thread relate to each other.
  - **Transitive Dependency Closure**: Identify contextually related files *outside* the current thread using the improved `ImpactAnalyzer`.
  - **AST-Aware API Hints**: Robust, language-specific extraction of public APIs (functions, classes, etc.) from touched files.
  - **Dependency Signals**: Clearer visibility into imported modules and crates derived directly from the source AST.

#### Improved Impact Analysis Engine
- **Language-Specific Resolution**: `ImpactAnalyzer` now natively understands Rust crate structures (`nool_core::models` ➔ `crates/nool-core/src/models.rs`), group imports, and common file naming conventions across polyglot projects.

#### Binary Size & Performance
- **30% Reduction**: Implemented Stage 1 Size Optimizations (Fat LTO, stripped symbols, panic-abort). The binary size has been reduced from 166MB to ~115MB.
- **Multi-Platform Support**: Robust, automated release packaging for macOS, Linux, and Windows.

### What's New in v2.2.3

#### Expanded CLI Surfaces
- **`nool insights`**: Show generative project insights, blast radius stats, and time saved metrics.
- **`nool quick-start`**: Direct beginner-oriented guide surfaced from top-level help.
- **`nool guide`**: Detailed guide entry point exposed directly from the CLI.
- **Documentation sync**: The command reference now matches the current `nool help` and `nool version` output for v2.2.3.

### What's New in v2.2.2

#### Transition Evidence (AI Auditability)
- **`nool evidence`**: A new suite of commands to cryptographically prove why an AI-authored state transition was accepted or rejected.
  - `nool evidence plan`: Show evidence for a semantic plan.
  - `nool evidence knot`: Show evidence for a solidified Knot.
  - `nool evidence merge`: Show evidence for a merge operation.
  - `nool evidence export`: Export the evidence object for external auditing and compliance.

### What's New in v2.0.0

#### Semantic Planning Engine (RFC-0001)
- **`nool plan`**: A powerful new engine for computing semantic transitions. 
  - `nool plan replay`: Deterministically compute the sequence of operations needed to reach a target state.
  - `nool plan pluck`: Intelligently plan the removal of a specific thread or knot while preserving causal integrity.
  - `nool plan merge`: Algebraic 3-way merge planning for complex semantic branch divergence.
- **`nool apply`**: Execute approved or draft plans with built-in safety gates and staging roots.

#### Structural Verification & Explainability
- **`nool verify` (RFC-0002)**: Run deep structural invariants against the DAG or a proposed plan to ensure zero semantic drift.
- **`nool explain` (RFC-0006)**: Human-readable (and agent-readable) explanations for "why" a specific identity or dependency exists, or why a validation failed.
- **`nool review` (RFC-0008)**: Interactive terminal surface for reviewing complex plans and multi-file transitions before they are solidified.

#### Infrastructure Hardening
- **Algebraic DAG Core**: The entire replay engine has been refactored to treat the DAG as an algebraic structure, enabling formal verification of transitions.
- **`nool promote`**: A first-class command for moving local experiments to the staged/synced state, with automated Git integration.

### What's New in v1.34.0

#### Synthesis Multi-File Knots
- Atomic multi-file proposals allow agents to commit logical changes that span multiple files in a single, inseparable semantic unit.

#### Jira Platform Integration
- Automatic bidirectional synchronization with Jira. Nool tasks now discover and trigger the correct Jira transitions based on your project's workflow.

#### Recursive Semantic Search
- `nool query search` has been enhanced with recursive traversal of the semantic graph, finding relevant context even when keywords don't match exactly.

### What's New in v1.33.0

#### Invisible Bridge & Daemonized Sync
- **`nool-daemon`**: A new background process that provides zero-touch synchronization. Standard Git commands (`commit`, `checkout`, `merge`) are implicitly translated into Nool Knot DAG transformations.
- **Bidirectional Git Flow**: Full support for parallel causal timelines; Nool now natively understands and projects Git branch divergence.

#### Interactive DAG Introspection
- **`nool ui`**: A robust, interactive TUI application for visual DAG exploration. Select any Knot to introspect its TOON metadata, reasoning, and semantic blast radius.
- **High-Fidelity Telemetry**: Visualize the "Cognitive State" of the repository as agents and humans collaborate.

#### Autonomous Substrate Hardening
- **Self-Healing Ledger**: The storage layer now autonomously reconciles referential drift and database corruption using background triggers and a dedicated repair queue.
- **Metabolic GC**: Automated garbage collection of reification scratchpads resolves disk pressure (ENOSPC) risks in high-concurrency environments.

#### Token-Optimized Coordination
- **TOON Metadata**: All manifests and handoffs now use Token-Oriented Object Notation, saving 30-50% in context window usage for agentic rehydration.
- **Adaptive Zstd**: Automatic dictionary training learns agent-generated mutation patterns for maximum storage density.

### What's New in v1.31.0

#### Persona-Aware CLI
- **Role-Based Experience**: Added `--persona` flag (developer, user, agent). Commands and output are now filtered and optimized for your specific role. Agents get a high-density, code-synthesis-optimized interface.
- **Environment Variable**: Set `NOOL_PERSONA` to lock your preferred experience across sessions.

#### Discovery & Collaboration Panels
- **`nool discover`**: New toolset for identifying conflicts, retrieving context, searching learnings, and finding similar work across the DAG.
- **`nool announce`**: Multi-agent coordination tool to announce intent and capture relevant context before starting work, reducing duplicate effort in multi-agent environments.
- **Web Console Tabs**: The nool console now includes dedicated tabs for Discovery, Collaboration, and Intent Announcement.

#### Enhanced Diagnostics & Monitoring
- **Timeline Visualization**: `nool dag` and `nool log` now detect and highlight parallel branches and potential semantic divergence.
- **Replica Topology**: `nool status --topology` shows all known remotes, their sync health, and the overall mesh structure.
- **Usage & Token Tracking**: `nool usage` provides detailed analytics on token consumption, agent performance, and thread-level costs.

#### Infrastructure & DX
- **Shell Completion**: Added `nool completion` for bash, zsh, fish, and powershell.
- **Fast Mode Hardening**: Improved background validation (`nool validate`) for quarantined Knots.
- **Reliability**: Replaced heuristic-based impact detection with exact DAG-based causal tracking for blast radius analysis.

---

## 🛠 Installation

```bash
./install_tar.sh nool-release-2.2.4.tar.gz
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
- **`SKILL.md`** - Quick reference (agent-optimized, compact)
- **`Commands.md`** - Full documentation (detailed examples and workflows)

---

## 🤖 Prompting Your Agent to Use Nool

The key to effective Nool usage is framing tasks so the agent understands what to track, when to validate, and how to reason about impact. Here are proven prompt patterns:

### System Prompt Addition

Add this to your agent's system prompt or `.claude.md`:

> You are a Nool-powered agent. Strictly use nool cli for all your VCS and task management.
>
> **Workflow:**
> 1. **Coordination**: Before starting, use `nool announce intent --intent "<what>"` to prevent collisions.
> 2. **Context**: Use `nool discover context` and `nool discover learnings` to rehydrate task context.
> 3. **Impact**: Use `nool query blast-radius <node_id>` to assess the semantic risk of touching existing code.
> 4. **Debugging**: If fixing a bug, use `nool debug blame` or `nool debug bisect` to find the root cause.
> 5. **Propose**: Use `nool propose --all --intent "<why>"`.
> 6. **Verify**: Use `nool verify` to run structural invariants and `nool status` to check health.
> 7. **Handoff**: Use `nool thread show <name> --full` to provide decisive context to the next worker.
> 8. **Knowledge**: Use `nool learn` to record decisions and findings for future sessions.
> 9. **Execution**: For complex changes, use `nool plan replay` and `nool apply`.
> 10. **Health**: Always run `nool doctor` before pushing to ensure repository integrity.

### Workflow Checklists

#### Pre-requisite
1. Check if `.nool` folder exists. If not, use `nool init` to initialise the repo for nool.
2. If not synced already, use `nool promote <knot_id>` to formally stage your knots.

#### Before changes
1. Run `nool status` to understand current state.
2. Use `nool discover context` to find related work and dependencies.
3. Use `nool query blast-radius <knot_id>` to identify downstream files and logic that will be affected.
4. Use `nool explain <knot_id>` and `nool why <knot_id>` to understand complex causal chains and rationale.
5. For regressions, use `nool debug bisect --good <id> --broken <id>` to isolate the failure.
6. Use `nool announce --intent "Working on <feature>"` to coordinate with other agents.

#### During changes
1. Propose multi-file changes: `nool propose --all --intent "<rationale>" --path src/file1.rs src/file2.rs`
2. Iterate quickly: `nool solidify --fast`
3. Debug deep failures: `nool debug replay` to step through execution state.
4. Plan complex undos: `nool plan pluck <thread_name>`

#### After changes
1. Structural check: `nool verify` to ensure semantic integrity.
2. Health check: Run `nool doctor` to catch referential drift or orphan knots.
3. Blast radius verification: `nool query blast-radius <new_knot_id>` to confirm the change only affected intended nodes.
4. Final validation: `nool promote <knot_id>` before pushing.
5. Push work: `nool push origin`
6. Document learnings: `nool learn --kind decision --content "Used <pattern> because <reason>"`

### Task-Specific Prompts

<details>
<summary><strong>Refactoring Task</strong></summary>

"Refactor the authentication module in `src/auth/`. Before touching any file:
1. Run `nool announce --intent "Refactoring auth module"`
2. Run `nool explain src/auth/` and `nool why <recent_knot_id>` to understand existing architectural reasons and causal history.
3. Run `nool query blast-radius <node_id>` on the target modules to identify all downstream consumers and potential breakage points.
4. Run `nool discover context --path src/auth/` to see recent changes and active threads.
5. Propose changes using `nool propose --intent "Simplify token validation" --path src/auth/tokens.rs src/auth/utils.rs`
6. Run `nool verify` and `nool doctor` to ensure structural invariants and repo health are maintained."
</details>

<details>
<summary><strong>Bug Fix Task</strong></summary>

"Fix the memory leak in the connection pool:
1. Use `nool query search "connection pool"` to find related changes (recursive search enabled).
2. Trace the root cause: `nool debug blame <failure_point>` to see the causal chain from the failure.
3. If it's a regression: `nool debug bisect --good <id> --broken <id> --test "cargo test"` to find the exact knot.
4. Assess the impact of the fix: `nool query blast-radius <problematic_knot_id>` to see what else relies on the faulty logic.
5. Create a thread: `nool thread create "Fix Memory Leak Q2"`
6. Propose the fix: `nool propose --intent "Close connections in finally block" --path db/pool.rs`
7. Link to bug: `nool bug link <bug_id> --fix <knot_id>`"
</details>

<details>
<summary><strong>Session Rehydration Prompt</strong></summary>

"You are resuming work from a previous session. Recover context and continue:
1. Overview: `nool status`
2. Recent work: `nool query recent-knots --limit 10`
3. **Deep Rehydration**: `nool thread show <active_thread> --full` to see AST-aware API hints, internal dependency maps, and the transitive closure of related files.
4. Explanation check: `nool explain <recent_knot_id>` and `nool why <recent_knot_id>` for deep context and causal history.
5. Risk assessment: `nool query blast-radius <last_solidified_knot>` to see the current reach of your previous work.
6. Visualise: `nool ui`
After following these steps, you'll have full context and can resume work."
</details>

<details>
<summary><strong>Multi-Agent Collaboration Prompt</strong></summary>

"1. Check announcements: `nool discover context` to see what other agents are doing.
2. Announce work: `nool announce --intent "Building UI components"` to prevent overlap.
3. **Structural Analysis**: For concurrent threads, use `nool thread show <other_thread> --full` to inspect their **Internal Dependency Map**. If their work touches your transitive closure, coordinate immediately.
4. Check for structural conflicts: `nool verify --target <current_plan>`.
5. Monitor health: `nool doctor` regularly to ensure no sync-induced drift.
6. Pull latest: `nool sync origin && nool pull` frequently."
</details>

<details>
<summary><strong>Review & Rollback Prompt</strong></summary>

"Review recent changes:
1. Run `nool review <thread_name>` for an interactive review of the logic.
2. **Dependency Audit**: Run `nool thread show <name> --full`. Verify the **Internal Dependency Map** matches the intended architecture and that the **Transitive Closure** doesn't include unexpected modules.
3. For each knot: `nool explain <id>` and `nool why <id>` to understand the "why" and causal chain.
4. Check semantic impact: `nool query blast-radius <knot_id>` to verify the blast radius matches the intended scope.
5. If issues found: `nool plan pluck "Thread Name"` to generate an undo sequence.

Before merging to main:
1. `nool verify` - check structural invariants.
2. `nool doctor` - comprehensive health check.
3. `nool promote <knot_id>` - full validation and git staging.
4. `nool apply --plan-id <plan_id>` - execute the final merge plan."
</details>

<details>
<summary><strong>Emergency Response Prompt</strong></summary>

"Something broke in production. Trace the issue:
1. `nool query search "production bug"` - find related knots (recursive search).
2. `nool debug blame <failure_id>` - trace the causal chain to the root failure.
3. `nool debug replay` - step through the execution state to reproduce the failure.
4. `nool query blast-radius <problematic_knot_id>` - find what else was affected.
5. `nool audit` - full compliance report for post-mortem."
</details>

---

## 👥 Who Is Nool For?

Nool is designed for everyone who touches software — not just engineers.

| Persona | What Nool gives you |
|---------|---------------------|
| **Developer** | Semantic mutations, stable NodeIDs across refactors, intent-linked history, offline-first CRDT sync |
| **Product Manager** | Intent Threads that tell the story of a feature; Changelog in plain language |
| **Designer / Writer** | Searchable history by meaning, not SHA; Approval Workflows on intent threads |
| **Legal / Compliance** | Signed audit trail: who changed what, when, and why — exportable as a report |
| **AI Agent** | MCP server for context rehydration; `intent_ref` links every mutation to its rationale |

---

## 🧠 Core Concepts

### Knot — The Atomic Mutation
A Knot is the fundamental unit of change. It is not a diff of lines; it is a cryptographically signed semantic mutation of an AST node. Every Knot carries:
- A `KnotHeader` with its Blake3 self-hash, parent DAG edges, HLC timestamp, vector clock, and commutativity class.
- A `SemanticTransform` payload — a Mutation, Tag, Release, or Raw operation.
- An Ed25519 signature from the author.
- An optional `intent_ref` pointing to a record in the Intent Index.

### Intent Thread — The Logical Story
Knots are grouped into named Intent Threads — e.g. "Auth Refactor Q2" or "Fix Payment Edge Case". Threads are the product-facing unit of work. They drive the Changelog, enable Approval Workflows, and give non-developers a navigable view of history.

### Intent Index — The Why
The `LanceDBIndex` stores the human/agent rationale behind each Knot as a searchable record. The `nool search` command queries this index by text. Future versions support vector similarity search for semantic queries like *"find all changes that touched authentication after the PCI audit."*

### Knot DAG — The Source of Truth
Knots form a Directed Acyclic Graph. The canonical replay order is: Vector Clock → HLC Timestamp → Knot ID. Every replica sorts identically — this is the D-SSEC guarantee, formally verified in TLA+.

---

## 🌍 Polyglot Support

Nool includes built-in language identification for over 30 languages and formats. This includes:
- **Programming Languages**: Rust, Python, JS/TS, Go, C++, Ruby, Erlang, Elixir, Clojure, and more.
- **Configuration & Markup**: JSON, TOML, YAML, XML, HTML, CSS, Markdown.

### Custom Language Support (Plugins)

If your language is not supported out of the box, you can add support via Language Plugins or Simple Configurations.

#### 1. Simple Configurations (`nool.toml`)
For languages that only require basic comment-stripping for stable NodeID calculation, you can define them directly in your `nool.toml` file:

```toml
[[languages]]
name = "my-simple-lang"
extensions = ["msl", "simple"]
comment_prefixes = ["//", "--"]
```

#### 2. Language Plugins (WASM)
For more complex languages requiring custom normalization or syntax validation, use the WASM-based plugin system.

---

## 🛡 Speculative Reification: The "Verified Runnable" Guarantee

Unlike Git, which accepts any text as a commit, Nool performs **Speculative Reification** before a Knot can be solidified.

- **Shadow-Root Construction**: On `nool propose`, Nool creates a transient "Scratchpad Workspace" in `.nool/tmp/reify` using Git worktrees. This allows for lightning-fast (<200ms) materialization of your project's state without copying heavy dependencies.
- **The Integrity Driver**: Nool identifies the file extension and executes the appropriate language-native check (e.g., `cargo check`, `go vet`, `tsc --noEmit`).
- **Ghost-Run (Testing)**: If enabled, Nool doesn't just check for compilation; it runs the specific unit test suite associated with the mutated module within the scratchpad.
- **Cascade Reification**: If a mutation occurs in a shared definition file (like a `.proto` or schema), Nool triggers reification for all downstream dependent modules across different languages.

---

## 🧩 Semantic Stability & Canonicalization

One of Nool's core strengths is its ability to ignore "noise"—changes that don't affect the logic or structure of the system.

### 1. Configuration Stability (JSON, TOML, YAML)
In traditional VCS, reordering keys in a configuration file results in a merge conflict or a noisy diff. Nool understands the semantics of these formats:
- **JSON & YAML**: Keys are recursively sorted before hashing.
- **TOML**: Structural reordering is canonicalized to ensure a stable identity.

### 2. Comment & Style Invariance
For programming languages, Nool's `GenericLanguageAdapter` performs smart normalization:
- **Comment Stripping**: Language-specific comments are stripped before calculating IDs.
- **Separator Normalization**: Stylistic separators are normalized.
- **Whitespace Invariance**: All remaining whitespace is stripped before the final hash.

---

## ⌨️ Command Reference

Here's a quick overview of what you can do. For detailed instructions, refer to [`Skills.md`](./Skills.md).

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
nool thread show "Security Hardening" [--full]  # Use --full for AST-aware handoff context

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
nool admin plugin list             # List policies and plugins
nool admin plugin install <path>   # Install WASM plugin/policy
nool admin plugin uninstall <name> # Uninstall plugin/policy
nool admin gc          # metabolic garbage collection
nool admin train-dict  # optimize compression
nool admin reconcile   # manual self-healing loop
nool ui                # Interactive DAG explorer
```

### 10. Daemonized Bridge
```bash
nool daemon start      # Start Invisible Bridge
nool daemon status
nool daemon stop
```

### Other Commands
```bash
nool languages    # List supported languages
nool insights     # ROI, blast radius, and time-saved metrics
nool completion zsh
nool quick-start  # Quick-start guide
nool guide        # Detailed guide
nool upgrade      # Upgrade CLI
nool version      # Print version
nool uninstall    # Remove CLI and local identity keys
nool audit        # Compliance report
```

## License

The first 2000 knots or 30 days are free to try. No credit card required. After that, an explicit license is required from https://nool.dev/pricing
