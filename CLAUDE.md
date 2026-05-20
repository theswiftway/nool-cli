# Nool CLI Project Guide

**Project**: Nool Operational Continuity Infrastructure  
**Current Version**: v2.2.1 — Semantic Planning (RFC-0001), Algebraic DAG, and Structural Verification.  
**Repository Type**: Nool-managed  
**MCP Server**: Nool MCP (nool-mcp) — installed locally

## 📚 Documentation

### Quick References
- **[Skills.md](./Skills.md)** — Complete reference for all 50+ nool commands
  - 20 organized sections
  - 110+ command documentation entries
  - Usage examples and best practices
  - Workflow examples for common tasks

- **[README.md](./README.md)** — User guide and installation instructions
  - Core concepts and terminology
  - Prompting patterns for agents
  - Multi-agent collaboration workflows
  - Language support and plugin system
  - **New in v2.0.0**: Semantic Planning Engine (RFC-0001)

- **[skills/nool-commands/SKILL.md](./skills/nool-commands/SKILL.md)** — Agent-optimized skill reference
  - Quick lookup format
  - All command syntax at a glance

### For Agents
When working in this project, refer to:
1. **Skills.md** for detailed command documentation
2. **SKILL.md** for quick syntax lookup
3. Run `nool --help` for real-time command reference
4. Run `nool quick-start` for interactive guidance

---

## ✨ v2.0.0 Features: Semantic Planning & Verification

### Semantic Planning Engine (RFC-0001)
```bash
# Plan a selective undo of a thread
nool plan pluck "Feature Thread"

# Replay operations to reach a target state
nool plan replay --target <knot_id>

# Execute a plan
nool apply --plan-id <plan_id>
```

### Structural Verification (RFC-0002)
```bash
# Run structural invariants
nool verify --target <knot_id>
```

### Semantic Explainability (RFC-0006)
```bash
# Explain an identity or failure
nool explain <knot_id>
```

### Interactive Review Surface (RFC-0008)
```bash
# Review candidate changes
nool review <plan_id>
```

---

## ✨ v1.33.0 Features: Collaboration & Diagnostics

### Persona-Aware CLI
```bash
# Set persona for the session
nool --persona agent <command>

# Or use environment variable
export NOOL_PERSONA=agent
```
- **developer**: Standard interactive mode with rich formatting.
- **user**: Simplified interface focusing on high-level results.
- **agent**: Token-optimized, machine-readable, high-density output.

### Discovery & Multi-Agent Coordination
**Intent Announcement**
```bash
nool announce --intent "Refactoring auth module" --thread "Security"
```
- Alerts other agents/developers to active work.
- Automatically captures surrounding context.

**Knowledge Retrieval**
```bash
nool learn --kind reasoning_note --content "Using B-trees for the index because..."
nool findings --file src/db.rs
```
- Persist and retrieve architectural decisions and findings directly in the DAG.

**Discovery Tools**
```bash
nool discover conflicts  # Show potential semantic conflicts
nool discover context    # Suggest relevant knots/files for current work
```

### Advanced Diagnostics
**Topology & Health**
```bash
nool status --topology  # Visualize replica mesh and sync health

```

---

## ✨ v1.27.0 Features: Scale Optimizations

### Memory-Bounded Operations

**Pagination for Large Repositories**
```bash
# Load only what you need — memory bounded by page size
nool log --skip 100 --limit 50
nool dag --skip 0 --limit 100
```
- Scales efficiently to 10k+ knots
- No memory bloat regardless of DAG size
- Use case: Browsing history in large repos

**On-Demand Causal Chains**
```bash
nool why <knot-id>  # Fetches ancestors as needed
nool why <knot-id> --depth 5
```
- Memory scales with chain depth (typically 5-10 knots), not repository size
- Faster startup than full DAG load
- Efficient for understanding change impact

**Optimized Bisect**
```bash
nool debug bisect --good <knot> --bad <knot> --test "make test"
```
- Only loads knots in the timestamp range between good and bad
- Saves memory when bisecting large ranges

### Performance Improvements

**Short ID Resolution**
- Added index on 8-char knot_id prefix
- Lookups now O(log n) instead of O(n) table scan
- Transparent improvement to all commands using short IDs

**Git Mirror Consolidation**
- New repos automatically use host git repository
- ~50% disk savings on new installations
- `nool init` auto-detects existing `.git` and consolidates

### Schema Enhancements

**Richer Metadata Tracking**
- `breaking_change`: Flag for breaking API changes
- `related_issues`: Link to tracking system (Jira, GitHub)
- `test_note`: Document test coverage for change
- `metadata_tags`: Arbitrary tags for categorization

Use with:
```bash
nool propose --intent "..." --breaking --issue "#123" --test-note "Added tests for X" --tag "critical"
```

---

## 🔄 Session Rehydration

When working across multiple agent sessions, use Nool's built-in mechanisms to recover context and continue work seamlessly.

### Quick Rehydration (5 minutes)

```bash
# 1. Get status overview
nool status

# 2. See what changed recently
nool query recent-knots --limit 10

# 3. Rehydrate task context
nool discover context
nool discover learnings

# 4. Review findings from prior work
nool findings "your topic or file"
```

### Full Context Recovery

```bash
# 1. Understand the full history
nool log --since "1 week ago"

# 2. Get context from a specific thread
nool discover context --thread "Feature Name"
nool discover learnings --thread "Feature Name"

# 3. Review related work
nool discover similar "search term"

# 4. Check for conflicts before starting
nool discover conflicts

# 5. Pull latest from remote
nool pull origin

# 6. Inspect decision history (recursive search v1.33.0)
nool query search "decision made"
```

### Recovering Work from a Specific Change

```bash
# 1. Find the knot you were working on
nool query recent-knots

# 2. Understand its causal chain
nool why <knot_id>

# 3. See what depends on it
nool query blast-radius <knot_id>

# 4. Trace root cause (v1.33.0 hardened)
nool debug blame <failure_point>

# 5. Review the actual changes (Synthesis knots v1.33.0)
nool query materialize <knot_id>
```

### Recovering from Recorded Learnings

```bash
# Find learnings from previous sessions
nool findings "topic you worked on"

# Filter by kind
nool findings "root_cause issues in payment"
nool findings "dependency insights"
nool findings "reasoning notes"

# Get structured JSON output
nool findings "your topic" --json

# Limit results
nool findings "your topic" --limit 20
```

### Key Commands for Rehydration

| Command | Purpose | Recovery Type |
|---------|---------|---------------|
| `nool status` | Quick overview | Immediate |
| `nool log` | Full history | Deep dive |
| `nool query recent-knots` | Recent changes | Quick catch-up |
| `nool discover context --thread X` | Thread decisions | Specific work |
| `nool discover learnings --thread X` | Thread insights | Knowledge base |
| `nool discover similar "topic"` | Related work | Pattern discovery |
| `nool findings "query"` | Recorded knowledge | Context documents |
| `nool why <id>` | Causal chain | Understanding impact |
| `nool query blast-radius <id>` | Downstream effects | Risk assessment |
| `nool dag` | Visual structure | Architecture view |

### Best Practices for Easy Rehydration

1. **Write Detailed Intents**
   ```bash
   # Good: Clear, searchable intent
   nool propose --intent "Add JWT validation to prevent token replay attacks" --path src/auth/jwt.rs
   
   # Better: Include why and approach
   nool propose --intent "Add JWT exp claim validation (CVE-2024-xxxxx) using RS256 key rotation" ...
   ```

2. **Use Threads for Related Work**
   ```bash
   # Organize by feature/epic
   nool thread create "Payment v3 Integration"
   nool propose --thread "Payment v3 Integration" --intent "Add Stripe webhook signature verification"
   ```

3. **Capture Learnings After Key Changes**
   ```bash
   # Record discoveries
   nool learn --about "JWT validation" --kind discovery --content "Token expiration check must happen before signature validation to prevent DOS"
   
   # Record decisions
   nool learn --about "error handling" --kind reasoning_note --content "Chose Result<T> over exceptions for deterministic error handling"
   
   # Document dependencies
   nool learn --about "redis connection" --kind dependency_insight --content "Session validation depends on Redis being available - need fallback"
   ```

4. **Use Announcements for Complex Work**
   ```bash
   # Announce with full context
   nool announce with-context "Refactoring auth module" \
     --decisions "Use OIDC for SSO, JWT for API auth" \
     --constraints "Must not break existing OAuth2 clients"
   ```

### Example: Full Rehydration Workflow

```bash
# START NEW SESSION
echo "=== Session Rehydration ==="

# 1. Status check (30 seconds)
nool status

# 2. Recent activity (1 minute)
nool query recent-knots --limit 15

# 3. Your threads (30 seconds)
nool thread list

# 4. Pending work (1 minute)
nool task inbox
nool task mine

# 5. Pull latest (1 minute)
nool pull origin

# 6. Check for conflicts (30 seconds)
nool discover conflicts

# 7. Get context for specific thread (2 minutes)
THREAD="Feature: User Analytics"
nool discover context --thread "$THREAD"
nool discover learnings --thread "$THREAD"

# 8. Review learnings from past week (2 minutes)
nool findings "user analytics" --limit 20

# 9. Find similar past work (1 minute)
nool discover similar "analytics dashboard"

# 10. Visual understanding (1 minute)
nool dag

# READY TO CONTINUE WORK!
echo "=== Ready to resume work ==="
```

---

## 🚀 Getting Started

### Prerequisites
```bash
# Verify nool is installed
nool version

# Should output: Nool v1.33.0 or later
```

### Project Setup
This project is already Nool-enabled. The `.nool` directory contains:
- Knot DAG (semantic change history)
- Intent Index (searchable rationale)
- Local identity keys (Ed25519 keypair)

### First Steps
1. **Check project status**
   ```bash
   nool status
   ```
   
2. **View the DAG**
   ```bash
   nool dag
   ```

3. **See recent changes**
   ```bash
   nool log | head -20
   ```

---

## 📋 Common Workflows

### Updating Documentation (This Project)

```bash
# 1. Check what changed
nool status

# 2. Make changes to .md files
# (edit Skills.md, README.md, etc.)

# 3. Propose the changes with clear intent
nool propose \
  --intent "Update Skills.md with new command documentation" \
  --path Skills.md \
  --thread "Documentation"

# 4. Review before finalizing
nool solidify --full

# 5. Sync with remote
nool push origin
```

### Creating Features or Fixes

```bash
# 1. Create a thread for organized work
nool thread create "Feature: Async command support"

# 2. Propose semantic changes
nool propose \
  --intent "Add async flag to propose command" \
  --path src/propose/main.rs \
  --thread "Feature: Async command support" \
  --fast

# 3. Iterate quickly with fast mode
nool solidify --fast

# 4. Full validation before push
nool solidify --full

# 5. Verify no regressions
nool doctor

# 6. Push to remote
nool push origin

# 7. Generate changelog
nool changelog --thread "Feature: Async command support"
```

### Debugging Issues

```bash
# Find what changed recently
nool query recent-knots

# Search for related work
nool query search "command validation"

# Understand impact of a change
nool query blast-radius <knot_id>

# Trace root cause
nool debug blame <failure_point>

# Binary search for regression
nool debug bisect --broken <broken_knot> --good <known_good_knot>

# Walk causal chain
nool why <knot_id>
```

### Recording Learnings

```bash
# Document findings
nool learn \
  --about "command parsing" \
  --kind discovery \
  --content "Lazy evaluation prevents circular imports in plugin system"

# Query later
nool findings "command parsing"
```

### Multi-Agent Collaboration

```bash
# Before starting work, check for conflicts
nool discover conflicts

# Retrieve context from previous work
nool discover context --thread "Payment Integration"

# Announce what you're about to do
nool announce with-context \
  "Refactoring error handling" \
  --decisions "Use Result<T> pattern throughout" \
  --constraints "Must maintain backward compatibility"

# Stay in sync
nool pull origin
nool push origin
```

---

## 🔧 Project Configuration

### Allowed Nool Commands (see .claude/settings.local.json)

All major nool commands are pre-authorized:
- ✅ `nool propose` — Create change proposals
- ✅ `nool solidify` — Commit to DAG
- ✅ `nool query` — Semantic queries
- ✅ `nool thread` — Manage threads
- ✅ `nool task` — Task management
- ✅ `nool bug` — Bug tracking
- ✅ `nool bridge` — Git integration
- ✅ `nool try` — Ephemeral branches
- ✅ `nool discover` — Context discovery
- ✅ `nool learn` — Knowledge capture
- ✅ `nool debug` — Debugging tools
- ✅ `nool announce` — Multi-agent coordination
- ✅ `nool findings` — Query learnings

- ✅ `nool admin` — Admin operations

### Development Workflow

**For active coding:**
```bash
nool propose --fast    # Quick iterations (<5s)
nool solidify --fast   # Fast commits
```

**Before pushing:**
```bash
nool solidify --full   # Full validation
nool doctor            # Health check
nool push origin       # Replicate changes
```

---

## 📊 Repository State

### Current Version
- **Nool**: v1.33.0
- **Last Updated**: May 14, 2026
- **Commands Documented**: 46+ with 90+ subcommands

### Key Directories
- `./Skills.md` — Complete command documentation (1,276 lines)
- `./README.md` — User guide and installation
- `./skills/nool-commands/` — Skill files for agents
- `./.nool/` — Nool ledger (DO NOT EDIT MANUALLY)

### Git Bridge
- Bifrost Bridge connects Nool DAG to Git commits
- Run `nool bridge status` to check sync state
- Changes are automatically mirrored to `origin`

---

## 🎯 Agent Guidelines

### Before Making Changes

1. **Understand context**
   ```bash
   nool status                    # Current state
   nool query recent-knots        # Recent changes
   nool query blast-radius <id>   # Impact analysis
   ```

2. **Check for conflicts**
   ```bash
   nool discover conflicts
   nool pull origin              # Get latest
   ```

3. **Plan semantically**
   - Group related changes into one Knot
   - Write clear intent statements (they're the "why")
   - Use threads for features/epics

### Making Changes

1. **Propose with intent**
   ```bash
   nool propose --intent "<clear reason>" --path <file>
   ```

2. **Review before solidifying**
   ```bash
   nool solidify --full  # Full validation
   nool doctor           # Health check
   ```

3. **Document learnings**
   ```bash
   nool learn --about "<topic>" --kind discovery --content "<insight>"
   ```

### After Changes

1. **Verify quality**
   ```bash
   nool doctor --fix     # Auto-repair if needed
   nool validate         # Validate fast-mode Knots
   ```

2. **Communicate**
   ```bash
   nool thread chat "Thread Name"  # Discussion
   nool msg agent_name "Summary"   # Direct message
   ```

3. **Push to remote**
   ```bash
   nool push origin
   nool bridge status     # Verify sync
   ```

---

## 🆘 Troubleshooting

### Commands Not Recognized
```bash
# Verify installation
nool version

# Check available commands
nool --help

# Interactive guide
nool quick-start
```

### Diverged DAG State
```bash
# Health check
nool doctor

# Auto-repair
nool doctor --fix

# Full sync
nool pull origin
nool validate
```

### Need to Undo Changes
```bash
# Preview without a thread
nool pluck "Thread Name"

# Inspect causal chain
nool why <knot_id>

# Binary search for regression
nool debug bisect --broken <broken> --good <good>
```

---

## 📞 References

- **Nool Tutorial**: https://knot-agent-vision.lovable.app/learn
- **Full Command Reference**: See [Skills.md](./Skills.md)
- **Quick Reference**: Run `nool guide`
- **Real-time Help**: `nool --help` or `nool <command> --help`

---

## Notes for Agents

- **Always use nool for version control in this project** — Don't use `git commit` directly
- **Document your intent** — The intent string becomes searchable history
- **Use threads for organization** — Group related changes semantically
- **Verify before push** — Run `nool solidify --full` before `nool push`
- **Record learnings** — Use `nool learn` to help future work
- **Check blast radius** — Use `nool query blast-radius` for impact analysis
- **Reference the documentation** — Skills.md has 90+ documented commands

---

*Last updated: May 14, 2026 for Nool v1.33.0*
: May 14, 2026 for Nool v1.33.0*
