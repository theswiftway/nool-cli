---
name: nool-commands
description: Comprehensive expert guidance for the Nool CLI. Covers semantic VCS, algebraic planning (replay/merge/rebase), staged execution, thread management, task lifecycle, multi-agent coordination, discovery and knowledge, diagnostics, and Git interop. Use for all Nool-related operations from initialization to hardened release.
license: Apache-2.0
metadata:
  version: "4.0.0"
  author: nool-core-team
compatibility: Requires nool CLI v4.0.0+
allowed-tools: bash(nool *)
---

# Nool Expert Skill

Nool is a **Deterministic Semantic Strong Eventual Consistency (D-SSEC)** version control system. This skill covers the entire command surface of the `nool` CLI.

## Adopting Nool as Your VCS (from an existing Git repo)

Nool doesn't require a clean slate — it can absorb an existing Git history and lift the project's structure into the semantic ledger:

1. **Import Git history**: `nool init --from-git <branch>` (for example `nool init --from-git main`) replays existing commits on that branch into the Nool DAG.
2. **Map feature boundaries**: `nool discover features` finds logical feature boundaries in the current project.
3. **Lift them into Knots**: `nool discover lift --solidify` saves the discovered boundaries as Knots and solidifies them immediately. Omit `--solidify` to review first.
4. **Confirm**: `nool status --compact`

If you are starting fresh with no Git history to import, run `nool init`.

## Core VCS Workflow

Use this sequence for most code changes:

1. **Check state**: `nool status`
2. **Announce intent**: `nool announce intent --intent "My feature"`
3. **Plan**: `nool plan replay --target <op_ids>`
4. **Review**: `nool review <plan_id>`
5. **Apply**: `nool apply --plan-id <plan_id>`
6. **Solidify**: `nool solidify --full`
7. **Sync**: `nool sync origin`

## Algebraic Planning and Execution

### `nool plan`

- `replay --target <ids>`: Compute a path to a target state.
- `pluck --targets <ids>`: Plan a selective undo.
- `merge --branches <names>`: Plan an algebraic union of divergent states.
- `status`: Show the current plan status and steps.
- `rebase --upstream <name>`: Re-sequence local changes on a new base.

### `nool apply`

Execute a plan within the hardened staged runtime.

`nool apply --plan-id <id> [--approval-id <id>] [--staging-root <path>]`

### `nool verify`

Manually trigger structural invariant checks.

`nool verify [--target <id>] [--all]`

### `nool explain`

Surface the rationale and lineage of any semantic object.

`nool explain <op_id|plan_id|knot_id>`

### `nool review`

Interactive review surface for candidate changes.

`nool review <plan_id>`

### `nool evidence`

Transition Evidence: prove why an AI-authored state transition was accepted or rejected.

`nool evidence <knot_id>`

### `nool reify`

Inspect a reified bundle and validate its syntax before solidifying.

`nool reify inspect <bundle_id>`

## Thread, Task, and Work Management

### `nool work`

- `start --intent "<text>" [--parallel <n>] [--teams <names>]`: Start a new piece of work and optionally fan it out into parallel subtasks across teams.

### `nool thread`

- `create "<name>"`: Initialize a new workstream.
- `list`: View all active and archived threads.
- `show <name>`: Show thread details.
- `status --name <name> --status <draft|active|review|released|archived>`: Manage lifecycle.
- `chat <name>`: Add DAG-backed notes.
- `handoff <name>`: Handoff thread responsibility to another agent.

### `nool task`

- `create --name "<task>"`: Add a specific item to the inbox with explicit or generated acceptance criteria.
- `list`: List all tasks with their current states.
- `inbox`: View unassigned open tasks and their criteria attention state.
- `pick --id <id>` / `mine`: Claim ownership.
- `assign <id> --to <agent>`: Assign a task to an agent or person.
- `finish --id <id>`: Mark completion.
- `block --id <id> --reason "<text>"`: Block a task with explanation.
- `cancel <id>` / `remove <id>`: Cancel or remove a task while retaining auditable history.
- `criteria`: Inspect, replace, or review acceptance criteria.
- `sync`: Import assigned tasks from configured providers.
- `list-github` / `import-github`: List or import GitHub issues as tasks.
- `list-jira` / `import-jira`: List or import Jira tickets as tasks.

## Discovery and Knowledge

### `nool discover`

- `conflicts <nodes>`: Check for intent collisions before proposing changes.
- `context --snapshot-id <id>`: Rehydrate task context from previous work.
- `learnings --thread-id <id>`: Extract decisions from a thread.
- `similar <topic>`: Find similar work by topic or approach.
- `features`: Discover logical feature boundaries in the current project.
- `lift [--solidify]`: Save the discovered feature boundaries as Knots.

### `nool query`

- `resolve-intent "<text>"`: Find Knots matching an intent query.
- `neighbors <node_id>`: Show causal neighbors of a Knot.
- `recent-knots`: Show recent Knots.
- `blast-radius <targets>`: Compute causal descendants for Knots or file paths.
- `materialize <node_ids>`: Reconstruct content from Knots.
- `validate <files>`: Validate files without proposing.
- `search "<text>"`: Semantic natural-language search over the DAG.

### `nool learn` and `nool findings`

- `learn --about <topic> --kind <kind> --content "<text>"`: Record reasoning.
- `findings <subject>`: Retrieve recorded knowledge.

## Health and Diagnostics

- `nool status`: Rich repository overview.
- `nool log`: Canonical replay log.
- `nool dag`: Visualize the causal graph.
- `nool visualize -k <history|graph|roi|relational> -f <tui|html> [-o <path>]`: Visualize project evolution and artifact graphs.
- `nool doctor`: Health and release-readiness checks.
- `nool diff <knot_a> <knot_b>`: Show file-content diffs between two Knots.
- `nool validate`: Run background validation for fast-mode Knots.
- `nool insights`: Show generative project insights, blast radius stats, and time saved.
- `nool audit`: Compliance report covering intent coverage, authors, and release history.
- `nool usage`: Token budgets and performance metrics.
- `nool prune [--all]`: Clean temporary and cached files.

## Context Efficiency

`--compact` is available globally and is essential for AI workflows to reduce token and context consumption.

- `nool dag --compact --limit 20`: Structural view without content bloat.
- `nool log --compact --limit 10`: Recent history without commit-message bodies.
- `nool status --compact`: Fast head count plus proposal check.
- Combine with `--quiet` to suppress diagnostic noise.

## Workspaces

- `nool workspace status`: Show the project tree, declared edges, and order.
- `nool workspace doctor`: Reconcile declared config against discovered projects and suggest fixes.
- `nool workspace goal --decompose <target>=<task>`: Fan a goal across child projects.
- `nool workspace goals`: List persisted workspace goals rolled up from child task states.
- `nool workspace goal-status <id>`: Show goal completion across projects.
- `nool workspace insights`: Aggregate `nool insights` across child projects.
- `nool workspace pull`: Run `nool pull` in every child project in dependency order.

## Git Interop

- `nool git <command> [args]`: Raw Git pass-through.
- `nool init --from-git <branch>`: Import Git history into the Nool ledger.
- `nool bridge status`: Monitor the Bifrost Git mirror.
- `nool bridge add-remote <url>` / `remove-remote <url>`: Manage auto-push remotes.
- `nool bridge watch`: Start the sync watch daemon.
- `nool bridge mirror-repair`: Repair or rebuild the Bifrost Git mirror.
- `nool bridge lfs`: Initialize git-lfs support.
- `nool promote <knot_id>`: Promote a local Knot to staged or synced status.
- `nool untrack <path>`: Stop tracking files in Git while keeping them in the working tree.

## Interactive and Daemon

- `nool console`: Launch the interactive web dashboard.
- `nool ui`: Interactive TUI DAG explorer.
- `nool daemon`: Launch the background sync daemon.

## Debug and Root Cause

- `nool debug replay <ref>`: Start interactive replay of a Git ref or agent run.
- `nool debug step <id>`: Inspect a specific replay step.
- `nool debug diff <id>`: Show the diff of a replay step.
- `nool debug edit <id>`: Add a constraint to a replay step.
- `nool debug rerun <id>`: Replay from a selected step.
- `nool debug blame <failure_point>`: Find root cause.
- `nool debug bisect --good <id> --bad <id>`: Binary search for regressions.
- `nool debug blast-radius <id>`: Compute semantic blast radius and risk analysis.

## Compare and Release

- `nool compare <left> <right>`: Compare semantic changes between threads or releases.
- `nool changelog [--since <ref>] [--thread <name>]`: Generate a semantic changelog.
- `nool tag <name>`: Create a semantic tag.
- `nool checkpoint <version> [-i <thread>] [-e <thread>] [-c <channel>] [-s]`: Mark the current state as a checkpoint or release label. `nool release <version>` is a backward-compatible alias.
- `nool approve <knot_id>`: Approve a Knot or intent thread.

## Administrative

- `nool admin account`: Account settings.
- `nool admin team`: Team management.
- `nool admin plugin`: Plugin management.
- `nool admin channel`: Notification channel management.
- `nool admin gc`: Resource management.
- `nool admin train-dict`: Train the storage compression dictionary.
- `nool admin reconcile`: Process a batch from the repair queue.
- `nool admin reindex-graph`: Rebuild the entity dependency graph from the working tree.
- `nool config show`: Show current effective system configuration.
- `nool inbox`: Unified notification center.
- `nool languages`: List supported languages and validation status.
- `nool migrate [--dry-run] [--yes]`: Migrate Nool-generated files into the canonical layout.

## Multi-Agent Coordination

- `nool announce intent "..."`: Announce intent before starting work.
- `nool announce with-context "..." --decisions "..." --constraints "..."`: Share fuller execution context.

## Safety Mandates

- Always use `nool apply` for final materialization instead of manually moving staged files.
- Check for stale-plan errors and regenerate plans if the graph has drifted.
- Use `nool announce` before complex architectural changes.
- Run `nool doctor` before releases to catch pending proposals and parallel timelines.
- Use `nool try` branches for risky experiments.
- Use `nool learn` to record root causes, findings, and dependency insights.

## Known Gaps and Workarounds

### `nool plan merge` may not recognize timeline labels

If timeline names shown in `nool status` are not resolvable as merge branch names, target the desired head directly with `nool plan replay --target <head_id>`.

### Plans go stale after graph mutations

Any `nool solidify`, `nool propose`, or knot creation changes the graph hash. Use the sequence solidify, then plan, then apply.

### `nool explain` can return generic text

If explanation output is too generic, use `nool log --compact` or `nool dag --compact` instead.

### DB constraint errors on plan save

If `UNIQUE constraint failed: v2_plan_steps.step_id` appears during replanning with `--save`, check `nool plan status`; the plan may still have been created.

### Pending proposals are binary bundles

`.nool/candidate.knot` is a binary file. Inspect it with `nool diff` or resolve it with `nool solidify --full`.

### `nool apply` uses `--plan-id`

Use `--plan-id` with a hyphen, not `--plan_id`.
