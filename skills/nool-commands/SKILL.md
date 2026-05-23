---
name: nool-commands
description: Nool Operational Continuity Infrastructure. Use Nool to capture engineering operational state, preserve continuity, and rehydrate agent context across every session, branch, and thread.
license: Proprietary. First 2000 knots or 30 days free, then see https://nool.dev/pricing
metadata:
  version: "2.2.4"
---

This skill provides a comprehensive reference for Nool. Use Nool to capture engineering operational state, preserve continuity, and rehydrate agent context across every session, branch, and thread.

## Core Workflow

### Initialize
- `nool init`: Initialize a new Nool ledger and generate an identity key.

### Propose Changes
- `nool propose`: Generate a candidate Knot (interactive wizard mode recommended for beginners). Supports --intent, --path, --thread.
- `nool propose --all`: Stage all modified/untracked files from Git worktree.
- `nool propose --try-branch <name>`: Propose changes in an ephemeral try branch.
- `nool propose --amend`: Amend the existing proposal.

### Solidify (Commit) & Promote
- `nool solidify`: Sign and append the candidate Knot to the DAG.
- `nool solidify --fast`: Fast mode with deferred validation (default).
- `nool solidify --full`: Full mode with full semantic guarantees.
- `nool solidify --local`: Save to Knot DAG only (no git commit).
- `nool promote <knot_id>`: Promote a Local knot to Staged/Synced status (runs validation and creates git commit).

### Semantic Planning & Verification
- `nool plan replay`: Compute a sequence of operations to reach a target semantic state (RFC-0001).
- `nool plan pluck`: Plan a selective undo (pluck) of specific operations.
- `nool plan merge`: Plan a merge of divergent semantic branches.
- `nool plan status`: Show current plan status and steps.
- `nool apply --plan-id <id>`: Execute an approved or draft semantic plan (RFC-0005).
- `nool verify`: Run structural invariants against current or planned state (RFC-0002).
- `nool explain <subject>`: Explain identities, dependencies, and reasons (RFC-0006).
- `nool review <target>`: Interactive review surface for candidate changes (RFC-0008).
- `nool evidence <plan|knot|merge|export>`: Transition Evidence. Prove why an AI-authored state transition was accepted or rejected.

### Sync & Replicate
- `nool push <remote>`: Push (replicate) all unpushed Knots to a remote replica.
- `nool pull <remote>`: Pull (fetch and replay) Knots from a remote replica.
- `nool sync <remote>`: Sync (bidirectional) with a remote replica (pull + push).

### Try Branches (Ephemeral Experimentation)
- `nool try new <name>`: Start a new ephemeral try branch.
- `nool try list`: List all active try branches.
- `nool try show <name>`: Show status of a try branch.
- `nool try promote <name>`: Promote a try branch to the main DAG.
- `nool try discard <name>`: Discard a try branch.

### Query & Analysis
- `nool query resolve-intent "<text>"`: Search for knots matching an intent query.
- `nool query neighbors <node_id>`: Show causal neighbors of a knot.
- `nool query recent-knots`: Show recent knots.
- `nool query blast-radius <node_ids>`: Compute blast radius (causal descendants).
- `nool query materialize <node_ids>`: Materialize content reconstruction for knots.
- `nool query search "<text>"`: Semantic search (NL intent → Knots).
- `nool query validate`: Validate files without proposing.
- `nool why <node_id>`: Walk causal chain.
- `nool log`: Show canonical replay log.
- `nool dag`: Visualise DAG.
- `nool diff <left> <right>`: Show file-content diff between two Knots.

### Usage & Analytics
- `nool usage usage`: Show token consumption for an agent or all agents.
- `nool usage budget-set`: Set a token budget limit for an agent.
- `nool usage budget-status`: Show token budget status.
- `nool usage analytics`: Show token analytics (cost per line, waste ratio, efficiency).
- `nool usage agent`: Agent bug rate, severity, patterns, and recommendations.
- `nool usage thread`: Thread-level cost analysis.
- `nool usage dashboard`: Combined tokens-per-bug metric across all threads.

### Status & Health
- `nool status`: Show system status.
- `nool doctor`: Release-readiness and repository health checks.
- `nool doctor --fix`: Automatically fix issues where possible.
- `nool validate`: Run background validation for all quarantined fast-mode Knots.

## Context & Knowledge

### Capture Learning
- `nool learn --about <topic> --kind <root_cause|finding> --content "<text>"`: Record a knowledge finding.
- `nool findings <query>`: Retrieve recorded findings for a file, thread, or topic.

### Discovery & Collaboration
- `nool discover conflicts`: Check for conflicting announcements before proposing changes.
- `nool discover context`: Retrieve context snapshot from previous work.
- `nool discover learnings`: Extract learnings and decisions from a thread.
- `nool discover similar`: Find similar work by topic or approach.

### Multi-Agent Coordination
- `nool announce intent`: Announce intent before starting work.
- `nool announce with-context`: Announce intent WITH context capture.
- `nool thread handoff`: Handoff thread responsibility to another agent.
- `nool thread show <name> --full`: Show AST-aware handoff context, internal dependency maps, and transitive closures.

## Threads, Tasks & Bugs

### Threads
- `nool thread create --name "<name>"`: Create a new intent thread.
- `nool thread list`: List all threads.
- `nool thread show <name>`: Show thread details.
- `nool thread status --name <name> --status <status>`: Set thread status.
- `nool thread chat <name>`: Add or view DAG-backed notes in a thread.

### Tasks
- `nool task create`: Create task.
- `nool task list-github` / `nool task import-github`: GitHub integration.
- `nool task list-jira` / `nool task import-jira`: Jira integration.
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

### Tags & Releases
- `nool tag <name>`: Semantic Tag.
- `nool release <version>`: Release Version.

### Merge & Compare
- `nool approve`: Approve a Knot or Intent Thread.
- `nool pluck <thread_name>`: Selective Undo (Thread Plucking).
- `nool compare <left> <right>`: Compare semantic changes between threads and/or releases.
- `nool changelog`: Semantic Changelog.

## Git Bridge
- `nool bridge status`: Show auto-sync configuration and recent push history.
- `nool bridge add-remote <url>`: Add a remote URL for auto-pushing.
- `nool bridge remove-remote <url>`: Remove an auto-push remote URL.
- `nool bridge watch`: Start the sync watch daemon.
- `nool bridge mirror-repair`: Repair or rebuild the Bifrost Git mirror.
- `nool bridge lfs init|track|status`: Manage git-lfs support.

## Administrative
- `nool ui`: Interactive TUI DAG explorer.
- `nool console`: Launch the interactive web console.
- `nool daemon start|stop|status`: Background synchronization daemon.
- `nool admin account`: Account settings (subscribe, billing).
- `nool admin team`: Team management (add, list).
- `nool admin plugin`: Plugin management (list, install, uninstall, init..
- `nool admin channel`: Release channel management (create, list).
- `nool admin gc`: Resource management (GC).
- `nool admin train-dict`: Train storage compression dictionary.
- `nool admin reconcile`: v3.0 Self-Healing: Process a batch of items from the repair queue.
- `nool inbox`: Unified notification centre.
- `nool audit`: Compliance report.

## Debug & Troubleshooting
- `nool debug replay`: Start interactive replay.
- `nool debug step`: Inspect a replay step.
- `nool debug diff`: Show diff of a replay step.
- `nool debug edit`: Add constraint to a replay step.
- `nool debug rerun`: Replay from a selected step.
- `nool debug blame`: Find root cause.
- `nool debug bisect`: Binary search for regression.
- `nool debug blast-radius`: Compute semantic blast radius and risk analysis.

## Other Commands
- `nool languages`: List all supported languages and their validation status.
- `nool insights`: Show generative project insights, blast radius stats, and time saved metrics.
- `nool link <knot_id>`: Retroactively link a solidified Knot to metadata.
- `nool quick-start`: Quick-start guide.
- `nool guide`: Detailed guide.
- `nool version`: Print version information.
- `nool upgrade`: Upgrade the CLI.
- `nool uninstall`: Uninstall the CLI.
- `nool completion`: Generate shell completion scripts.
