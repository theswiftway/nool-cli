# Nool

[![Version](https://img.shields.io/badge/version-4.0.0-blue.svg)](https://github.com/nool-dev/nool)
[![Status](https://img.shields.io/badge/status-production-green.svg)](https://github.com/nool-dev/nool)

Nool is a version control system engineered for the era of AI-authored code. It acts as the control plane between an AI coding agent's intent and the codebase it modifies, ensuring changes are intentional, inspectable, and governed before they become canonical.

Get started for free with the trial: **2,000 knots or 30 days**, whichever expires first.

## Core Capabilities

Nool provides agentic change control for AI coding-agent workflows:

- **Intent Tracking**: Record engineering intent before code acceptance.
- **Blast Radius Analysis**: Compute the semantic impact of every change.
- **Semantic Impact Envelope Enforcement**: Flag modifications that exceed declared scope.
- **Causal Justification**: Require evidence when implementation exceeds the declared envelope.
- **Policy and Security Gates**: Validate changes before they are accepted into the repo.
- **Durable State**: Preserve intent, impact, findings, and justifications alongside the code.

Git remains the ecosystem compatibility and storage layer. Nool governs the evolution of AI-authored code.

## Install

```bash
./install_tar.sh nool-4.5.0-aarch64-apple-darwin.tar.gz
nool version
```

## Quick Links

- [Skills.md](./Skills.md): Full CLI command reference for the installed surface.
- [skills/nool-commands/SKILL.md](./skills/nool-commands/SKILL.md): Agent-optimized Nool skill file.
- [docs/index.html](./docs/index.html): Static documentation landing page.

## Adopting Nool as Your VCS

Nool can absorb an existing Git history and lift the current project structure into the semantic ledger:

```bash
nool init --from-git main
nool discover features
nool discover lift --solidify
nool status --compact
```

If you are starting fresh, run `nool init` without `--from-git`.

## Core Workflow

Use this sequence for most code changes:

```bash
nool status --compact
nool announce intent --intent "Refine command documentation"
nool propose --all --intent "Refresh docs from product site" --fast
nool solidify --full
nool sync origin
```

For planned state transitions and safer staged execution:

```bash
nool plan replay --target <op_ids>
nool review <plan_id>
nool apply --plan-id <plan_id>
```

## Command Map

### Core Version Control

- `nool init`: Initialize a Nool ledger and identity in a repository.
- `nool propose`: Generate a candidate Knot from file changes and intent.
- `nool solidify`: Sign and append the candidate Knot to the DAG.
- `nool reify`: Inspect a reified bundle and validate syntax before solidifying.
- `nool plan`: Create semantic replay, pluck, merge, and rebase plans.
- `nool apply`: Execute an approved or draft semantic plan.
- `nool verify`: Run structural invariants against current or planned state.
- `nool explain`: Explain identities, dependencies, and reasons for a semantic object.
- `nool evidence`: Show why an AI-authored transition was accepted or rejected.

### Sync, History, and Release

- `nool push`: Replicate unpushed Knots to a remote replica.
- `nool pull`: Fetch and replay Knots from a remote replica.
- `nool sync`: Run bidirectional semantic sync.
- `nool log`: Show the canonical replay log.
- `nool diff`: Show file-content diffs between two Knots.
- `nool changelog`: Generate a semantic changelog.
- `nool tag`: Create a semantic tag.
- `nool checkpoint`: Mark the current state as a checkpoint or release label.
- `nool approve`: Approve a Knot or intent thread.
- `nool promote`: Promote a local Knot to staged or synced status.

### Discovery and Inspection

- `nool status`: Repository health, DAG state, licensing, and pending proposals.
- `nool doctor`: Release-readiness and repository health checks.
- `nool dag`: Visualize the DAG.
- `nool visualize`: Visualize history, graphs, ROI, and relational artifacts.
- `nool why`: Walk the causal chain of a change.
- `nool query`: Run semantic queries over the Knot DAG.
- `nool discover`: Restore context, find conflicts, discover features, and lift them into Knots.
- `nool insights`: Show project insights, blast radius stats, and time-saved metrics.
- `nool review`: Open the interactive review surface for candidate changes.
- `nool audit`: Generate intent, authorship, and release compliance reports.

### Threads, Tasks, and Knowledge

- `nool work`: Start a new piece of work, with optional parallel subtasks.
- `nool thread`: Manage intent threads.
- `nool task`: Manage task lifecycle.
- `nool inbox`: Open the unified notification center.
- `nool learn`: Record a knowledge finding, dependency insight, or reasoning note.
- `nool findings`: Retrieve recorded findings for a file, thread, or topic.
- `nool link`: Retroactively link a solidified Knot to intent or thread metadata.
- `nool announce`: Coordinate work across multiple agents before edits begin.
- `nool bug`: Report, link, list, and inspect bugs.

### Workspaces

- `nool workspace status`: Show the project tree and dependency order.
- `nool workspace doctor`: Reconcile declared workspace config against discovered projects.
- `nool workspace goal`: Decompose or absorb cross-project goals.
- `nool workspace goals`: List persisted workspace goals and rollups.
- `nool workspace goal-status`: Show completion status across projects.
- `nool workspace insights`: Aggregate insights across child projects.
- `nool workspace pull`: Run `nool pull` across the workspace in dependency order.

### Runtime and Administration

- `nool bridge`: Manage the Git Bifrost bridge and LFS integration.
- `nool daemon`: Launch the background sync daemon.
- `nool console`: Launch the interactive web console.
- `nool ui`: Launch the interactive TUI DAG explorer.
- `nool untrack`: Stop tracking files in Git while keeping them locally.
- `nool validate`: Run background validation for quarantined fast-mode Knots.
- `nool admin`: Account, team, plugin, and billing administration.
- `nool config`: Show and manage effective system configuration.
- `nool languages`: List supported languages and validator availability.
- `nool usage`: Show token budgets and agent performance metrics.
- `nool prune`: Clean temporary and cached files.
- `nool migrate`: Migrate Nool-generated files into the canonical layout.
- `nool upgrade`: Upgrade the CLI.
- `nool uninstall`: Remove the CLI and local identity keys.
- `nool completion`: Generate shell completion scripts.
- `nool quick-start`: Show the beginner quick-start guide.
- `nool guide`: Show the detailed command guide.

## Notes

- This repository now carries the newer command-reference content from `knot-agent-vision`, replacing the older `v3.2.0` docs set.
- `nool checkpoint` is the primary release-label command; `nool release` remains a backward-compatible alias.
- For agent workflows, prefer `--compact` on `status`, `log`, `dag`, and `plan status`.

## Learn More

- Product site: https://www.nool.dev
- Why Nool exists: https://www.nool.dev/why-nool
- Semantic Impact Envelope: https://www.nool.dev/semantic-impact-envelope
- Research: https://www.nool.dev/research
- Setup: https://www.nool.dev/setup
