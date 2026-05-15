# Nool Skills & Commands Reference

**Version**: 1.31.1 — Synthesis Multi-file Knots, Jira Integration, and Recursive Search

This document provides a comprehensive reference for all Nool commands organized by skill category. Each command is documented with its purpose, syntax, and common use cases.

---

## Table of Contents

1. [Initialize](#initialize)
2. [Propose Changes](#propose-changes)
3. [Solidify (Commit)](#solidify-commit)
4. [Sync & Replicate](#sync--replicate)
5. [Try Branches](#try-branches-ephemeral-experimentation)
6. [Query & Analysis](#query--analysis)
7. [Status & Health](#status--health)
8. [Context & Knowledge](#context--knowledge)
9. [Threads, Tasks & Bugs](#threads-tasks--bugs)
10. [Tags & Releases](#tags--releases)
11. [Merge & Compare](#merge--compare)
12. [Git Bridge](#git-bridge)
13. [Administrative](#administrative)
14. [Session Rehydration](#session-rehydration)
15. [Debug & Troubleshooting](#debug--troubleshooting)
16. [Discovery & Collaboration](#discovery--collaboration)
17. [Multi-Agent Coordination](#multi-agent-coordination)
18. [Knowledge & Learning](#knowledge--learning)
19. [Other Commands](#other-commands)

---

## Discovery & Collaboration

Tools for exploring the DAG, finding context, and resolving conflicts.

### `nool discover conflicts`
Detect potential semantic conflicts between branches or threads.

**Usage**:
```bash
nool discover conflicts
```

**When to use**: Before merging or solidifying high-risk changes.

### `nool discover context`
Retrieve relevant knots, files, and threads for the current task.

**Usage**:
```bash
nool discover context --path <file>
```

**When to use**: When starting a new task to see what else has touched this area.

---

## Multi-Agent Coordination

Coordinate work in multi-agent environments.

### `nool announce`
Announce your intent to work on a specific area or thread.

**Usage**:
```bash
nool announce --intent "Refactoring auth" --thread "Security"
```

**When to use**: Before starting work to prevent duplicate effort from other agents.

---




## Knowledge & Learning

Capture and retrieve reasoning and findings.

### `nool learn`
Record a knowledge finding or reasoning note.

**Usage**:
```bash
nool learn --kind reasoning_note --content "..."
```

**When to use**: To document "why" a decision was made for future reference.

### `nool findings`
Retrieve recorded findings for a file, thread, or topic.

**Usage**:
```bash
nool findings --file src/main.rs
```

---

## Other Commands

Initialize and bootstrap Nool repositories.

### `nool init`
Initialize an empty Nool repository.

**Usage**:
```bash
nool init
```

**When to use**: Set up a new project for Nool version control.

### `nool init --from-git <branch>`
Bootstrap a Nool ledger from existing Git history.

**Usage**:
```bash
nool init --from-git main
```

**When to use**: Migrate an existing Git repository to Nool, preserving commit history.

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
- `--bundle`: Bundle additional files for project-level reification
- `--fast`: Fast mode (default): <5s local iteration, deferred validation
- `--full`: Full mode: full semantic guarantees (30-90s)
- `--interactive`: Interactive guided mode (recommended for beginners)

**When to use**: Structured proposals that require clear traceability.

### `nool propose --interactive`
Interactive guided mode for proposing changes.

**Usage**:
```bash
nool propose --interactive
```

**When to use**: First time users or when you want step-by-step guidance.

### `nool propose --try-branch <name>`
Propose changes in an ephemeral try branch.

**Usage**:
```bash
nool propose --try-branch my_experiment --intent "Test new auth flow"
```

**When to use**: Experiment with changes without affecting the main DAG.

---

## Solidify (Commit)

Sign and finalize proposed changes.

### `nool solidify --fast`
Rapid local iteration with deferred validation.

**Usage**:
```bash
nool solidify --fast
```

**When to use**: Active coding with frequent iterations. Validation runs in background.

**Recommendation**: Use during development, not before pushing.

### `nool solidify --full`
Full semantic validation (syntax check, integrity driver).

**Usage**:
```bash
nool solidify --full
```

**When to use**: Before pushing to remote or merging to main branch.

**What it does**:
- Runs language-specific syntax checks (cargo check, go vet, tsc --noEmit)
- Validates all downstream dependencies
- Generates Validation Attestation with compiler version

### `nool solidify --local`
DAG-only local iteration without Git commit.

**Usage**:
```bash
nool solidify --local
```

**When to use**: Offline work or when delaying Git integration.

### `nool solidify` with `--solidify` flag
Sign and finalize proposed changes.

**Usage** (auto-solidify on propose):
```bash
nool propose --intent "Fix bug" --path src/bug.rs --solidify
```

**When to use**: Automatically commit after proposal validation passes.

---

## Sync & Replicate

Synchronize Knots across replicas.

### `nool push <remote>`
Push solidified Knots to a remote.

**Usage**:
```bash
nool push origin
```

**When to use**: Share completed work with collaborators.

### `nool pull <remote>`
Fetch and replay remote Knots.

**Usage**:
```bash
nool pull origin
```

**When to use**: Sync latest changes from collaborators.

### `nool sync <remote>`
Bidirectional synchronization.

**Usage**:
```bash
nool sync origin
```

**When to use**: Ensure local and remote are fully synchronized.

### `nool bridge status`
Check auto-sync logs and Git mirror state.

**Usage**:
```bash
nool bridge status
```

**When to use**: Verify synchronization health and identify conflicts.

---

## Try Branches (Ephemeral Experimentation)

Create isolated, temporary branches for experimentation.

### `nool try new <name>`
Start a new ephemeral try branch.

**Usage**:
```bash
nool try new experimental_refactor
```

**When to use**: Explore risky or speculative changes without polluting main DAG.

### `nool try list`
List all active try branches.

**Usage**:
```bash
nool try list
```

### `nool try show <name>`
Show status of a try branch.

**Usage**:
```bash
nool try show experimental_refactor
```

### `nool try promote <name>`
Promote a try branch to the main DAG.

**Usage**:
```bash
nool try promote experimental_refactor
```

**When to use**: Accept changes from a try branch as permanent.

### `nool try discard <name>`
Discard a try branch without DAG trace.

**Usage**:
```bash
nool try discard experimental_refactor
```

**When to use**: Abandon experimental changes cleanly.

---

## Query & Analysis

Rich query capabilities for understanding the DAG.

### `nool query resolve-intent "<text>"`
Find Knots related to a specific intent.

**Usage**:
```bash
nool query resolve-intent "Add rate limiting"
```

**Returns**: All Knots with matching intent semantics.

### `nool query neighbors <node_id>`
Show causal neighbors of a Knot.

**Usage**:
```bash
nool query neighbors b7d2c1f0
```

**Use case**: Understand what depends on or is depended by a Knot.

### `nool query recent-knots`
Show recent Knots, optionally filtered by thread.

**Usage**:
```bash
nool query recent-knots
nool query recent-knots --thread "Auth Refactor"
```

### `nool query blast-radius <node_ids>`
Compute causal descendants for a Knot.

**Usage**:
```bash
nool query blast-radius b7d2c1f0
```

**Use case**: Identify what changes were triggered by a specific Knot (risk analysis).

### `nool query materialize <node_ids>`
Reconstruct content from Knots.

**Usage**:
```bash
nool query materialize b7d2c1f0 a3f8c2b1
```

**Use case**: View what files/content existed at a specific point in the DAG.

### `nool query search "<text>"`
Semantic search over the DAG.

**Usage**:
```bash
nool query search "connection pool memory leak"
```

**Use case**: Find changes related to specific topics without knowing exact intent. Supports recursive search over the semantic code graph (introduced v1.33.0).

### `nool why <node_id>`
Walk the causal chain of a Knot.

**Usage**:
```bash
nool why b7d2c1f0
```

**Returns**: Full chain of why this Knot was created and what led to it.

### `nool log`
Show canonical replay log.

**Usage**:
```bash
nool log
nool log --since "2 weeks ago"
nool log --thread "Auth Refactor"
```

### `nool dag`
Visualize the DAG.

**Usage**:
```bash
nool dag
nool dag --thread "Auth Refactor"
```

**Output**: ASCII or visual representation of causal relationships.

---

## Status & Health

Monitor repository state and health.

### `nool status`
View current DAG heads, pending proposals, and thread state.

**Usage**:
```bash
nool status
```

**Shows**:
- Total Knots in repository
- Current DAG heads
- Active Intent Threads
- Pending proposals

### `nool doctor`
Release-readiness and repository health checks.

**Usage**:
```bash
nool doctor
```

**Checks**:
- DAG integrity
- Orphaned Knots
- Unsignified proposals
- Git mirror consistency

### `nool doctor --fix`
Auto-repair semantic issues.

**Usage**:
```bash
nool doctor --fix
```

**When to use**: Recover from disk/DAG divergence.

### `nool validate`
Run background validation for fast-mode Knots.

**Usage**:
```bash
nool validate
```

**When to use**: Before final push, validate all fast-mode Knots comprehensively.

---

## Context & Knowledge

Capture and query organizational learning.

### `nool learn --about <topic> --kind <type> --content "<text>"`
Record findings to avoid re-discovering issues.

**Usage**:
```bash
nool learn --about "rate limit bug" --kind root_cause --content "The bug was in the redis connection pool initialization"
nool learn --about "async patterns" --kind finding --content "Task spawning in hot loops causes memory pressure"
nool learn --about "auth module" --kind dependency_insight --content "Token validation depends on redis availability"
```

**Kinds**: `root_cause`, `finding`, `dependency_insight`, `reasoning_note`

### `nool findings <query>`
Query captured knowledge.

**Usage**:
```bash
nool findings "rate limit"
nool findings "redis connection"
```

**Returns**: All recorded learnings matching the query.

---

## Threads, Tasks & Bugs

Manage semantic units of work.

### Threads

#### `nool thread create "<name>"`
Create a new intent thread.

**Usage**:
```bash
nool thread create "Security Hardening Q2"
```

**When to use**: Organize related Knots under a named theme (feature, epic, refactor).

#### `nool thread list`
List all threads.

**Usage**:
```bash
nool thread list
```

#### `nool thread show <name>`
Show thread details.

**Usage**:
```bash
nool thread show "Security Hardening Q2"
```

**Shows**: Knots in thread, status, contributors, timeline.

#### `nool thread status <name> <status>`
Set thread status.

**Usage**:
```bash
nool thread status "Security Hardening Q2" active
```

**Statuses**: `draft`, `active`, `review`, `released`, `archived`

#### `nool thread chat <name>`
Chat in a thread.

**Usage**:
```bash
nool thread chat "Security Hardening Q2"
```

**Use case**: Async discussion about a feature thread.

### Tasks

#### `nool task create --name "<task>"`
Register a new task.

**Usage**:
```bash
nool task create --name "Add rate limiting to login endpoint"
```

#### `nool task inbox`
Show pending tasks.

**Usage**:
```bash
nool task inbox
```

#### `nool task pick <id>`
Claim a task.

**Usage**:
```bash
nool task pick task-123
```

#### `nool task assign <id> --to <agent>`
Assign a task to an agent or person.

**Usage**:
```bash
nool task assign task-123 --to alice
```

#### `nool task mine`
Show my tasks.

**Usage**:
```bash
nool task mine
```

#### `nool task finish <id>`
Mark a task as complete.

**Usage**:
```bash
nool task finish task-123
```

**What it does**:
- Marks the task as completed in the local ledger.
- If Jira integration is configured (`JIRA_BASE_URL`, `JIRA_API_TOKEN`), automatically discovers and triggers the appropriate Jira workflow transition (e.g., "Done").

#### `nool task block <id> --reason <text>`
Block a task with explanation.

**Usage**:
```bash
nool task block task-123 --reason "Waiting for API schema from backend team"
```

### Bugs

#### `nool bug report --title "<title>" --severity <level> --reproduction "<steps>"`
Report a bug.

**Usage**:
```bash
nool bug report --title "Login fails with 2FA" --severity high --reproduction "1. Enable 2FA. 2. Log in. 3. Enter code. See error."
```

**Severity levels**: `critical`, `high`, `medium`, `low`

#### `nool bug link <bug_id> --fix <knot_id>`
Link a fix to a bug.

**Usage**:
```bash
nool bug link bug-456 --fix a3f8c2b1
```

#### `nool bug list`
List all bugs.

**Usage**:
```bash
nool bug list
nool bug list --status open
nool bug list --severity high
```

#### `nool bug show <bug_id>`
Show bug details.

**Usage**:
```bash
nool bug show bug-456
```

#### `nool bug investigate <bug_id>`
Mark as investigating.

**Usage**:
```bash
nool bug investigate bug-456
```

#### `nool bug wont-fix <bug_id> --reason <text>`
Mark as wontfix with explanation.

**Usage**:
```bash
nool bug wont-fix bug-456 --reason "By design for backward compatibility"
```

#### `nool bug duplicate <bug_id> --of <original_id>`
Mark as duplicate.

**Usage**:
```bash
nool bug duplicate bug-457 --of bug-456
```

---

## Tags & Releases

Create semantic markers and releases.

### `nool tag <name>`
Create a semantic tag.

**Usage**:
```bash
nool tag v1.0.0
nool tag release-candidate-2
```

**Use case**: Mark important points in DAG history.

### `nool release <version>`
Create a release version.

**Usage**:
```bash
nool release 1.0.0
```

**What it does**:
- Creates a Release Knot
- Embeds language rules
- Locks semantic validators
- Generates release manifest

---

## Merge & Compare

Manage merges and understand differences.

### `nool approve <knot_id>`
Approve a Knot.

**Usage**:
```bash
nool approve a3f8c2b1
```

**Use case**: Code review approval in workflows.

### `nool pluck <thread_name>`
Selective undo (thread plucking).

**Usage**:
```bash
nool pluck "Failed Feature Branch"
```

**What it does**: Preview DAG state without a specific thread's Knots.

### `nool compare <left> <right>`
Compare semantic changes between threads/releases.

**Usage**:
```bash
nool compare v1.0.0 v1.1.0
nool compare "Thread A" "Thread B"
```

**Shows**: Semantic diff between branches.

### `nool changelog`
Generate semantic changelog.

**Usage**:
```bash
nool changelog
nool changelog --since v1.0.0
nool changelog --thread "Payment Feature"
```

**Output**: Human-readable changelog grouped by intent threads.

---

## Git Bridge

Integrate with Git for team collaboration.

### `nool bridge status`
Show auto-sync configuration and recent push history.

**Usage**:
```bash
nool bridge status
```

**Shows**: Sync status, pending commits, auto-push state.

### `nool bridge add-remote <url>`
Add a remote URL for auto-pushing.

**Usage**:
```bash
nool bridge add-remote https://github.com/user/repo
```

### `nool bridge remove-remote <url>`
Remove an auto-push remote URL.

**Usage**:
```bash
nool bridge remove-remote https://github.com/user/repo
```

### `nool bridge watch`
Start the sync watch daemon.

**Usage**:
```bash
nool bridge watch
```

**What it does**: Continuously sync Knots with Git remote.

### `nool bridge mirror-repair`
Repair or rebuild the Bifrost Git mirror.

**Usage**:
```bash
nool bridge mirror-repair
```

**When to use**: If Git mirror becomes out of sync with Knot DAG.

### `nool bridge lfs`
Initialize git-lfs support for large file tracking.

**Usage**:
```bash
nool bridge lfs
```

**What it does**: Set up git-lfs for tracking large binary files.

---

## Administrative
### `nool ui`
Launch the interactive terminal DAG explorer. Navigate the causal graph visually and introspect TOON metadata.

**Usage**:
```bash
nool ui
```

### `nool daemon`
Manage the background synchronization daemon (Invisible Bridge).

**Usage**:
```bash
nool daemon start    # Start zero-touch background sync
nool daemon status   # Check daemon health
nool daemon stop     # Stop background process
```

### `nool thread handoff`
Formally transfer thread responsibility to another agent with high-density TOON metadata.

**Usage**:
```bash
nool thread handoff --name "Feature Thread" --to <agent_id> -d "Decision" -s "Next step" --solidify
```

### `nool admin reconcile`
Manually trigger the asynchronous self-healing reconciliation loop to repair DAG drift.

**Usage**:
```bash
nool admin reconcile --batch-size 100
```

### `nool admin gc`
Perform metabolic garbage collection of reification resources.

**Usage**:
```bash
nool admin gc --force
```

### `nool admin train-dict`
Train and activate a new Zstd compression dictionary based on recent mutation patterns.

**Usage**:
```bash
nool admin train-dict --sample-size 100
```


Manage accounts, settings, and plugins.

### `nool console`
Launch interactive web dashboard.

**Usage**:
```bash
nool console
```

**Starts**: Dashboard at localhost:4001

**Features**:
- DAG visualization
- Thread browser
- Real-time notifications
- Team collaboration view

### `nool admin account`
Account settings (login, email, subscription).

**Usage**:
```bash
nool admin account
```

### `nool admin team`
Team management: add members, assign roles.

**Usage**:
```bash
nool admin team
```

### `nool admin channel`
Release channel management.

**Usage**:
```bash
nool admin channel
```

### `nool admin plugin`
Plugin management: install, list, initialize.

**Usage**:
```bash
nool admin plugin
```

### `nool inbox`
Unified notification centre.

**Usage**:
```bash
nool inbox
nool inbox --clear
```

**Shows**: All notifications across Nool system.

### `nool msg`
Direct 1:1 message with team members.

**Usage**:
```bash
nool msg alice "Can you review the auth changes?"
```

**Use case**: Direct communication about work in progress.

### `nool audit`
Compliance and audit report.

**Usage**:
```bash
nool audit
nool audit --export json
```

**Generates**:
- Change log with signatures
- Author attribution
- Timestamp verification
- Compliance checks

---

## Session Rehydration

Recover context and continue work across agent sessions using Nool's semantic memory.

### Quick Rehydration (5 Minutes)

**Get back to speed quickly:**

```bash
# 1. Check status
nool status

# 2. See recent changes
nool query recent-knots --limit 10

# 3. Review your threads
nool thread list

# 4. Look up recordings
nool findings "your topic"
```

### Full Context Recovery (15 Minutes)

**Deep dive into previous work:**

```bash
# Review full history
nool log --since "1 week ago"

# Get thread context
nool discover context --thread "Feature Name"
nool discover learnings --thread "Feature Name"

# Find related work
nool discover similar "topic"

# Check for conflicts
nool discover conflicts

# Sync with team
nool pull origin

# Search by intent
nool query search "specific work"
```

### Recovering a Specific Change

**If you need to understand what you were working on:**

```bash
# Find it
nool query recent-knots

# Understand it
nool why <knot_id>

# See impact
nool query blast-radius <knot_id>

# View the code
nool query materialize <knot_id>
```

### Using Recorded Learnings

**Access the knowledge you captured:**

```bash
# Find learnings
nool findings "topic"

# Get structured data
nool findings "topic" --json

# See more results
nool findings "topic" --limit 20
```

### Rehydration Commands Reference

| Command | Purpose | Time |
|---------|---------|------|
| `nool status` | Overview | 10 sec |
| `nool query recent-knots` | Recent work | 30 sec |
| `nool log` | Full history | 1 min |
| `nool discover context --thread X` | Thread state | 2 min |
| `nool discover learnings --thread X` | Knowledge | 2 min |
| `nool findings "query"` | Recorded notes | 1 min |
| `nool why <id>` | Causality | 30 sec |
| `nool dag` | Architecture | 1 min |
| **TOTAL (Quick)** | **Ready to work** | **5 min** |
| **TOTAL (Full)** | **Deep understanding** | **15 min** |

### Full Rehydration Workflow

```bash
#!/bin/bash
# Complete session rehydration (15 minutes max)

echo "🔄 Rehydrating session..."

# Quick status (30 sec)
nool status

# Recent activity (1 min)
nool query recent-knots --limit 20

# Your work (1 min)
nool thread list
nool task mine

# Pull latest (1 min)
nool pull origin

# Get context for your thread (2 min)
THREAD_NAME="Your Thread Name"
nool discover context --thread "$THREAD_NAME"
nool discover learnings --thread "$THREAD_NAME"

# Knowledge from past work (2 min)
nool findings "topic you worked on" --limit 20

# Find similar patterns (1 min)
nool discover similar "feature type"

# Check for conflicts (30 sec)
nool discover conflicts

# Visual understanding (1 min)
nool dag

echo "✅ Rehydration complete! Ready to resume work."
```

### Best Practices for Easy Rehydration

**1. Write Descriptive Intents**
```bash
# Make your work findable and understandable
nool propose --intent "Add JWT token expiration validation (CVE-2024-xxxxx) using RS256 key rotation" --path src/auth/jwt.rs
```

**2. Organize with Threads**
```bash
# Group related work semantically
nool thread create "Payment Integration v3"
nool propose --thread "Payment Integration v3" --intent "Add webhook signature verification"
```

**3. Capture Learnings Regularly**
```bash
# Record discoveries for future reference
nool learn --about "JWT validation" --kind discovery --content "Token exp must be checked before signature to prevent DOS"

# Document decisions
nool learn --about "authentication" --kind reasoning_note --content "Chose JWT over session cookies for statelessness"

# Note dependencies
nool learn --about "redis" --kind dependency_insight --content "Session cache requires Redis—implement fallback"
```

**4. Use Rich Announcements**
```bash
# Share complex context with other agents
nool announce with-context "Refactoring auth system" \
  --decisions "OIDC for SSO, JWT for APIs" \
  --constraints "Cannot break OAuth2 clients"
```

### Example: Picking Up Work from a Previous Session

**Session 1 - Started Feature**
```bash
nool thread create "New Search API"
nool propose --intent "Add full-text search endpoint" --thread "New Search API" --fast
nool solidify --fast

nool learn --about "search API" --kind reasoning_note \
  --content "Using Elasticsearch for performance; MySQL FULLTEXT too slow"
```

**Session 2 - Pick It Up**
```bash
# Understand what was started
nool discover context --thread "New Search API"
nool discover learnings --thread "New Search API"

# See recent changes
nool query recent-knots --thread "New Search API"

# Continue from where you left off
nool propose --intent "Add pagination to search results" --thread "New Search API"

# Share new learning
nool learn --about "search API pagination" --kind discovery \
  --content "Cursor-based pagination more efficient than offset for large result sets"
```

---

## Debug & Troubleshooting

Advanced debugging and root cause analysis.

### `nool debug replay`
Start interactive replay of a Git ref or agent run.

**Usage**:
```bash
nool debug replay main
nool debug replay feature-branch
```

**Use case**: Step through history to understand how a state was reached.

### `nool debug step`
Inspect a specific replay step.

**Usage**:
```bash
nool debug step <step_id>
```

### `nool debug diff`
Show diff of a replay step.

**Usage**:
```bash
nool debug diff <step_id>
```

### `nool debug edit`
Add a constraint to a replay step.

**Usage**:
```bash
nool debug edit <step_id>
```

### `nool debug rerun`
Replay from a selected step.

**Usage**:
```bash
nool debug rerun <step_id>
```

**Use case**: Test "what if" scenarios by replaying from a different state.

### `nool debug blame`
Find root cause (show causal chain from a failure).

**Usage**:
```bash
nool debug blame <failure_point>
```

**Use case**: Trace back to the original cause of a bug.

### `nool debug bisect`
Find which Knot introduced a regression (binary search).

**Usage**:
```bash
nool debug bisect --broken <knot_id> --good <knot_id>
```

**Use case**: Efficiently locate which change caused a bug.

### `nool debug blast-radius`
Compute semantic blast radius and risk analysis for a change.

**Usage**:
```bash
nool debug blast-radius <knot_id>
```

---

## Discovery & Collaboration

Tools for discovering context and coordinating work.

### `nool discover conflicts`
Check for conflicting announcements before proposing changes.

**Usage**:
```bash
nool discover conflicts
```

**Use case**: Multi-agent coordination to prevent conflicting work.

### `nool discover context`
Retrieve context snapshot from previous work.

**Usage**:
```bash
nool discover context --thread "Auth Refactor"
```

**Returns**: Decisions, constraints, patterns from previous thread work.

### `nool discover learnings`
Extract learnings and decisions from a thread.

**Usage**:
```bash
nool discover learnings --thread "Payment Feature"
```

**Use case**: Understand what was learned during a feature development.

### `nool discover similar`
Find similar work by topic or approach.

**Usage**:
```bash
nool discover similar "rate limiting"
nool discover similar --thread "API Design"
```

**Use case**: Reuse patterns from previous work.

---

## Multi-Agent Coordination

Commands for coordinating work across multiple agents.

### `nool announce intent`
Announce intent before starting work (without context).

**Usage**:
```bash
nool announce intent "Implementing new search API"
```

**Use case**: Let other agents know you're starting work on something.

### `nool announce with-context`
Announce intent WITH context capture (decisions, constraints, patterns).

**Usage**:
```bash
nool announce with-context "Refactoring database layer" --decisions "Use eventual consistency" --constraints "Must support MySQL 5.7"
```

**Use case**: Full context sharing for dependent work.

---



## Other Commands

Miscellaneous utilities.

### `nool languages`
List supported languages.

**Usage**:
```bash
nool languages
nool languages --detail
```

**Includes**: 30+ programming languages and configuration formats.

### `nool link <knot_id>`
Link a Knot to metadata or external resources.

**Usage**:
```bash
nool link a3f8c2b1 --issue JIRA-123
nool link a3f8c2b1 --pr https://github.com/user/repo/pull/456
```

### `nool quick-start`
Quick-start guide: 10 essential commands for beginners.

**Usage**:
```bash
nool quick-start
```

**Output**: Interactive guide for getting started with 10 essential commands.

### `nool guide`
Detailed guide and examples for all commands.

**Usage**:
```bash
nool guide
```

**Output**: Comprehensive guide covering all Nool features and workflows.

### `nool upgrade`
Upgrade CLI to latest version.

**Usage**:
```bash
nool upgrade
```

### `nool uninstall`
Uninstall CLI.

**Usage**:
```bash
nool uninstall
```

### `nool version`
Print version information.

**Usage**:
```bash
nool version
```

**Output**:
```
Nool v1.33.0
Built: 2026-05-02
Git: https://github.com/...
```

### `nool completion`
Generate shell completion scripts.

**Usage**:
```bash
nool completion bash
nool completion zsh
nool completion fish
nool completion powershell
```

**What it does**: Generate shell-specific completion scripts for faster command typing.

---

## Workflow Examples

### Daily Development Workflow

```bash
# Start day
nool pull origin                    # Sync latest changes
nool status                         # Check overall state

# During development
nool propose --fast                 # Create proposals quickly
nool solidify --fast                # Fast iterations

# End of day
nool solidify --full                # Full validation
nool validate                       # Ensure all fast-mode Knots pass
nool push origin                    # Share with team
```

### Feature Development Workflow

```bash
# Create feature thread
nool thread create "New Payment Flow"

# Break work into semantic Knots
nool propose --intent "Add webhook signature verification" --thread "New Payment Flow"
nool propose --intent "Parse payment events" --thread "New Payment Flow"
nool propose --intent "Update database schema" --thread "New Payment Flow"

# Solidify with validation
nool solidify --full

# Generate changelog
nool changelog --thread "New Payment Flow"

# Sync
nool push origin
```

### Bug Fix Workflow

```bash
# Report and track bug
nool bug report --title "Payment processing fails" --severity high

# Create fix thread
nool thread create "Fix Payment Bug"

# Propose fix
nool propose --intent "Fix null pointer in processor" --thread "Fix Payment Bug"

# Link fix to bug
nool bug link bug-123 --fix a3f8c2b1

# Validate and push
nool solidify --full
nool push origin
```

### Code Review Workflow

```bash
# Review recent changes
nool log | head -10
nool query recent-knots

# Understand each change
nool why b7d2c1f0

# Check impact
nool query blast-radius b7d2c1f0

# Approve if good
nool approve b7d2c1f0
```

### Emergency Response Workflow

```bash
# Find the issue
nool query search "production error"

# Understand impact
nool query blast-radius <problematic_knot>

# Mark as investigating
nool bug investigate bug-999

# Check compliance
nool audit

# Generate report
nool changelog --since "1 day ago"
```

---

## Tips & Best Practices

1. **Use Intent Threads**: Always create threads for feature work. This provides product visibility and better changelog narratives.

2. **Propose with Intent**: Explicit `--intent` is more valuable than auto-inference. It forces clarity in reasoning.

3. **Validate Before Push**: Always use `nool solidify --full` before pushing. This prevents broken code reaching collaborators.

4. **Query Before Changing**: Use `nool query blast-radius` to understand impact of changes to widely-used code.

5. **Document Learnings**: Use `nool learn` to record discoveries. Future-you (and teammates) will appreciate it.

6. **Review the DAG**: Regular `nool dag` visualization helps understand repository structure and causal relationships.

7. **Use Try Branches**: For risky experiments, use `nool try` instead of polluting the main DAG.

8. **Keep Threads Clean**: Archive completed threads to keep the interface focused.

9. **Link to External Systems**: Use `nool link` to connect Knots to issues, PRs, and tickets for full traceability.

10. **Monitor Health**: Run `nool doctor` regularly to catch problems early.

---

*Last updated: May 2026 for Nool v1.33.0*
