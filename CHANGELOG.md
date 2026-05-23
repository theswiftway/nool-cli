# Changelog

All notable changes to Nool are documented in this file.

## [Unreleased]

## [2.3.5] - 2026-05-22

### Added
- **Manual Plugin & Policy Management**:
  - Added `nool admin plugin install <path> [--policy]` to allow manual installation of WASM plugins and policies.
  - Added `nool admin plugin uninstall <name> [--policy]` to allow manual uninstallation.
  - Added `nool admin plugin list` to view all active governance and language plugins.
- **Multi-Stage Lifecycle Hooks**:
  - Implemented `PrePropose`, `PostPropose`, `PreSolidify`, and `PrePush` stages in the Aram governance substrate.
  - Aram policies now receive the current `LifecycleStage` via the updated WIT interface.
  - Added **Installation Hints**: Automated hints for missing hook-required policies.
- **Agent Persona Hardening**:
  - `nool propose` now supports non-blocking **Agent Auto-Justification** when blast-radius warnings are triggered.
  - Added `--justification` flag for manual causal reasoning during proposals.
  - Improved persona prioritization from `nool.toml`.

## [2.2.4] - 2026-05-21

### Added
- **Source-Derived Thread Summaries**:
  - `nool thread show <name> --full` now includes touched paths, directory footprint, AST-aware public API hints, and dependency signals.
  - Added **Internal Dependency Map** to visualize relationships between files touched within a thread.
  - Added **Transitive Dependency Closure** (via `ImpactAnalyzer`) to identify contextually related files outside the current thread.
  - Upgraded `ImpactAnalyzer` with language-specific resolution heuristics (Rust crates, group imports, naming conventions).
- **Git Index Escape Hatch**:
  - Added `nool untrack <path>...` as the Nool-native replacement for `git rm --cached`.
- **Binary Size Optimization**:
  - Implemented aggressive size reduction strategy: Fat LTO, single codegen units, size-optimized levels ('z'), and abort-on-panic behavior.
  - Pruned heavy dependency features in `tokio`, `wasmtime`, `lancedb`, and `async-stripe`.
  - Binary size reduced from 166MB to ~115MB.
- **Multi-Platform Release Support**:
  - Enhanced release scripts with cross-platform `sed` compatibility and support for multiple Rust targets.
  - Automated packaging for macOS, Linux, and Windows with SHA256 checksum generation.

### Changed
- **Proposal Ergonomics**:
  - Added `nool propose --all` to stage modified, deleted, staged, and untracked Git worktree paths without repeating `--path`.

## [1.31.0] - 2026-05-11

### Added
- **Auto-Sync Background Daemon**:
  - `nool bridge watch` now spawns a detached background process for continuous replication.
- **Ephemeral Branching (nool try)**:
  - Verified and stabilized `nool try` for safe, isolated experimentation.
