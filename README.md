# Nool (v1.16.0)
**Semantic-Agentic Commutative Version Control System**

Nool is a **Deterministic Semantic Strong Eventual Consistency (D-SSEC)** version control system. Unlike Git, which tracks lines of text, Nool tracks atomic semantic mutations called **Knots** in a Directed Acyclic Graph (DAG) — preserving the *intent* and *reasoning* behind every change, not just the diff.

---

## Core Principles

- **Logic over Lines** — The Knot DAG is the canonical source of truth, not text files.
- **Speculative Reification** — Every proposal is materialized into a transient scratchpad and validated by language-native integrity drivers (e.g. `cargo check`, `go vet`) before solidification.
- **Reliability & Knowledge Capture (1.16.0)** — `solidify --full` now runs reification, `propose --solidify` preserves thread links, bundle files carry attribution roles, and `nool learn` / `nool findings` capture searchable team knowledge.
- **Release Doctor (1.15.6)** — `nool doctor` is the release-readiness authority across Nool semantic state, Git worktree hygiene, and optional artifact checks.
- **Agent Debug Replay (1.15.5)** — Inspect agent runs as step-by-step replay units with `nool replay`, drill into reasoning/context/diffs, add constraints, rerun from a step, and surface root-cause summaries without learning Knot/DAG internals.
- **Security Hardening (1.15.4)** — Unconditional Ed25519 signature verification (bypass via `is_valid` flag closed), full X3DH identity-key binding in the transport layer, KDF-separated message keys, and contract enforcement for all editor/planner mutations.
- **Correctness Fixes (1.15.4)** — Payload hash now committed into every `knot_id` (preventing silent ID collisions), canonical `Ord` restored to VC→HLC→ID per spec §3.1, and cosine-distance search fixed with L2-normalized embeddings.
- **Hardened Concurrency (1.15.2)** — **Proposal Manifests** (base_heads + touched_node_ids) prevent semantic write contention in multi-agent environments.
- **Layered Memory Architecture (1.15.2)** — Authoritative **SQLite WAL ledger** (truth) + derived **LanceDB semantic sidecar** (retrieval). Features automated self-healing and hybrid search (FTS5 + Vector).
- **Async-Safe MCP Server (1.15.2)** — High-concurrency context rehydration for coding agents, fully decoupled from SQLite `!Send` boundaries.
- **Console Runtime Fix (1.15.2)** — `nool console` now serves directly from the existing async runtime instead of starting a nested Tokio runtime.
- **Git-Private Bifrost Mirror (1.15.2)** — Default and legacy mirrors now resolve into host Git private storage (`.git/nool/`) when Nool runs inside an existing Git repo, preventing nested repo/gitlink pollution.
- **Fast Path Runtime (1.9.0)** — `--fast` mode delivers **<5s local iteration** with deferred validation, mirror self-healing, directory auto-bundle detection, and **80%+ token reduction** in CLI output. Default for rapid agentic workflows.
- **Full Validation Mode (1.9.0)** — `--full` mode provides complete semantic guarantees: compiler + Aram Gate + cascade + ghost tests (30-90s). Required for releases and sync.
- **Concrete WASM Policy System (1.10.0)** — Rust SDK for writing policies that compile to WASM. Ships with 5 built-in policies (no-empty-diff, scope-enforcement, budget-check, etc.), chain evaluation with short-circuit denial, and `.nool/Policy.toml` project manifests.
- **Directory Bundling (1.13.1)** — Automatic ecosystem detection and multi-file bundling when proposing a directory. `nool propose --path backend/src/`.
- **Release Channels (1.13.1)** — Define and use release trains (stable, beta) with custom policies. `nool release v1.0.0 --channel stable`.
- **Automatic Intent Compliance (1.13.1)** — Automatic generation of `intent_ref` from intent strings, ensuring 100% compliance in `nool audit`.
- **Short ID Support (1.13.1)** — Support for unambiguous short hex IDs (8+ chars) in all ID-based commands, resolving the "64-char trap".
- **Token Ledger & Economics (1.12.0)** — Parallel accounting for agent-generated code: usage, budgets, analytics, and ROI. `nool token usage/analytics`, `nool agent-report`, `nool dashboard`.
- **Polished Console (1.12.0)** — Integrated Review Inbox, Agent Performance Panel, and Thread Comparison view. `nool console`.
- **Structured Bug Tracking (1.11.0)** — First-class `Bug` payload with severity, reproduction steps, fix linkage, and retroactive attribution. `nool bug report/list/show/link`.
- **Regression Bisect (1.11.0)** — Binary search through DAG replay order to find the exact Knot that introduced a regression. `nool bisect --good <id> --bad <id> --test "cargo test"`.
- **Pattern Blacklist (1.11.0)** — Regex-based invariant enforcement to ban buggy patterns from reappearing. `Invariant { condition: "regex:unwrap\\(\\)" }`.
- **Token Budget Enforcement (1.11.0)** — Per-author consumption tracking in Aram Gate, estimates tokens from diff size, rejects when budget exceeded. Persistent via `nool token budget-set`.
- **Mirror Self-Healing (1.9.0)** — Auto-repairs missing refs, stale worktrees, and corrupt commits on every `propose`/`solidify` — no manual git surgery needed.
- **Runtime Query Interface (1.9.0)** — Agent-first semantic DAG tools: `nool query resolve-intent`, `neighbors`, `blast-radius`, `materialize`, `validate`.
- **Ergonomic Workflows (1.8.0)** — Streamlined CLI with `--solidify` and `--sync` flags. **Auto-Mirror Sync** and **Bundled Proposals** for compiled languages.
- **Hardened Concurrency** — **Proposal Manifests** include `base_heads` and `touched_node_ids` for semantic write contention detection.
- **Agent Collaboration Contracts** — Explicit on-chain contracts define agent roles, authorized scope, and resource budgets, enforced by the Aram Gate.
- **Deterministic Replay** — Every replica reconstructs the exact same state using a canonical comparator (Vector Clock → HLC → ID).
- **Structural Identity** — `NodeID`s strip whitespace and formatting; a refactor that changes only style does not break history.
- **Intent-First** — Every mutation carries a human/agent rationale stored in the Intent Index, making history searchable by *meaning*, not just by SHA.
- **Selective History** — The "Pluck" capability allows for O(1) semantic undo of specific feature threads without losing subsequent parallel work.
- **Local-First** — Fully functional offline; CRDT-based sync merges transparently on reconnect.
- **Polyglot Support** — Native AST-level awareness for 30+ languages, extensible via **Language Plugins** or **Configuration**.
- **Custom Language Support (Plugins) (1.14.0)** — Write custom language adapters in Rust using the `nool-language-sdk`, compile to WASM, and drop into `plugins/` for instant stable NodeID support for any language.
- **Configuration-based Language Support (1.14.0)** — Define simple language rules (extensions, comment prefixes) directly in `nool.toml`. These configurations are embedded and versioned in **Release** Knots, ensuring global consistency across the DAG.
- **Semantic Canonicalization** — Built-in stability for configuration and markup languages (JSON, TOML, YAML, XML).
- **Interactive Web Console** — A real-time visual dashboard launched via `nool console`. Features an SSE-backed DAG explorer with Level-of-Detail (LOD) rendering, Review Inbox with approve/reject, Agent Performance Panel, Token Ledger visualization, and Thread Comparison view.
- **Agentic MCP API** — Standardized Model Context Protocol server for native AI agent interaction with logical history.
- **Deterministic Release & Distribution** — Formal, signed `nool release` markers and efficient `nool sync` for logical change distribution.

---

## Why Nool?

Traditional VCS tools are optimized for text files. Nool is built for a world where agents write code alongside humans and where understanding *why* something changed matters as much as *what* changed.

- **Agents are first-class citizens** — Intent, rationale, and semantic meaning are preserved alongside every mutation.
- **Non-developers can participate** — Intent Threads, Changelogs, and Audit Reports surface history in plain language.
- **Consistency is provable** — Deterministic replay is formally verified in TLA+; no textual merge heuristics.

See the [User Guide](USER_GUIDE.md) for a deeper walkthrough and a comparison with Git.

---

## Configuration & Advanced Control

Nool is fully configuration-driven via `nool.toml`. When you run `nool init`, a default configuration is generated with advanced controls for security, performance, and integration.

### `nool.toml` Schema

```toml
[aram]
policies_path = "policies/" # Dir for WASM compliance blobs
gas_limit = 100000          # WASM fuel metering for validation
memory_limit = 65536        # Sandbox memory isolation (bytes)
strict_floats = true        # Enforce NaN bit-determinism (§5.1)

[bridge]
git_mirror_path = ".nool/git_mirror/"
sync_on_solidify = true     # Auto-export Knots to Git DAG on sign

[replay]
max_clock_skew_ms = 5000    # HLC drift tolerance
strict_causality = true     # Panic on DAG cycle detection

[memory]
similarity_threshold = 0.7  # Cosine similarity floor for vector search
embedding_model = "local"   # Plug-and-play for LLM providers
```

### Advanced Features

- **Programmable Aram Policies** — Drop `.wasm` policy files into `policies/` to enforce custom validation logic (e.g., "no mutations to `/sys` without a Security Lead signature").
- **Automatic Git Mirroring** — With `sync_on_solidify`, every Nool mutation is instantly mirrored to a standard Git repository, mapping Nool's DAG to Git's commit graph.
- **Vector-Based Intent Search** — The `nool search` command utilizes cosine similarity on intent embeddings to find semantically related changes.
- **Thread Lifecycle & Release Snapshots** — Manage long-running work via `draft` → `active` status. Perform semantic releases with explicit thread inclusions and causal dependency checks.
- **Extensible Release Channels** — Define named channels (e.g. `stable`, `beta`) with custom Aram Gate policies for approval and quality.

---
## Workspace Architecture

| Crate | Responsibility |
|---|---|
| `nool-core` | Knot DAG, canonical Replay Engine, Node synchronization, Plugin Registry, **Fast Path Runtime** |
| `nool-ast` | Stable `NodeID` computation, Language Adapter trait |
| `nool-storage` | SQLite WAL ledger — Knots, Intent Threads, author queries |
| `nool-memory` | `IntentThread` and `LanceDBIndex` — text search and thread management |
| `nool-aram` | WASM Airlock (Wasmtime sandbox), **Policy Chain enforcement** |
| `nool-aram-policy-sdk` | **Rust → WASM policy SDK**, `policy!` macro, 5 built-in policies |
| `nool-language-sdk` | **Rust → WASM language SDK**, `language_plugin!` macro for custom adapters |
| `nool-transport` | Signal Protocol (Double Ratchet, X3DH) — secure E2EE sync |
| `nool-bridge` | Bifrost Git mirror — export Knots as standard Git commits, **self-healing** |
| `nool-cli` | `nool` binary — all user-facing commands, **fast/full modes**, **query interface** |

---

## Extensibility & Plugins

Nool is designed as an extensible platform where core logic is minimal and specialized behavior is handled by sandboxed **WebAssembly (WASM)** plugins.

### WASM Policy System (1.10.0)

Nool ships with a **concrete WASM policy system** built on the `nool-aram-policy-sdk`. Policies are written in Rust, compiled to `wasm32-unknown-unknown`, and evaluated in a Wasmtime sandbox with fuel metering.

**Policy ABI:**
- `alloc(len: u32) -> i32` — bump allocator returning a linear memory offset
- `validate(offset: i32, len: i32) -> i32` — evaluate policy, return 1 (allow) or 0 (deny)

**Built-in policies** (evaluated in sorted order, short-circuit on first denial):

| Policy | Purpose |
|---|---|
| `no-empty-diff` | Rejects mutations with empty or whitespace-only diffs (min 3 non-ws chars) |
| `require-documented-intent` | Validates semantic paths are structured (`::` or `/` separators) |
| `budget-check` | Rate limiting, spam detection (single-byte patterns), temporal validation |
| `scope-enforcement` | Restricts mutations to authorized scope prefixes (configurable at compile time) |
| `tla-spec-required` | Validates Task::Create structure (name length limits) |

**Project-level configuration** via `.nool/Policy.toml`:
```toml
[[policies]]
name = "no-empty-diff"
path = "policies/no-empty-diff.wasm"
enabled = true
```

**Writing custom policies:**
```rust
use nool_aram_policy_sdk::{policy, Policy, PolicyContext, PolicyResult};

policy!(MyPolicy);

struct MyPolicy;

impl Policy for MyPolicy {
    fn name() -> &'static str { "my-policy" }
    fn evaluate(ctx: &PolicyContext) -> PolicyResult {
        // Inspect the Knot and decide
        PolicyResult::Allow
    }
}
```

Compile with: `cargo build --target wasm32-unknown-unknown --release`

### Other Plugin Types

- **Language Plugins (1.14.0)**: Pluggable AST parsers and stable NodeID calculators for any programming language. Built using `nool-language-sdk`.
- **Workflow Plugins**: Event-driven hooks that trigger on `Knot.solidified` (e.g., Jira sync, Slack notifications).
- **Agent Plugins**: Adapters for AI coding agents (Claude, Copilot) to interact with the Knot DAG via a stable ABI.

Plugins run in a zero-ambient-authority sandbox with explicit capability grants, ensuring safety without sacrificing power.

---

## Building & Installing

### Prerequisites

- Rust 1.75+ (`rustup update stable`)
- SQLite3 development headers (`brew install sqlite` / `apt install libsqlite3-dev`)
- Java — only required for TLA+ model checking (`tlc`)

### Development build

```bash
cargo build               # all crates, debug profile
cargo run -p nool-cli -- <command>
```

### Release build

```bash
cargo build --release
# Produces three binaries in target/release/:
#   nool       — main CLI
#   nool-hub   — hub/relay server
#   nool-mcp   — MCP server for agent context rehydration
```

### Install from source

Run the bundled script to copy the release binaries to `/usr/local/bin` (or a custom prefix):

```bash
./install.sh                          # installs to /usr/local/bin (default)
./install.sh --prefix ~/.local        # installs to ~/.local/bin
```

The script:
1. Runs `cargo build --release` automatically if the binaries are not already built.
2. Copies `nool`, `nool-hub`, and `nool-mcp` to `<prefix>/bin`.
3. Falls back to `sudo install` if the target directory requires elevated permissions.
4. Verifies the install before exiting.

After installing, add the bin directory to your `PATH` if it isn't already:

```bash
export PATH="/usr/local/bin:$PATH"    # add to ~/.zshrc or ~/.bashrc to persist
```

Verify:

```bash
nool --help
```

### MCP for Coding Agents

`nool-mcp` exposes read-only Nool context to coding agents as MCP tools. The default transport is **stdio**, which is the right mode for local agents because the agent starts and supervises the server process.

```bash
# Smoke test the binary.
nool-mcp --help

# Optional legacy HTTP JSON API for scripts, not streamable HTTP MCP.
nool-mcp --http --port 4000 --db /path/to/repo/nool.db
curl -s http://127.0.0.1:4000/mcp/v1/status
```

Available MCP tools:

| Tool | Purpose |
|---|---|
| `nool_status` | Knot count, DAG heads, and thread names |
| `nool_dag` | Ordered Knot summaries with parent IDs |
| `search_intent` | Search intent history from SQLite FTS, with LanceDB fallback |
| `search_knowledge` | Search saved `nool learn` / `nool findings` knowledge |
| `list_threads` | List intent threads and lifecycle metadata |
| `list_tasks` | List task Knots and current task state |

Use an absolute `--db` path when the agent may start the server outside the repository root.

**Claude Code**

```bash
claude mcp add --transport stdio nool -- /usr/local/bin/nool-mcp --db /path/to/repo/nool.db
claude mcp list
```

For a project-shared `.mcp.json`:

```json
{
  "mcpServers": {
    "nool": {
      "type": "stdio",
      "command": "/usr/local/bin/nool-mcp",
      "args": ["--db", "/path/to/repo/nool.db"]
    }
  }
}
```

**Codex CLI**

Add the same stdio server to `~/.codex/config.toml`:

```toml
[mcp_servers.nool]
command = "/usr/local/bin/nool-mcp"
args = ["--db", "/path/to/repo/nool.db"]
```

Then restart Codex and ask for Nool status or intent search context.

**Cursor**

Create `.cursor/mcp.json` in the project or `~/.cursor/mcp.json` globally:

```json
{
  "mcpServers": {
    "nool": {
      "type": "stdio",
      "command": "/usr/local/bin/nool-mcp",
      "args": ["--db", "/path/to/repo/nool.db"]
    }
  }
}
```

Verify with `cursor-agent mcp list` and `cursor-agent mcp list-tools nool`.

**Windsurf Cascade**

Edit `~/.codeium/windsurf/mcp_config.json`:

```json
{
  "mcpServers": {
    "nool": {
      "command": "/usr/local/bin/nool-mcp",
      "args": ["--db", "/path/to/repo/nool.db"]
    }
  }
}
```

**VS Code / GitHub Copilot Agent Mode**

Create `.vscode/mcp.json`:

```json
{
  "servers": {
    "nool": {
      "type": "stdio",
      "command": "/usr/local/bin/nool-mcp",
      "args": ["--db", "/path/to/repo/nool.db"]
    }
  }
}
```

Start the server from the MCP controls or command palette, then enable the Nool tools in Agent mode.

### Bumping the version

Update `version.txt` with the new semver string. Then update the `version` field in every `crates/*/Cargo.toml` and all inter-crate `version = "…"` references (a workspace-wide `sed` works well). The install script and README header both read from `version.txt`, so a single edit there keeps the installer in sync.

---

## Build & Test

```bash
cargo build               # build all crates
cargo test --workspace    # run all 67+ tests across the workspace
cargo clippy -- -D warnings
cargo fmt --check
```

---

## CLI Reference

Initialize a ledger, then use any of the commands below. All commands operate on `nool.db` in the current directory.

```bash
cargo run -p nool-cli -- <command>
# or, after cargo install:
nool <command>
```

### Lifecycle

| Command | Description |
|---|---|
| `nool init` | Create a new `nool.db` ledger in the current directory |
| `nool propose --intent "<why>" --path <path> [--fast\|--full]` | Generate a candidate Knot; **fast mode** (default, <5s) or **full mode** (30-90s) |
| `nool solidify [--full]` | Cryptographically sign and append the pending Knot |
| `nool tag <name>` | Propose a semantic tag milestone |
| `nool release <version>` | Propose a release version marker |
| `nool pluck <thread>` | Selective Undo: Preview history with a thread removed |
| `nool sync <ssh-url>` | Handshake vector clocks and stream Knots to/from a remote replica |
| `nool bug report --title "<t>" --severity <s> --reproduction "<r>"` | Report a structured bug |
| `nool bisect --good <id> --bad <id> --test "cargo test"` | Binary search for regression |
| `nool validate --all` | Verify quarantined fast-mode Knots |

### Inspection

| Command | Description |
|---|---|
| `nool status [--unstaged]` | DAG heads, Knot count, threads, **semantic unstaged diff** |
| `nool log` | Canonical deterministic replay log |
| `nool replay <ref> [--tui]` | Debug an agent run from a Git ref or `run:<id>` |
| `nool step <n>` | Inspect a replay step's reasoning, context, impact, and flags |
| `nool diff <n>` | Show a colorized diff for a replay step |
| `nool edit <n>` | Add a constraint to a replay step |
| `nool rerun <n>` | Recompute a replay from a selected step |
| `nool blame` | Show replay root-cause summary and suggested fix |
| `nool dag` | ASCII graph of the Knot DAG with HEAD markers |
| `nool why <node_id> [--depth N]` | Full recursive causal chain for a given Knot |
| `nool bug list [--status fixed] [--severity critical]` | List bugs with filters |
| `nool bug show <bug_id>` | Show bug details with fix linkage |

### Runtime Query Interface (Agent-First)

| Command | Description |
|---|---|
| `nool query resolve-intent "<query>" [--thread T] [--limit N]` | Semantic search by intent meaning |
| `nool query neighbors <node_id> [--depth N]` | Causal parents/children of a Knot |
| `nool query recent-knots [--thread T] [--limit N]` | Most recent Knots in the DAG |
| `nool query blast-radius <id1> [id2...]` | Transitive descendants and affected threads |
| `nool query materialize <id1> [id2...] [--mode snippet\|file]` | Reconstruct content from Knots |
| `nool query validate <path1> [path2...]` | Precheck files without proposing |

### Intent Threads

Group Knots into named logical stories — visible to non-developers.

| Command | Description |
|---|---|
| `nool thread create --name "<name>" [--desc "<description>"]` | Create a new intent thread |
| `nool thread list` | List all threads |
| `nool thread show <name>` | Show a thread's metadata and its Knots |

### Discovery

| Command | Description |
|---|---|
| `nool search <query>` | Text search over intent strings and agent rationale |
| `nool changelog [--since <hlc_ms>]` | Markdown changelog grouped by intent thread |
| `nool audit` | Compliance/audit report: authors, counts, risk flags, releases |
| `nool doctor [--json] [--strict] [--fs-only\|--semantic-only] [--artifacts]` | Authoritative release-readiness check across Nool and Git state |

### Release Readiness Doctor

`nool doctor` is the release authority. It combines semantic state from Nool with filesystem hygiene from Git and returns one verdict:

- `RELEASABLE` — semantic state is clean and Git has no unmanaged release risk.
- `RELEASABLE_WITH_WARNINGS` — only safe local noise or non-blocking semantic drift exists.
- `NOT_RELEASABLE` — pending proposals, unmanaged tracked changes, risky artifacts, or release-marker inconsistencies block release.

```bash
nool doctor
nool doctor --json
nool doctor --strict
nool doctor --fs-only
nool doctor --semantic-only
nool doctor --artifacts
```

Exit codes:

| Code | Meaning |
|---|---|
| `0` | `RELEASABLE`, or warnings in non-strict local mode |
| `1` | `RELEASABLE_WITH_WARNINGS` under `--strict` |
| `2` | `NOT_RELEASABLE` |

Example clean output:

```text
Nool Doctor
────────────────────────────────

Semantic State
✔ DAG head is stable
✔ No pending proposals
✔ No active unresolved threads
✔ Latest release marker: v1.16.0

Filesystem State
✔ Git worktree is clean

Verdict
✔ RELEASABLE
```

Example warning output:

```text
Filesystem State
⚠ 1 untracked file(s) are local noise
⚠ 1 untracked file(s)
  - .claude/settings.local.json              (safe local noise)

Verdict
⚠ RELEASABLE_WITH_WARNINGS
```

Example blocking output:

```text
Filesystem State
✖ 1 modified tracked file(s) are not semantically accounted for
⚠ 1 modified tracked file(s)
  - scripts/build.sh                         (release-risking change)

Verdict
✖ NOT_RELEASABLE
```

### Token Ledger & Agent Economics (v1.12.0)

| Command | Description |
|---|---|
| `nool token usage [--agent <key>] [--thread <name>]` | Token consumption per agent or thread |
| `nool token budget-set --agent <key> --limit <n>` | Set per-agent token budget limit |
| `nool token budget-status [--agent <key>]` | Check budget vs actual consumption |
| `nool token analytics --agent <key>` | Cost/line, waste ratio, efficiency |
| `nool agent-report --agent <key>` | Full agent bug report with patterns |
| `nool thread-economics --thread <name>` | Tokens vs bugs vs Knots per thread |
| `nool dashboard` | Combined tokens-per-bug across all threads |

### Console (v1.16.0)

`nool console` opens a browser with:
- **Project Health** — PM-friendly shipping status, latest change, and review focus
- **Command Center** — searchable access to every Nool capability with copyable CLI fallbacks
- **Progressive Disclosure** — plain-language labels first, technical Knot/DAG details on demand
- **Debug Replay** — inspect agent runs with Runs, Timeline, Detail, split diff, edit/rerun, mark critical, and blame actions
- **Async-safe startup** — serves on `http://127.0.0.1:4001` without nested runtime panics
- **Review Inbox** — pending Knots with one-click approve/reject
- **Agent Performance** — efficiency %, waste %, bugs, cost/Knot per agent
- **Token Ledger** — total/accepted/wasted tokens with per-agent breakdown
- **Thread Comparison** — side-by-side economics of two threads
- **DAG Explorer** — visual graph with validation badges
- **Intent Feed** — chronological change log in plain language
- **Task Board** — what's in progress, claimed, done

---

## Example Workflow

```bash
# Start a new project
nool init

# Create a logical story for a feature
nool thread create --name "Auth Refactor" --desc "PCI compliance changes"

# Fast mode (default, <5s) — rapid iteration with deferred validation
nool propose \
  --intent "Remove legacy session middleware" \
  --path "src::auth::middleware" \
  --kind function

# Full mode — complete semantic guarantees (compiler + Aram + tests)
nool propose --full \
  --intent "Remove legacy session middleware" \
  --path "src::auth::middleware" \
  --kind function

# Directory proposal — auto-detects Rust crate, runs cargo check
nool propose --intent "Refactor auth module" --path src/auth/

# Aram Gate passes — sign and append
nool solidify

# Mirror auto-repairs on every operation — no manual git surgery needed

# Check state
nool status
nool status --unstaged          # semantic diff of unstaged changes

# Query the DAG
nool query resolve-intent "middleware" --thread "Auth Refactor"
nool query neighbors a3f8c2b1 --depth 2
nool query blast-radius a3f8c2b1

# Human-readable output for stakeholders
nool changelog
nool audit
```

---

## Formal Verification

All core invariants are verified with **TLA+** (TLC model checker).

### `Nool.tla` — Base protocol

Verifies the D-SSEC core with 2 nodes, up to 4 Knots.

| Invariant | Guarantee |
|---|---|
| `Consistency` | Replicas with identical Knot sets produce identical replay |
| `CausalConsistency` | Parents always precede children in replay |

```bash
tlc Nool.tla -config Nool.cfg -workers auto
# 9,329 states — No errors
```

### `NoolFeatures.tla` — Feature invariants

Verifies all new product features with 2 nodes, up to 3 Knots, up to 2 threads.

| Invariant | Guarantee |
|---|---|
| `Consistency` *(re-checked)* | No regression with threads active |
| `CausalConsistency` *(re-checked)* | No regression with threads active |
| `ThreadIntegrity` | Threads never reference non-existent Knots |
| `ThreadIDUniqueness` | No two thread records share an ID |
| `ThreadKnotReachability` | Every Knot in a thread is known to at least one node |
| `IntentIndexConsistency` | Intent index is always a subset of `knot_pool` |
| `SearchSoundness` | Search results always point to real Knots |
| `ChangelogNoDuplicates` | Canonical replay never emits the same Knot twice |
| `ChangelogValidity` | Changelog never surfaces quarantined (invalid) Knots |
| `AuditAuthorValidity` | Every Knot's author is a known node |
| `AuditNonOverlap` | Per-author counts are disjoint — audit never double-counts |

```bash
tlc NoolFeatures.tla -config NoolFeatures.cfg -workers auto
# 5,047,255 states — No errors
```

---

## Changelog

### v1.16.0 — Reliability, Knowledge Capture & Console Disclosure

- Fixed `solidify --full` so it runs full reification before promoting fast-mode Knots for sync or release.
- Preserved thread links on `propose --solidify`.
- Added bundle attribution roles and structured missing-project-marker diagnostics.
- Added `nool learn` and `nool findings` for searchable knowledge capture.
- Updated the Web Console with PM-friendly project health, searchable Command Center, and progressive technical disclosure.
- Refreshed installer metadata, version files, release binary package, and checksum for the 1.16.0 build.

### v1.15.6 — Release Doctor & Build Refresh

**Release Readiness**
- Added `nool doctor` as the authoritative release-readiness and repository-health command across semantic Nool state, Git-backed filesystem state, and optional artifact checks.
- Added `--json`, `--strict`, `--fs-only`, `--semantic-only`, and `--artifacts` modes for local workflows and CI.
- Added explicit verdicts and exit codes: `RELEASABLE`, `RELEASABLE_WITH_WARNINGS`, and `NOT_RELEASABLE`.
- Updated installer metadata and release artifact version files for the 1.15.6 build.

### v1.15.5 — Agent Debug Replay

**Agent Debug Replay**
- Added `nool replay <ref>` to summarize an agent run from a Git ref or stored `run:<id>` as prompt/read/plan/write/tool steps.
- Added `nool step <n>`, `nool diff <n>`, `nool edit <n>`, `nool rerun <n>`, and `nool blame` for fast terminal debugging.
- Added `nool replay --tui` for a compact terminal replay layout with steps, details, and diff panel.
- Added a Debug Replay console workspace with Runs, Timeline, and Detail panels, split diff view, edit constraint modal, rerun, mark critical, and blame actions.

**Correctness**
- Tightened semantic search fallback so vector neighbors must still have a lexical anchor when SQLite FTS returns no direct matches, preventing unrelated intent false positives.

**Release Notes**
- Existing ledgers are forward-compatible; ADR stores replay metadata under `.nool/adr/` when a run is replayed.
- No migration is required.

### v1.15.4 — Security & Correctness Hardening

**Security**
- `nool-core`: Signature verification is now unconditional — the `is_valid` shortcut that allowed bypass via a manually constructed `Knot` struct is removed.
- `nool-aram`: Agent contract enforcement now denies mutations when no active contract matches the author. Previously `_found_contract` was set but never checked, allowing unconstrained editor/planner work.
- `nool-aram`: Removed host filesystem I/O from the Aram gate (TLA+ spec path check violated the gate-purity invariant; enforcement moved to the `tla-spec-required` WASM policy).
- `nool-transport`: X3DH handshake now performs all three required DH operations (DH1: identity↔SPK, DH2: ephemeral↔IK, DH3: ephemeral↔SPK) so compromise of the signed prekey alone cannot recover the session key.
- `nool-transport`: Symmetric ratchet now uses domain-separated KDF for message key vs. chain key advancement. Previously the chain key itself was used as the encryption key with no separation.
- `nool-transport`: Added `u32::MAX` counter overflow guard before encrypt to prevent AES-GCM nonce reuse.
- `nool-hub`: Timestamp validation now rejects future-dated requests (`timestamp - now > 60s`). Previously `saturating_sub` silently passed any future timestamp, enabling pre-signed replay attacks.

**Correctness**
- `nool-core`: `Knot::calculate_id` now hashes the payload in addition to the header. Two Knots with identical metadata but different payloads previously produced the same ID, causing silent discard on insert.
- `nool-core`: `Ord` for `Knot` now correctly implements the three-tier comparator (vector clock sum → HLC → knot_id) per spec §3.1. Previously the vector clock step was skipped entirely.
- `nool-core`: Cycle detection in `replay()` no longer calls `panic!`; the error is logged and the cycle is skipped.
- `nool-core`: `check_concurrency_conflict` no longer calls `self.replay()` (O(N log N)) — it iterates `self.knots.values()` directly.
- `nool-core`: `run_bundled_reification` now bounds-checks `primary_index` before indexing `bundle.files`.
- `nool-memory`: Vector search now explicitly uses `DistanceType::Cosine` and embeddings are L2-normalized. Previously the default L2 distance metric made the `1.0 - similarity_threshold` cutoff meaningless.
- `nool-storage`: `row_to_token_entry` now validates blob lengths before `copy_from_slice` (panicking on corrupt data).
- `nool-storage`: `find_knot_by_partial_id` returns a distinct error for ambiguous prefixes instead of reusing `QueryReturnedNoRows`.
- `nool-storage`: `get_bugs_introduced_by_agent` now fetches the agent's knot IDs once outside the loop (was O(N) queries).

**Infrastructure**
- `nool-aram-policy-sdk`: `alloc` on non-WASM targets now returns the arena byte offset, not a host virtual address.
- `nool-ast`: `ConfigurableLanguageAdapter` and `WasmLanguageAdapter` no longer leak a new allocation on every call to `extensions()`. Extension strings are now computed once at construction time.
- `nool-ast`: `WasmLanguageAdapter` uses `alloc` to obtain a proper linear-memory buffer before calling `name`/`extensions`, instead of assuming address 0 is safe scratch space.
- `nool-hub`: `SubscriptionStore` is now a single shared `Arc<Mutex<…>>` in `AppState` (opened once at startup with WAL mode and `busy_timeout=5000ms`). Previously each request handler opened its own connection, causing `SQLITE_BUSY` under concurrent load.