# Nool User Guide: Semantic-Agentic Version Control

**Current Version**: v1.18.0 — This guide documents the latest stable release. Feature sections note when they were introduced; all features listed below are available in v1.18.0 and later.

Nool is not just a replacement for Git — it is a shift from tracking **lines of text** to tracking **semantic logic and intent**. This guide covers what you can do with Nool, who it is for, and how it differs from traditional version control.

---

## Steps to install

```bash
./install_tar.sh ./1.17.0/nool-1.17.0-release.tar.gz
```
Add SKILL.md file to appropriate location for your agent.
```
~/.agents/skills/nool/SKILL.md
~/.claude/skills/nool/SKILL.md
```
## Sample prompt for your coding agent (claude/gemini/copilot/codex ..)
A sample game
```
Build a Breakout game with:
- scoring
- combo multiplier
- power-ups

Use Nool at every step to:
- understand changes
- check blast radius
- validate before applying
- use concurrent threads 

Then remove multi-ball and observe what breaks.

Summarize:
- What Nool revealed that a diff would not
- What felt safer or more predictable
- comparison with git
- how you would use it in your daily workflow
```
You are working on an **existing codebase**. Complete the following tasks using Nool:
```
1. Rehydrate Context
   - Use Nool to understand recent changes and active features
   - Identify which parts of the system were modified last

2. Analyze Impact
   - Pick a file or function you plan to modify
   - Use Nool to show its blast radius and dependencies

3. Make a Change (Fast Mode)
   - Propose a small change using Nool (--fast)
   - Observe what Nool reports as affected

4. Validate Risk
   - Run validation (affected-only or full)
   - Identify any potential risks or conflicts

5. Replay Understanding
   - Use Nool replay to inspect a recent change
   - Explain what changed and why

6. Decision
   - Based on Nool insights, decide:
     → Is the change safe to apply?
     → What could break later?

- use concurrent threads 

Summarize:
- What Nool revealed that a diff would not
- What felt safer or more predictable
- comparison with git
- how you would use it in your daily workflow
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

### 4. Selective Undo (Thread Plucking)

This is the "killer feature" for working with coding agents. If an agent creates a messy refactor in one thread while fixing a bug in another, you can preview the repository state as if the refactor never happened.

```bash
nool pluck "Auth Refactor"
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

