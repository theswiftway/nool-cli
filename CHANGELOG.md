# Changelog

All notable changes to Nool are documented in this file.

## [1.33.0] - 2026-05-15

### Added
- **Invisible Bridge (Daemonized Sync)**: Introduced `nool-daemon` for background Git-to-Nool synchronization. Native Git Flow support ensures branches and merges are automatically tracked in the semantic DAG.
- **Interactive TUI Explorer**: Added `nool ui` for visual DAG navigation, providing real-time causal graph rendering and high-density TOON metadata introspection.
- **Self-Healing Storage**: Implemented an asynchronous Background Reconciliation Loop and SQLite Triggers to autonomously repair referential drift and database corruption.
- **TOON Metadata Engine**: Adopted Token-Oriented Object Notation (TOON) for all internal manifests and metadata, reducing agent context rehydration costs by 30-50%.
- **Metabolic Resource GC**: Automated cleanup of reification scratchpads via `nool admin gc` to prevent ENOSPC deadlocks.
- **Adaptive Compression**: Integrated automatic Zstd dictionary training into the solidification pipeline for improved storage efficiency (~20%).
- **Agent Handoff Protocol**: Formally codified responsibility transfers via `nool thread handoff` with signed decision/roadmap metadata.

### Changed
- **CLI Robustness**: Moved CLI argument validation from runtime to build-time using debug assertions.
- **Short-Flag De-collision**: Reassigned conflicting short flags across the entire command suite (e.g., `target-nodes` now `-k`).
- **High-Fidelity Storage Results**: Standardized all storage operations on high-fidelity error types with detailed failure context.

### Fixed
- **SQLite FK Contention**: Resolved foreign key constraint violations during complex knot pruning and reconciliation.
- **Robust Deserialization**: The replay engine now gracefully handles and prunes individual corrupted BLOBs without failing the session.

## [1.31.1] - 2026-05-14

### Added
- **Synthesis Multi-File Knots**: Complete support for multi-file proposals and solidifications, ensuring full VCS snapshots within the Knot DAG.
- **Jira Platform Integration**: Automated Jira task completion sync with dynamic transition discovery based on project workflows.
- **Recursive Semantic Search**: Enhanced `nool query` with recursive search capabilities over the semantic code graph.

### Changed
- **Harden Nool 0.6.0 Core**: Unified synchronization logic, introduced causal-aware `doctor` diagnostics, and implemented persistent orphan quarantine for improved repository health.
- **Intent Architecture**: Refactored `IntentRecord` to a structured format, improving type safety and internal metadata handling.
- **Git Bridge**: Updated Git integration specifications and handling for historical knots.

### Fixed
- **Async Compilation**: Resolved compilation errors in Axum handlers by ensuring `Ledger` references are correctly handled across await points.
- **Dead-code Cleanup**: Final architectural refinement and removal of legacy code remnants for the 1.31.x series.

## [1.31.0] - 2026-05-11

### Added
- **Auto-Sync Background Daemon**:
  - `nool bridge watch` now spawns a detached background process for continuous replication.
  - Robust lifecycle management with `.nool/sync.pid` and graceful shutdown (SIGTERM/SIGINT) support.
  - Log redirection to `.nool/sync.log` for troubleshooting background sync operations.
- **Ephemeral Branching (nool try)**:
  - Verified and stabilized `nool try` for safe, isolated experimentation.
  - Added support for `nool try promote <name>` to merge ephemeral experiments into the canonical DAG.
- **Multi-Agent Coordination (Tier 2)**:
  - **Conflict Discovery in Propose**: The `nool propose` command now automatically checks for overlapping intents from other agents and prints prominent warnings.
  - **Aram Coordination Enforcement**: Integrated conflict checking into the Aram Gate. Solidification of knots that conflict with active announcements from other agents is now blocked by policy (Reason Code 409).
  - **Coordination Feature Flag**: Added `coordination.enabled` to `nool.toml` to allow toggling of multi-agent coordination features.
- **Context Rehydration System**:
  - Full infrastructure for capturing and persisting rich agent context (decisions, failures, constraints).
  - Knowledge base support with full-text search for project-wide learnings via `nool learn` and `nool findings`.

### Changed
- **Orphan-Resilient Pulling**:
  - Refactored `nool pull` to use the Bifrost bridge instead of raw git commands.
  - Implemented topological sorting of incoming knots by HLC timestamp to respect SQLite FK constraints.
  - Enhanced DAG integrity logic to filter already-known knots, preventing historical orphans from blocking new pulls.
- **Async Safety**: Wrapped synchronous Git and Ledger operations in `spawn_blocking` to protect the Tokio executor.
- **Clean Build**: Eliminated all compiler warnings (unused variables, imports, and functions) across `nool-storage`, `nool-cli`, and `nool-bridge`.
- **Aram Gate Signature**: Updated `validate` and `validate_detailed` to support active announcement tracking.
- **Improved Validation**: Fast Path validation now incorporates more robust ecosystem-aware reification logic.

## [1.30.0] - 2026-05-10

### Added
- **Active Thread System**: Introduced persistent active threads. Set your workspace context with `nool thread active <name>` and commands like `propose` and `announce` will automatically use it.
- **Auto-Alignment for Multi-Agent Coordination**: Multi-agent coordination (`nool announce`, `nool discover`) is now thread-aware, ensuring decentralized teams stay synchronized within the same work context.

### Changed
- **Excised Resource Constraints**: Removed `gas_limit` and fuel metering from core validation logic. Tracking complexity and runtime overhead were identified as prohibitive.
- **Full Economic Excision**: Deleted the token analytics engine, removed token-related data models (`TokenLedgerEntry`, `TokenOperation`), and purged legacy token-budgeting references from the CLI and web console.
- **Knot-Based Quota Enforcement**: Transitioned to a robust 1,000-knot threshold for free tier users, strictly enforced at the proposal and solidification layers.
- **Configuration Cleanup**: Removed `[billing]` section requirements and made it optional; added `[cli]` section for persistent workspace state.

## [1.29.4] - 2026-05-10

### Changed
- **Documentation Alignment**: Updated documentation to remove references to agent economics and token budgeting.

## [1.29.3] - 2026-05-09
