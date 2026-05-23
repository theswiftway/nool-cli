# Nool: Operational Continuity Infrastructure — Command Reference

**Version**: v3.2.0 — Installed CLI command surface synced from `nool version` and `nool help`

This document provides a comprehensive reference for all Nool commands organized by skill category. These commands enable **Deterministic Rehydration**, **Semantic Lineage**, and **Governed Autonomy** for autonomous engineering agents.

---

## Table of Contents

1. [Initialize](#initialize)
2. [Propose Changes](#propose-changes)
3. [Solidify (Commit) & Promote](#solidify-commit--promote)
4. [Semantic Planning & Verification](#semantic-planning--verification)
5. [Sync & Replicate](#sync--replicate)
6. [Try Branches (Ephemeral Experimentation)](#try-branches-ephemeral-experimentation)
7. [Query & Analysis](#query--analysis)
8. [Usage & Analytics](#usage--analytics)
9. [Status & Health](#status--health)
10. [Context & Knowledge](#context--knowledge)
11. [Threads, Tasks & Bugs](#threads-tasks--bugs)
12. [Tags & Releases](#tags--releases)
13. [Merge & Compare](#merge--compare)
14. [Git Bridge](#git-bridge)
15. [Administrative](#administrative)
16. [Session Rehydration](#session-rehydration)
17. [Debug & Troubleshooting](#debug--troubleshooting)
18. [Other Commands](#other-commands)

---

## Initialize

### `nool init`
Initialize an empty Nool repository and generate an identity key.

**Usage**:
```bash
nool init
nool init --from-git main
```

**When to use**: Set up a new project for Nool version control or bootstrap from existing Git history.

---

## Propose Changes

Create and manage semantic change proposals.

### `nool propose`
Generate a candidate Knot (interactive wizard mode recommended for beginners).

**Basic Usage**:
```bash
nool propose --intent "Add rate limiting to login" --path src/auth/login.rs --kind function
```

**With Thread**:
```bash
nool propose --intent "Add rate limiting" --path src/auth/login.rs --thread "Security Hardening"
```

**Parameters**:
- `--intent` / `-i`: Describe what you're changing
- `--path`: Path to the changed file(s)
- `--kind` / `-k`: Knot kind (fn, test, config, doc). Auto-detected if omitted
- `--thread` / `-t`: Associate with an intent thread
- `--try-branch`: Associate with an ephemeral try branch
- `--solidify` / `-s`: Automatically sign and append if validation passes
- `--amend`: Amend the existing proposal
- `--fast`: Fast mode (default): <5s local iteration, deferred validation
- `--full`: Full mode: full semantic guarantees (30-90s)
- `--interactive`: Interactive guided mode (recommended for beginners)
- `--bundle`: Include additional files for project-level reification
- `--project-root`: Override project root for bundled reification
- `--breaking`, `--issue`, `--test-note`, `--tag`, `--push`: Attach release and audit metadata

---

## Solidify (Commit) & Promote

Sign and finalize proposed changes.

### `nool solidify`
Sign and append the candidate Knot to the DAG.

**Usage**:
```bash
nool solidify
nool solidify --fast
nool solidify --full
nool solidify --local
```

**When to use**: 
- `--fast` for rapid local iteration with deferred validation.
- `--full` for full semantic validation (syntax check, integrity driver).
- `--local` for DAG-only local iteration without Git commit.

### `nool promote`
Promote a local Knot to staged/synced status.

**Usage**:
```bash
nool promote <knot_id>
```

**What it does**: Validates the Knot against the full integrity driver and creates the corresponding Git commit in the bridge.

---

## Semantic Planning & Verification

Advanced tools for algebraic DAG manipulation and formal verification of semantic state.

### `nool plan replay`
Compute a sequence of operations to reach a target semantic state (RFC-0001).

**Usage**:
```bash
nool plan replay --target <op_id> --save
```

### `nool plan pluck`
Plan a selective undo (pluck) of specific operations.

**Usage**:
```bash
nool plan pluck --targets <op_ids>
```

### `nool plan merge`
Plan a merge of divergent semantic branches (RFC-0001 §25).

**Usage**:
```bash
nool plan merge "Branch A" "Branch B"
```

### `nool plan status`
Show current plan status and steps.

### `nool apply`
Execute an approved or draft semantic plan (RFC-0005).

**Usage**:
```bash
nool apply --plan-id <id>
```

### `nool verify`
Run structural invariants against current or planned state (RFC-0002).

**Usage**:
```bash
nool verify --target <id>
```

### `nool explain`
Explain identities, dependencies, and reasons (RFC-0006).

**Usage**:
```bash
nool explain <knot_id>
```

### `nool review`
Interactive review surface for candidate changes (RFC-0008).

**Usage**:
```bash
nool review <plan_id|thread_name>
```

### `nool evidence`
Transition Evidence: Prove why an AI-authored state transition was accepted or rejected.

**Subcommands**:
- `plan`: Show evidence for a semantic plan.
- `knot`: Show evidence for a solidified Knot.
- `merge`: Show evidence for a merge operation.
- `export`: Export evidence object.

---

## Sync & Replicate

Synchronize Knots across replicas.

### `nool push`
Push (replicate) all unpushed Knots to a remote replica.

**Usage**:
```bash
nool push origin
```

### `nool pull`
Pull (fetch and replay) Knots from a remote replica.

**Usage**:
```bash
nool pull origin
```

### `nool sync`
Sync (bidirectional) with a remote replica (pull + push).

**Usage**:
```bash
nool sync origin
```

---

## Try Branches (Ephemeral Experimentation)

Create isolated, temporary branches for experimentation.

### `nool try new <name>`
Start a new ephemeral try branch.

### `nool try list`
List all active try branches.

### `nool try show <name>`
Show status of a try branch.

### `nool try promote <name>`
Promote a try branch to the main DAG.

### `nool try discard <name>`
Discard a try branch without DAG trace.

---

## Query & Analysis

Rich query capabilities for understanding the DAG.

### `nool query resolve-intent`
Search for knots matching an intent query.

### `nool query neighbors <node_id>`
Show causal neighbors of a Knot.

### `nool query recent-knots`
Show recent Knots, optionally filtered by thread.

### `nool query blast-radius <node_ids>`
Compute causal descendants for a Knot.

### `nool query materialize <node_ids>`
Reconstruct content from Knots.

### `nool query search "<text>"`
Semantic search over the DAG.

### `nool query validate`
Validate files without proposing.

### `nool why <node_id>`
Walk the causal chain of a Knot.

### `nool log`
Show canonical replay log.

### `nool dag`
Visualize the DAG.

### `nool diff <left> <right>`
Show file-content diff between two Knots.

---

## Usage & Analytics

Track token consumption, budgets, and agent performance.

### `nool usage usage`
Show token consumption for an agent or all agents.

### `nool usage budget-set`
Set a token budget limit for an agent.

### `nool usage budget-status`
Show token budget status for agents.

### `nool usage analytics`
Show token analytics: cost per line, waste ratio, efficiency.

### `nool usage agent`
Agent bug rate, severity, patterns, and recommendations.

### `nool usage thread`
Thread-level cost analysis (tokens spent, bugs, cost per Knot).

### `nool usage dashboard`
Dashboard — combined tokens-per-bug metric across all threads.

---

## Status & Health

Monitor repository state and health.

### `nool status`
Show system status, pending proposals, and thread state.

### `nool doctor`
Release-readiness and repository health checks.
Use `nool doctor --fix` to auto-repair semantic issues.

### `nool validate`
Run background validation for all quarantined fast-mode Knots.

---

## Context & Knowledge

Capture, query, and coordinate organizational learning.

### `nool learn`
Record a knowledge finding or reasoning note.

**Usage**:
```bash
nool learn --about "rate limit" --kind finding --content "Task spawning causes pressure"
```

### `nool findings`
Retrieve recorded findings for a file, thread, or topic.

### `nool discover conflicts`
Check for conflicting announcements before proposing changes.

### `nool discover context`
Retrieve context snapshot from previous work.

### `nool discover learnings`
Extract learnings and decisions from a thread.

### `nool discover similar`
Find similar work by topic or approach.

### `nool announce intent`
Announce intent before starting work (without context).

### `nool announce with-context`
Announce intent WITH context capture from a context file.

**Usage**:
```bash
nool announce with-context --intent "Refactor auth module" --context-file context.yaml
```

---

## Threads, Tasks & Bugs

Manage semantic units of work.

### Threads
- `nool thread create --name "<name>"`: Create a new intent thread.
- `nool thread list`: List all threads.
- `nool thread show <name> [--full]`: Show thread details. Use `--full` for AST-aware handoff context, internal dependency maps, and transitive closures.
- `nool thread status --name <name> --status <status>`: Set thread status.
- `nool thread chat <name>`: Add or view DAG-backed notes in a thread.
- `nool thread handoff`: Handoff thread responsibility to another agent.

### Tasks
- `nool task create`: Register a new task.
- `nool task list-github` / `import-github`: Import from GitHub.
- `nool task list-jira` / `import-jira`: Import from Jira.
- `nool task inbox`: Show pending tasks.
- `nool task pick`: Claim a task.
- `nool task assign`: Assign a task.
- `nool task mine`: Show my tasks.
- `nool task finish`: Mark a task as complete.
- `nool task block`: Block a task.

### Bugs
- `nool bug report`: Report a new bug.
- `nool bug link`: Link a Knot as the fix for a bug.
- `nool bug list`: List all bugs.
- `nool bug show`: Show details for a specific bug.
- `nool bug investigate`: Mark a bug as investigating.
- `nool bug wont-fix`: Mark a bug as wontfix.
- `nool bug duplicate`: Mark a bug as duplicate of another.

---

## Tags & Releases

Create semantic markers and releases.

### `nool tag <name>`
Create a semantic tag.

### `nool release <version>`
Create a release version.

---

## Merge & Compare

Manage merges and understand differences.

### `nool approve <knot_id>`
Approve a Knot or Intent Thread.

### `nool pluck <thread_name>`
Selective undo (thread plucking).

### `nool compare <left> <right>`
Compare semantic changes between threads/releases.

### `nool changelog`
Generate semantic changelog.

---

## Git Bridge

Integrate with Git for team collaboration.

### `nool bridge status`
Show auto-sync configuration and recent push history.

### `nool bridge add-remote <url>`
Add a remote URL for auto-pushing.

### `nool bridge remove-remote <url>`
Remove an auto-push remote URL.

### `nool bridge watch`
Start the sync watch daemon.

### `nool bridge mirror-repair`
Repair or rebuild the Bifrost Git mirror.

### `nool bridge lfs`
Initialize and manage git-lfs support (`init`, `track`, `status`).

---

## Administrative

Manage accounts, settings, and plugins.

### `nool ui`
Interactive TUI DAG explorer.

### `nool console`
Launch interactive web dashboard.

### `nool daemon`
Manage background synchronization (`start`, `stop`, `status`).

### `nool admin account`
Account settings (subscribe, billing).

### `nool admin team`
Team management: add members, assign roles.

### `nool admin plugin`
Plugin management: list, install, uninstall, init.

### `nool admin channel`
Release channel management.

### `nool admin gc`
Resource management (GC).

### `nool admin train-dict`
Train storage compression dictionary.

### `nool admin reconcile`
v3.0 Self-Healing: Process a batch of items from the repair queue.

### `nool inbox`
Unified notification centre.

### `nool audit`
Compliance and audit report.

---

## Session Rehydration

Recover context and continue work across agent sessions using Nool's semantic memory.

### Quick Rehydration (5 Minutes)
```bash
nool status
nool query recent-knots --limit 10
nool thread list
nool findings "your topic"
```

### Full Context Recovery (15 Minutes)
```bash
nool log --since "1 week ago"
nool discover context --snapshot-id <snapshot_id>
nool discover learnings --thread-id <thread_id>
nool discover similar "topic"
nool discover conflicts src/auth/*
nool pull origin
nool query search "specific work"
```

---

## Debug & Troubleshooting

Advanced debugging and root cause analysis.

### `nool debug replay`
Start interactive replay of a Git ref or agent run.

### `nool debug step` / `diff` / `edit` / `rerun`
Inspect, edit, and rerun replay steps.

### `nool debug blame`
Find root cause (show causal chain from a failure).

### `nool debug bisect`
Find which Knot introduced a regression (binary search).

### `nool debug blast-radius`
Compute semantic blast radius and risk analysis for a change.

---

## Other Commands

### `nool languages`
List all supported languages and their validation status.

### `nool insights`
Show generative project insights, blast radius stats, and time saved metrics.

### `nool link <knot_id>`
Retroactively link a solidified Knot to metadata.

### `nool completion <shell>`
Generate shell completion scripts (bash, zsh, fish, powershell).

### `nool quick-start`
Quick-start guide: 10 essential commands for beginners.

### `nool guide`
Detailed guide and examples for all commands.

### `nool version`
Print version information.

### `nool upgrade`
Upgrade the Nool CLI to the latest version.

### `nool uninstall`
Uninstall the Nool CLI and remove local identity keys.
