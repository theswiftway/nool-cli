# Nool Command Reference

**Verified against the installed CLI on this machine:** June 8, 2026  
**Installed version:** 4.0.0

This page reflects the commands exposed by the locally installed `nool` binary. It is organized by workflow so the site matches the command surface users can actually run.

## Global Flags

| Flag | Effect |
|------|--------|
| `--compact` | Agent-friendly output that trims verbose metadata and diagnostics. |
| `--quiet` | Suppress diagnostic noise and print only errors and results. |

## Getting Started: Nool as Your VCS

Nool can be adopted standalone or layered on top of an existing Git history — it doesn't require you to start from scratch.

| Command | Purpose |
|---------|---------|
| `nool init` | Initialize a new Nool ledger and identity key in the current repository. |
| `nool init --from-git <branch>` | Import existing Git history on the given branch (e.g. `--from-git main`) into the Nool ledger, so prior commits become part of the semantic DAG. |
| `nool discover features` | Discover logical feature boundaries in the current project before lifting it into Nool. |
| `nool discover lift [--solidify]` | Save the discovered feature boundaries as Knots, optionally solidifying them immediately with `--solidify`. |
| `nool migrate [--dry-run] [--yes]` | Migrate Nool-generated files from legacy or previous-version locations into the current canonical layout. |

### Onboarding an existing Git repository

```bash
nool init --from-git main
nool discover features
nool discover lift --solidify
nool status --compact
```

## Core Version Control

| Command | Purpose |
|---------|---------|
| `nool init` | Initialize a Nool ledger and identity in a repository (supports `--from-git <branch>`). |
| `nool propose` | Generate a candidate Knot from file changes and intent. |
| `nool solidify` | Sign and append the candidate Knot to the DAG. |
| `nool reify` | Inspect a reified bundle (proposal or solidified knot) and validate its syntax. |
| `nool plan` | Create semantic replay, pluck, merge, and rebase plans. |
| `nool apply` | Execute an approved or draft semantic plan. |
| `nool verify` | Run structural invariants against current or planned state. |
| `nool explain` | Explain identities, dependencies, and reasons for a semantic object. |
| `nool evidence` | Show why an AI-authored transition was accepted or rejected. |

### Common flow

```bash
nool status --compact
nool announce intent --intent "Refine homepage command reference"
nool propose --all --intent "Refresh site command docs" --fast
nool solidify --full
```

## Sync, History, and Release

| Command | Purpose |
|---------|---------|
| `nool push` | Replicate unpushed Knots to a remote replica. |
| `nool pull` | Fetch and replay Knots from a remote replica. |
| `nool sync` | Bidirectional semantic sync. |
| `nool log` | Show the canonical replay log. |
| `nool diff` | Show file-content diff between two Knots. |
| `nool changelog` | Generate a semantic changelog. |
| `nool tag` | Create a semantic tag. |
| `nool checkpoint` | Mark the current state as a checkpoint or release label — a semver-shaped label (e.g. `1.2.0`) is treated as a release on a release branch. (`release` is an alias.) |
| `nool approve` | Approve a Knot or Intent Thread. |
| `nool promote` | Promote a local Knot to staged or synced status. |

## Discovery and Inspection

| Command | Purpose |
|---------|---------|
| `nool status` | Repository health, DAG state, licensing, and pending proposals. |
| `nool doctor` | Release-readiness and repository health checks. |
| `nool dag` | Visualize the DAG. |
| `nool visualize` | Visualize project evolution and artifact graphs (`history`, `graph`, `roi`, `relational`; TUI or HTML output). |
| `nool why` | Walk the causal chain of a change. |
| `nool query` | Run semantic queries over the Knot DAG. |
| `nool discover` | Find conflicts, restore context, extract learnings, locate similar work, map feature boundaries (`features`), and save them (`lift`). |
| `nool insights` | Show project insights, blast radius stats, and time-saved metrics. |
| `nool review` | Open the interactive review surface for candidate changes. |
| `nool audit` | Generate intent, authorship, and release compliance reports. |

### Useful query and discovery examples

```bash
nool query search "auth middleware"
nool query blast-radius --path src/auth.ts
nool discover conflicts auth
nool discover similar "semantic merge"
nool discover features
nool discover lift --solidify
```

## Threads, Tasks, and Knowledge

| Command | Purpose |
|---------|---------|
| `nool work` | Start a new piece of work, optionally fanning it out into parallel subtasks (`work start --intent "..." --parallel <n>`). |
| `nool thread` | Manage intent threads. |
| `nool task` | Manage task lifecycle. |
| `nool inbox` | Unified notification center. |
| `nool learn` | Record a knowledge finding, dependency insight, or reasoning note. |
| `nool findings` | Retrieve recorded findings for a file, thread, or topic. |
| `nool link` | Retroactively link a solidified Knot to intent or thread metadata. |
| `nool announce` | Coordinate work across multiple agents before edits begin (`intent`, `with-context`). |
| `nool bug` | Report, link, list, and inspect bugs. |

### Multi-agent coordination example

```bash
nool announce with-context \
  --intent "Refactor auth checks" \
  --decisions "Keep current token format" \
  --constraints "Do not widen API surface"
```

## Workspaces (Multi-Project Coordination)

| Command | Purpose |
|---------|---------|
| `nool workspace status` | Show the project tree (Org → Dept → Team → Project), declared edges, and order. |
| `nool workspace doctor` | Reconcile declared workspace config against discovered projects and suggest fixes. |
| `nool workspace goal` | Build a goal — `--decompose <target>=<task>` fans tasks out top-down across child projects, or absorbs recent child knots bottom-up. |
| `nool workspace goals` | List persisted workspace goals, rolling up each task's state from children. |
| `nool workspace goal-status` | Show a goal's completion status broken down across the projects it spans. |
| `nool workspace insights` | Aggregate `nool insights` across every child project into one rollup. |
| `nool workspace pull` | Run `nool pull` in every child project, in dependency order, and roll up the results. |

## Git Bridge and Runtime Surfaces

| Command | Purpose |
|---------|---------|
| `nool bridge` | Manage the Git Bifrost bridge and LFS integration. |
| `nool daemon` | Launch the background sync daemon. |
| `nool console` | Launch the interactive web console. |
| `nool ui` | Launch the interactive TUI DAG explorer. |
| `nool untrack` | Stop tracking files in Git while keeping them locally. |
| `nool validate` | Run background validation for quarantined fast-mode Knots. |

## Administration and Lifecycle

| Command | Purpose |
|---------|---------|
| `nool admin` | Account, team, plugin, and billing administration. |
| `nool config` | Show and manage current effective system configuration. |
| `nool languages` | List supported languages and validator availability. |
| `nool usage` | Show token budgets and agent performance metrics. |
| `nool prune` | Clean temporary and cached files (`--all` removes every known cache and build artifact). |
| `nool migrate` | Migrate Nool-generated files from legacy locations into the current canonical layout (`--dry-run`, `--yes`). |
| `nool version` | Print installed version information. |
| `nool upgrade` | Upgrade the CLI to the latest version. |
| `nool uninstall` | Remove the CLI and local identity keys. |
| `nool completion` | Generate shell completion scripts. |
| `nool quick-start` | Show the beginner quick-start guide. |
| `nool guide` | Show the detailed command guide. |
| `nool help` | Print help for the root command or subcommands. |

## Experimentation and Debugging

| Command | Purpose |
|---------|---------|
| `nool try` | Create ephemeral experiment branches that do not enter the DAG until promoted. |
| `nool debug` | Replay, diff, blame, rerun, and bisect semantic history. |
| `nool compare` | Compare semantic changes between threads or releases. |
| `nool pluck` | Selectively undo thread-aligned work. |

## Commands Present in the Installed Binary

The top-level command tree currently includes:

`init`, `workspace`, `propose`, `try`, `tag`, `checkpoint`, `approve`, `solidify`, `push`, `pull`, `sync`, `log`, `why`, `status`, `doctor`, `admin`, `prune`, `migrate`, `languages`, `debug`, `dag`, `pluck`, `link`, `changelog`, `compare`, `diff`, `thread`, `task`, `audit`, `bridge`, `inbox`, `console`, `quick-start`, `guide`, `work`, `version`, `upgrade`, `uninstall`, `query`, `ui`, `daemon`, `promote`, `bug`, `validate`, `untrack`, `learn`, `findings`, `usage`, `discover`, `reify`, `announce`, `completion`, `plan`, `apply`, `verify`, `explain`, `evidence`, `insights`, `review`, `visualize`, `config`, `help`

## Notes

- The command surface above is based on the installed binary (`v4.0.0`), not older draft docs.
- New since `3.4.2`: `workspace`, `checkpoint` (replaces the old top-level `release` — `release` now works only as an alias), `prune`, `migrate`, `work`, `reify`, `visualize`, and `config`. `nool init` also gained `--from-git <branch>` to import existing Git history when adopting Nool as your VCS.
- Commands previously mentioned in older docs such as `rehydrate`, `history`, `policy`, and `impact` are not top-level commands in the installed CLI.
- For agent workflows, prefer `--compact` on `status`, `log`, `dag`, and `plan status`.
