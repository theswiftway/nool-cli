# Nool Agent Skills
name: nool
description:
This document describes the available skills for AI coding agents using Nool semantic version control.

Nool is a **Semantic-Agentic Commutative Version Control System** that tracks the *intent* and *reasoning* behind code changes, not just diffs. Agents use Nool to:

- **Initialize repositories** from Git history (`init --from-git`)
- **Propose semantic changes** with intent linking (`propose`)
- **Solidify commits** atomically with validation (`solidify`)
- **Replicate across remotes** bidirectionally (`push`, `pull`, `sync`)
- **Capture knowledge** for future reference (`learn`, `findings`)
- **Query semantically** by intent, not by text (`query`)
- **Debug systematically** with replay and root-cause analysis (`debug`)
- **Collaborate** via threads, tasks, and approval workflows

## Available Skills

### Core Workflow Skills

| Skill | Purpose | When to Use |
|-------|---------|-----------|
| [`nool-init-from-git`](skills/nool-init-from-git/) | Bootstrap a Nool ledger from existing Git | Starting with an existing repository |
| [`nool-propose`](skills/nool-propose/) | Create semantic change proposals | Before making code changes |
| [`nool-solidify`](skills/nool-solidify/) | Sign and commit changes to DAG | After validation; before pushing |
| [`nool-push`](skills/nool-push/) | Replicate changes to remote | Publishing work to team/CI |
| [`nool-pull`](skills/nool-pull/) | Fetch and replay remote changes | Syncing with team updates |
| [`nool-sync`](skills/nool-sync/) | Bidirectional push+pull | Full synchronization |

### Knowledge & Context Skills

| Skill | Purpose | When to Use |
|-------|---------|-----------|
| [`nool-learn`](skills/nool-learn/) | Record findings and root causes | Documenting discoveries |
| [`nool-findings`](skills/nool-findings/) | Query captured knowledge | Before re-implementing similar logic |
| [`nool-query`](skills/nool-query/) | Semantic queries over DAG | Finding related changes by intent |

### Debugging & Analysis Skills

| Skill | Purpose | When to Use |
|-------|---------|-----------|
| [`nool-debug`](skills/nool-debug/) | Replay and analyze agent runs | Understanding failed attempts |
| [`nool-thread`](skills/nool-thread/) | Manage intent threads and chat | Organizing work and collaboration |

### Administrative Skills

| Skill | Purpose | When to Use |
|-------|---------|-----------|
| [`nool-usage`](skills/nool-usage/) | Track token consumption | Monitoring agent resource usage |
| [`nool-admin`](skills/nool-admin/) | Account and team management | Team setup and access control |

---

## Quick Start for Agents

### Initialize a new Nool repository

```bash
nool init
# Or bootstrap from existing Git:
nool init --from-git main
```

### Propose a change

```bash
nool propose \
  --intent "Fix race condition in auth" \
  --path src/auth.rs \
  --kind function
```

### Solidify (commit) the change

```bash
# Fast mode: <5s local iteration, deferred validation
nool solidify --fast

# Full mode: complete semantic guarantees (30-90s)
nool solidify --full
```

### Push to remote

```bash
nool push origin
# Or bidirectional sync:
nool sync origin
```

### Capture and query knowledge

```bash
# Record a finding
nool learn \
  --about "race-condition-auth" \
  --kind root_cause \
  --content "Shared state in token refresh wasn't guarded by mutex"

# Query findings later
nool findings "race-condition"
```

---

## Key Concepts for Agents

### Knot (Atomic Mutation)
The fundamental unit of change. Every `Knot` is cryptographically signed, timestamped, and linked to parent Knots in a DAG. A Knot includes:
- **Intent**: What the change accomplishes (e.g., "Fix rate limiting")
- **SemanticTransform**: The actual code change
- **EditorChain**: Authentication and authorization
- **Metadata**: HLC timestamp, vector clock, commutativity class

### Intent Thread
A named logical grouping of related Knots (e.g., "Auth Refactor Q2"). Threads enable:
- Semantic navigation by feature/task
- Approval workflows
- Release grouping
- Collaboration tracking

### Deterministic Replay
The Knot DAG uses **canonical replay order**: Vector Clock → HLC Timestamp → Knot ID. This ensures all replicas converge identically, even in multi-agent environments.

### Knowledge Index
Searchable semantic index (`LanceDB` + FTS5) storing the *intent* of every change. Agents query by meaning, not by file path or SHA.

---

## See Also

- [`README.md`](README.md) — Full system overview
- [`USER_GUIDE.md`](USER_GUIDE.md) — Complete command reference
- [`spec/Nool_1_8.md`](spec/Nool_1_8.md) — Formal specification
- [`CLAUDE.md`](CLAUDE.md) — Guidance for human/AI agents
- [`AGENTS.md`](AGENTS.md) — Detailed agent workflow documentation
