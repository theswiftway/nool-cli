# Nool User Guide: Semantic-Agentic Version Control

**Current Version**: v1.24.0 — This guide documents the latest stable release. Feature sections note when they were introduced; all features listed below are available in v1.18.0 and later.

Nool is not just a replacement for Git — it is a shift from tracking **lines of text** to tracking **semantic logic and intent**. This guide covers what you can do with Nool, who it is for, and how it differs from traditional version control.

---

## Steps to install

```bash
./install_tar.sh nool-1.24.0-release.tar.gz
```
Add SKILL.md file to appropriate location for your agent.
```
~/.agents/skills/nool-commands/SKILL.md
~/.claude/skills/nool-commands/SKILL.md
```
## Prompting Your Agent to Use Nool

The key to effective Nool usage is framing tasks so the agent understands **what to track, when to validate, and how to reason about impact**. Here are proven prompt patterns:

### System Prompt Addition

Add this to your agent's system prompt or `.claude.md`:

```
You are a Nool-powered agent. Before every change:
1. Run `nool status` to understand current state
2. Use `nool dag` to see the causal graph
3. Propose changes with `nool propose --fast --intent "<why>" --path <file>`

After changes:
1. Run `nool solidify --fast` for local iteration
2. Use `nool solidify --full` before pushing
3. Always explain what you changed and why using `nool log`
```

### Task-Specific Prompts

#### Refactoring Task
```
Refactor the authentication module in src/auth/. Before touching any file:
1. Run `nool query recent-knots --thread "Auth"` to see recent changes
2. Pick a function and run `nool query blast-radius <node_id>` to understand its dependencies
3. Propose changes using `nool propose --intent "Simplify token validation" --path src/auth/tokens.rs --kind function`
4. Solidify only after reviewing what Nool's integrity driver reports
```

#### Bug Fix Task
```
Fix the memory leak in the connection pool:
1. Use `nool query search "connection pool"` to find related changes
2. Create a thread: `nool thread create "Fix Memory Leak Q2"`
3. Propose the fix with `nool propose --intent "Close connections in finally block" --path db/pool.rs --kind function --thread "Fix Memory Leak Q2"`
4. Link to any related bug: `nool bug list --status open`
```

#### Feature Development Task
```
Build the new payment webhook handler:
1. Create a thread: `nool thread create "Stripe Webhooks v2"`
2. Break work into semantic knots:
   - `nool propose --intent "Add webhook signature verification" --path src/webhooks/stripe.rs --kind function --thread "Stripe Webhooks v2"`
   - `nool propose --intent "Parse payment events" --path src/webhooks/payment.rs --kind function --thread "Stripe Webhooks v2"`
3. Use `nool query materialize` to review completed work
4. Generate changelog: `nool changelog --thread "Stripe Webhooks v2"`
```

### Multi-Agent Collaboration Prompt

```
You are the UI agent. Your backend counterpart is working in a separate thread.

1. Sync state: `nool sync origin && nool pull`
2. Check what changed: `nool dag` or `nool query recent-knots`
3. Before API changes: `nool query neighbors <api_knot_id>` to see what's affected
4. Communicate via thread: `nool thread chat "Payment Feature"` to coordinate
```

### Review & Rollback Prompt

```
Review recent changes:
1. Run `nool log | head -20` to see what was done
2. For each knot: `nool why <id>` to understand causality
3. If issues found: `nool pluck "Thread Name"` to preview without the problematic changes

Before merging to main:
1. `nool doctor` - check health
2. `nool validate` - validate fast-mode knots
3. `nool solidify --full` - full validation
```

### Emergency Response Prompt

```
Something broke in production. Trace the issue:
1. `nool query search "production bug"` - find related knots
2. `nool bug investigate <id>` - mark as investigating
3. `nool query blast-radius <problematic_knot_id>` - find what else was affected
4. `nool git log` - compare with git history
5. `nool audit` - full compliance report for post-mortem
```

## Tutorial
Click here to learn how to use it. [Nool Tutorial](https://knot-agent-vision.lovable.app/learn)

## Who Is Nool For?

Nool is designed for everyone who touches software — not just engineers.

| Persona | What Nool gives you |
|---|---|
| **Developer** | Semantic mutations, stable NodeIDs across refactors, intent-linked history, offline-first CRDT sync |
| **Product Manager** | Intent Threads that tell the story of a feature; Changelog in plain language |
| **Designer / Writer** | Searchable history by meaning, not SHA; Approval Workflows on intent threads |
| **Legal / Compliance** | Signed audit trail: who changed what, when, and why — exportable as a report |
| **AI Agent** | MCP server for context rehydration; intent_ref links every mutation to its rationale |

---

## Core Concepts

### Knot — The Atomic Mutation
A `Knot` is the fundamental unit of change. It is not a diff of lines; it is a cryptographically signed semantic mutation of an AST node. Every Knot carries:
- A `KnotHeader` with its Blake3 self-hash, parent DAG edges, HLC timestamp, vector clock, and commutativity class.
- A `SemanticTransform` payload — a `Mutation`, `Tag`, `Release`, or `Raw` operation.
- An Ed25519 signature from the author.
- An optional `intent_ref` pointing to a record in the Intent Index.

### Intent Thread — The Logical Story
Knots are grouped into named **Intent Threads** — e.g. "Auth Refactor Q2" or "Fix Payment Edge Case". Threads are the product-facing unit of work. They drive the Changelog, enable Approval Workflows, and give non-developers a navigable view of history.

### Intent Index — The Why
The `LanceDBIndex` stores the human/agent rationale behind each Knot as a searchable record. The `nool search` command queries this index by text. Future versions support vector similarity search for semantic queries like "find all changes that touched authentication after the PCI audit."

### Knot DAG — The Source of Truth
Knots form a Directed Acyclic Graph. The canonical replay order is: Vector Clock → HLC Timestamp → Knot ID. Every replica sorts identically — this is the D-SSEC guarantee, formally verified in TLA+.

### Polyglot Support
Nool includes built-in language identification for over 30 languages and formats. This includes:
- **Programming Languages**: Rust, Python, JS/TS, Go, C++, Ruby, Erlang, Elixir, Clojure, and more.
- **Configuration & Markup**: JSON, TOML, YAML, XML, HTML, CSS, Markdown.

#### Custom Language Support (Plugins)
If your language is not supported out of the box, you can add support via **Language Plugins** or **Simple Configurations**.

##### 1. Simple Configurations (`nool.toml`)
For languages that only require basic comment-stripping for stable NodeID calculation, you can define them directly in your `nool.toml` file:

```toml
[[languages]]
name = "my-simple-lang"
extensions = ["msl", "simple"]
comment_prefixes = ["//", "--"]
```

Nool will automatically use these rules for the specified extensions. These configurations are also embedded into **Release** Knots, ensuring that any replica replaying your history uses the correct language rules.

##### 2. Language Plugins (WASM)
For more complex languages requiring custom normalization or syntax validation, use the WASM-based plugin system.

1.  **Create a Plugin**: Use the `nool-language-sdk` to write a new adapter in Rust.
    ```rust
    use nool_language_sdk::{language_plugin, LanguageAdapter, Hash256};

    #[derive(Default)]
    struct MyLangAdapter;

    impl LanguageAdapter for MyLangAdapter {
        fn name(&self) -> &str { "my-lang" }
        fn extensions(&self) -> Vec<String> { vec!["mylang".to_string()] }
        fn calculate_id(&self, parent_id: Option<Hash256>, kind: &str, semantic_path: &str, content: &str) -> Hash256 {
            // Your custom stable NodeID calculation logic
            blake3::hash(content.as_bytes()).into()
        }
    }

    language_plugin!(MyLangAdapter);
    ```
2.  **Build to WASM**:
    ```bash
    cargo build --target wasm32-unknown-unknown --release
    ```
3.  **Install**: Copy the `.wasm` file to your project's `plugins/` directory.
    ```bash
    mkdir -p plugins
    cp target/wasm32-unknown-unknown/release/my_lang.wasm plugins/
    ```
4.  **Verify**: Nool will automatically load the plugin and use it for files with the matching extension.
    ```bash
    nool propose --path test.mylang --full
    ```

This ensures that semantic mutations and Stable NodeIDs are calculated with language-specific awareness across diverse codebases.

### Speculative Reification: The "Verified Runnable" Guarantee
Unlike Git, which accepts any text as a commit, Nool performs **Speculative Reification** before a Knot can be solidified. 
- **Shadow-Root Construction**: On `nool propose`, Nool creates a transient "Scratchpad Workspace" in `.nool/tmp/reify` using Git worktrees. This allows for lightning-fast (<200ms) materialization of your project's state without copying heavy dependencies.
- **The Integrity Driver**: Nool identifies the file extension and executes the appropriate language-native check (e.g., `cargo check`, `go vet`, `tsc --noEmit`).
- **Ghost-Run (Testing)**: If enabled, Nool doesn't just check for compilation; it runs the specific unit test suite associated with the mutated module within the scratchpad.
- **Cascade Reification**: If a mutation occurs in a shared definition file (like a `.proto` or schema), Nool triggers reification for all downstream dependent modules across different languages (e.g., updating a Proto triggers both TS and Rust checks).
- **Speculative Abort**: If the code is not semantically valid or fails to compile/lint/test, the **Aram Gate** blocks the proposal with a **Semantic Conflict Trace**, displaying the actual compiler or test error.

---

## Semantic Stability & Canonicalization

One of Nool's core strengths is its ability to ignore "noise"—changes that don't affect the logic or structure of the system.

### 1. Configuration Stability (JSON, TOML, YAML)
In traditional VCS, reordering keys in a configuration file results in a merge conflict or a noisy diff. Nool understands the semantics of these formats:
- **JSON & YAML**: Keys are recursively sorted before hashing. `{"a": 1, "b": 2}` and `{"b": 2, "a": 1}` result in the exact same `NodeID`.
- **TOML**: Structural reordering is canonicalized to ensure a stable identity.

### 2. Comment & Style Invariance
For programming languages, Nool's `GenericLanguageAdapter` performs smart normalization:
- **Comment Stripping**: Language-specific comments (e.g., `%` in Erlang, `#` in Ruby/Elixir, `;` in Clojure) are stripped before calculating IDs. Adding a documentation comment does not change the identity of the function it describes.
- **Separator Normalization**: Stylistic separators (like semicolons in Ruby or single-line vs multi-line blocks in Elixir) are normalized. 
- **Whitespace Invariance**: All remaining whitespace is stripped before the final hash.

---

## What You Can Do

### 1. Propose and Solidify Knots

Use `nool propose` to create a candidate mutation. Nool runs a dry-run through the **Aram Gate** (WASM sandbox) and performs **Speculative Reification** to ensure the code is valid.

```bash
nool propose \
  --intent "Add rate limiting to the login endpoint" \
  --path "src/auth/login.rs" \
  --kind function \
  --thread "Security Hardening"
```

If the Integrity Driver (e.g., `cargo check`) passes, Nool generates a **Validation Attestation**. This attestation—containing the compiler version and output hash—is cryptographically bound to the Knot's metadata.

Then sign and append it:

```bash
nool solidify
```

Output:
```
  [Reify] Materialized shadow-root at .nool/tmp/reify
  [Reify] Running Integrity Driver for '.rs'...
  [Reify] ✅ Verified Runnable. Hash: a3f8...
  [AST] Calculated NodeID using built-in adapter 'generic': b7d2...
Aram Gate (dry-run): OK
Candidate Knot generated. Run 'solidify' to sign and append.
Solidified Knot a3f8c2b1 | intent: "Add rate limiting to the login endpoint"
```

### 2. Understand Repository State

```bash
nool status
```

```
Nool Repository Status
════════════════════════════════════════
  Total Knots   : 14
  DAG Heads      : 1
  Intent Threads : 3
  Pending Proposal: none

Current Heads:
  d7e4c1f0

Active Threads:
  Security Hardening — PCI compliance work
  Auth Refactor
  Payment Feature — Stripe v3 migration
```

### 5. Try Branches (Ephemeral Experimentation)

Spin up ephemeral branches to experiment without polluting the main DAG.

```bash
nool try new my_experiment
nool try list
nool try show my_experiment
nool try promote my_experiment  # Merge back to main
nool try discard my_experiment  # Discard
```

### 6. Query the DAG

Nool provides rich query capabilities for understanding changes:

```bash
nool query resolve-intent "Add rate limiting"  # Find related knots
nool query neighbors <node_id>               # Show causal neighbors
nool query blast-radius <node_id>              # Compute causal descendants
nool query recent-knots                       # Recent knots
nool query materialize <node_id>             # Reconstruct content
nool why <node_id>                          # Walk causal chain
nool dag                                     # Visualize DAG
nool log                                     # Canonical replay log
```

### 7. Threads, Tasks & Bugs

Manage work using Nool's semantic units:

```bash
# Threads
nool thread create "Security Hardening"
nool thread list
nool thread show "Security Hardening"
nool thread status "Security Hardening" --active
nool thread chat "Security Hardening"

# Tasks
nool task create --name "Fix login rate limit"
nool task inbox
nool task pick <id>
nool task assign <id> --to agent-name
nool task finish <id>

# Bugs
nool bug report --title "Login fails" --severity high --reproduction " steps "
nool bug list
nool bug show <bug_id>
nool bug link <bug_id> --fix <knot_id>
```

### 8. Tags & Releases

```bash
nool tag v1.0.0
nool release 1.0.0
nool changelog
```

### 9. Git Bridge

Nool integrates with Git for teams using GitHub/GitLab:

```bash
nool bridge status
nool bridge add-remote https://github.com/user/repo
nool bridge watch
nool git log --oneline
```

### 10. Context & Knowledge

Capture learning to avoid re-discovering issues:

```bash
nool learn --about "rate limit bug" --kind root_cause --content "The bug was in the redis connection pool"
nool findings "rate limit"  # Query captured knowledge
```

### 11. Health & Validation

```bash
nool status
nool doctor              # Check repository health
nool doctor --fix        # Auto-repair issues
nool validate           # Validate fast-mode Knots
nool console            # Launch web dashboard (localhost:4001)
```

---

## Secure Synchronization (`nool-transport`)

Nool uses the **Signal Protocol** (Double Ratchet and X3DH) to provide end-to-end encrypted (E2EE) synchronization between replicas. This ensures that Knots are only readable by authorized collaborators, even if they are stored on untrusted "Hub" servers.

- **Forward Secrecy**: A new symmetric key is derived for every message sent; compromising a current key does not expose past history.
- **Break-In Recovery**: Every bidirectional exchange (DH Ratchet) heals the session; if a key is stolen, the session automatically becomes secure again after the next exchange.
- **Stable Identity**: Nodes identify each other by their public keys, which are cross-verified against the authorized `Knot` author signatures in the ledger.

## Secure Synchronization (`nool sync`)

Nool sync pushes committed but unpushed Knots to your Git remote and records them as synced only after the push succeeds.

### Git-backed Sync (`origin`, `upstream`, or another remote)
If your team already uses GitHub, GitLab, or a private Git server, Nool can use it as a "dumb pipe" for Knot distribution via the **Bifrost Bridge**.

- **Atomic Solidify**: By default, `nool solidify` writes the Knot DAG and creates a Git commit together. If the commit fails, the ledger transaction rolls back.
- **Explicit Offline Mode**: Use `nool solidify --local` when you want DAG-only local iteration.
- **Retryable Pushes**: Use `nool solidify --push` to push immediately, or `nool sync origin` later to push staged Knots.

```bash
nool sync origin
```

### Other Commands

```bash
nool languages           # List supported languages
nool link <knot_id>     # Link knot to metadata
nool quickstart        # Quick-start guide
nool guide             # Detailed guide
nool upgrade          # Upgrade CLI
nool version          # Print version
nool inbox             # Unified notifications
nool audit             # Compliance report
```

