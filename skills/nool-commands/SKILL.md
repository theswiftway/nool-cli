name: nool-commands
version: 1.31.1
description: Documentation for Nool Commands

This skill provides a comprehensive reference for Nool Semantic-Agentic Version Control commands. Use Nool to track intent and reasoning behind code changes, ensuring deterministic convergence across all replicas.

## Core Workflow

### Initialize
- `nool init`: Initialize a new Nool ledger and generate an identity key.
- `nool init --from-git <branch>`: Bootstrap a Nool ledger from existing Git history.

### Propose Changes
- `nool propose --intent "<rationale>" --path <file> --kind <type>`: Create a semantic change proposal. Supports multi-file Synthesis knots (v1.31.1).
- `nool propose --fast`: Zero-friction mode. Auto-infers intent from git diff and recent context.
- `nool propose --try-branch <name>`: Propose changes in an ephemeral try branch.

### Solidify (Commit)
- `nool solidify --fast`: Rapid local iteration with deferred validation (recommended for active coding).
- `nool solidify --full`: Full semantic validation (syntax check, integrity driver). Use before pushing.

### Sync & Replicate
- `nool push <remote>`: Push solidified Knots to a remote.
- `nool pull <remote>`: Fetch and replay remote Knots.
- `nool sync <remote>`: Bidirectional synchronization.
- `nool bridge status`: Check auto-sync logs and Git mirror state.

### Try Branches (Ephemeral Experimentation)
- `nool try new <name>`: Start a new ephemeral try branch.
- `nool try list`: List all active try branches.
- `nool try show <name>`: Show status of a try branch.
- `nool try promote <name>`: Promote a try branch to the main DAG.
- `nool try discard <name>`: Discard a try branch.

### Query & Analysis
- `nool query resolve-intent "<text>"`: Find Knots related to a specific intent.
- `nool query neighbors <node_id>`: Show causal neighbors of a knot.
- `nool query recent-knots`: Show recent knots (optionally filtered by thread).
- `nool query blast-radius <node_ids>`: Compute causal descendants for knots.
- `nool query materialize <node_ids>`: Reconstruct content from knots.
- `nool query search "<text>"`: Semantic search over the DAG. Supports recursive search (v1.31.1).
- `nool why <node_id>`: Walk causal chain of a knot.
- `nool log`: Show canonical replay log.
- `nool dag`: Visualise the DAG.

### Status & Health
- `nool status`: View current DAG heads, pending proposals, and thread state.
- `nool doctor`: Release-readiness and repository health checks (causal-aware in v1.31.1).
- `nool doctor --fix`: Auto-repair semantic issues.
- `nool validate`: Run background validation for all quarantined fast-mode Knots.

## Context & Knowledge

### Capture Learning
- `nool learn --about <topic> --kind <root_cause|finding> --content "<text>"`: Record findings.
- `nool findings <query>`: Query captured knowledge to avoid re-discovering issues.

## Threads, Tasks & Bugs

### Threads
- `nool thread create "<name>"`: Create a new intent thread.
- `nool thread list`: List all threads.
- `nool thread show <name>`: Show thread details.
- `nool thread status <name>`: Set thread status (draft, active, review, released, archived).
- `nool thread chat <name>`: Chat in a thread.

### Tasks
- `nool task create --name "<task>"`: Register a new task.
- `nool task inbox`: Show pending tasks.
- `nool task pick <id>`: Claim a task.
- `nool task assign <id> --to <agent>`: Assign a task.
- `nool task mine`: Show my tasks.
- `nool task finish <id>`: Mark a task as complete. Triggers Jira sync if configured (v1.31.1).
- `nool task block <id> --reason <text>`: Block a task.

### Bugs
- `nool bug report --title "<title>" --severity <level> --reproduction "<steps>"`: Report a bug.
- `nool bug link <bug_id> --fix <knot_id>`: Link a fix.
- `nool bug list`: List bugs.
- `nool bug show <bug_id>`: Show bug details.
- `nool bug investigate <bug_id>`: Mark as investigating.
- `nool bug wont-fix <bug_id> --reason <text>`: Mark as wontfix.
- `nool bug duplicate <bug_id> --of <original_id>`: Mark as duplicate.

### Tags & Releases
- `nool tag <name>`: Create a semantic tag.
- `nool release <version>`: Create a release version.

### Merge & Compare
- `nool approve <knot_id>`: Approve a Knot.
- `nool pluck <thread_name>`: Selective undo (thread plucking).
- `nool compare <left> <right>`: Compare semantic changes between threads/releases.
- `nool changelog`: Generate semantic changelog.
- `nool diff <left> <right>`: Show file-content diff between two Knots.
- `nool merge <thread1> <thread2>`: Semantic 3-way merge of two divergent threads.

## Git Bridge
- `nool bridge status`: Check Git mirror state.
- `nool bridge add-remote <url>`: Add auto-push remote.
- `nool bridge remove-remote <url>`: Remove auto-push remote.
- `nool bridge watch`: Start sync watch daemon.
- `nool bridge lfs`: Initialize git-lfs support for large file tracking.
- `nool git <command>`: Raw git pass-through.

## Administrative
- `nool console`: Launch the interactive web dashboard (default: localhost:4001).
- `nool admin account`: Account settings (login, email, subscription).
- `nool admin team`: Team management: add members, assign roles.
- `nool admin channel`: Manage release channels.
- `nool admin plugin`: Manage plugins.
- `nool inbox`: Unified notification centre.
- `nool audit`: Compliance report.

## Other Commands
- `nool languages`: List supported languages.
- `nool link <knot_id>`: Link a solidified Knot to metadata.
- `nool quick-start`: Quick-start guide.
- `nool guide`: Detailed guide.
- `nool upgrade`: Upgrade CLI.
- `nool uninstall`: Uninstall CLI.
- `nool version`: Print version.

---

*Note: Nool prioritizes semantic truth over textual merges. Use `nool doctor --fix` if disk state diverges from DAG state.*
