# Breakfast of Champions — Agent Bindings

Bridge between **OpenSpec** (what is true) and **GitHub issues / dispatch** (what ships next).
Read this before `/gh-issue`, `/dispatch`, `/opsx-*`, or any orchestration loop.

## Dual-repo map

| Concern | Repo slug | Local path |
|---|---|---|
| Specs, OpenSpec, Cursor/agent config | `bwhittington/breakfast-of-champions-meta-repo` | workspace root |
| Godot implementation PRs | `bwhittington/breakfast-of-champions` | `game-project/` |

- File **design / process** issues against the meta repo.
- File **gameplay implementation** issues against the game repo (`gh --repo bwhittington/breakfast-of-champions`).
- Never mix commits across the two remotes in one operation.

## Spec source of truth

| Layer | Path | Role |
|---|---|---|
| Canonical | `specs/canonical/` | Accepted behavior (`game_loop.md`, `characters.md`, `map_system.md`) |
| Active deltas | `specs/active_deltas/` | Informal in-flight design notes |
| OpenSpec changes | `openspec/changes/<name>/` | Formal proposal, delta specs, design, `tasks.md` |
| OpenSpec mirrors | `openspec/specs/` | Optional formal mirrors; keep aligned with canonical when used |

**Rules**

1. Canonical specs win over chat memory and issue commentary.
2. An active OpenSpec change wins over canonical for that change’s scope until archived.
3. GitHub issue bodies are **implementable slices**, not a second design doc.
4. Every dispatchable issue MUST cite at least one spec path (and OpenSpec change path when work came from `/opsx-propose`).

### Traceability scheme

Use in issue bodies (Traceability section):

```text
SPEC: specs/canonical/<file>.md#<section>
CHANGE: openspec/changes/<change-name>/  (when applicable)
TASK: <checkbox text or tasks.md item id>
```

Example: `SPEC: specs/canonical/map_system.md#path-selection-rules`

No formal `REQ-*` IDs yet — path + section is enough. If an issue needs no requirement link, write `SPEC: none — process/meta only` explicitly.

## OpenSpec ↔ GitHub pipeline

```text
idea (vague)
  → /opsx-groom          # brainstorm + clarifying questions → Design Brief
  → operator confirms brief
  → /opsx-propose        # proposal + delta + design + tasks.md, then auto-commit+push meta
  → optional: one /gh-issue per tasks.md chunk
  → /dispatch N          # agents implement in game-project/
  → /opsx-sync + /opsx-archive when behavior is accepted into canonical
```

Solo shortcut (skip GitHub): `/opsx-groom` → confirm → propose → `/opsx-apply`.

| Mode | When | Path |
|---|---|---|
| Groom first | Idea is vague or needs player-fantasy clarity | `/opsx-groom` then propose |
| Solo | One clear change, operator driving | `/opsx-propose` → `/opsx-apply` |
| Multi-agent | Parallel tasks | propose → `/gh-issue` per task → `/dispatch` |

### Issue body contract (slice, not whole change)

When filing from OpenSpec, include the six gh-issue sections, and:

1. **Symptom / missing** — the slice gap only
2. **Spec refs** — `SPEC:` / `CHANGE:` / `TASK:` lines above
3. **Affected code** — verified `file:line` in `game-project/…`, or explicit greenfield path to create
4. **Acceptance criteria** — only criteria for this task (from `tasks.md`), independently testable
5. Do **not** paste the entire proposal/design into the issue

## GitHub control-plane bindings

Shared by both repos (labels bootstrapped identically).

| Binding | Value |
|---|---|
| `<repo-slug>` meta | `bwhittington/breakfast-of-champions-meta-repo` |
| `<repo-slug>` game | `bwhittington/breakfast-of-champions` |
| `<default-branch>` | `main` |
| `<integration-branch>` | `main` |
| `<type-labels>` | `bug`, `enhancement`, `documentation` |
| `<priority-labels>` | `priority:P0`, `priority:P1`, `priority:P2`, `priority:P3` |
| `<lane-labels>` | `lane:leaf`, `lane:plumbing` |
| `<triage-labels>` | `ready-to-dispatch`, `needs-spec-input`, `blocked` |
| `<claim-label>` | `agent-claimed` |
| `<hold-label>` | `do-not-dispatch` |
| `<component-labels>` | `subsystem:game-loop`, `subsystem:characters`, `subsystem:map-system`, `subsystem:meta` |
| `<workhorse-model>` | `sonnet` |
| `<cheap-model>` | `haiku` (no label — never pin code-writing here) |
| `<premium-models>` | `opus` |
| `<traceability-scheme>` | `SPEC:` / `CHANGE:` / `TASK:` paths above |
| `<worktree-dir>` | `<repo-root>/.worktrees/<branch>` (git-ignore locally) |
| `<branch-convention>` | `feat\|fix\|chore\|docs/<N>-<slug>` |
| `<commit-convention>` | lowercase conventional-commit subject; body ends with `Closes #<N>` |
| `<lockfile-install-cmd>` | n/a (Godot — no JS lockfile install for game agents) |
| `<toolchain-prefix>` | empty |
| `<auto-merge-cmd>` | `gh pr merge <N> --auto` |
| `<bot-reviewer>` | none yet |
| `<required-checks>` | none yet — treat green PR checks as advisory until CI exists |
| `<crown-jewel-invariant>` | "canonical specs are authoritative; do not invent contradicting combat/map rules" |
| `<shared-surfaces>` plumbing | `project.godot`, shared autoloads, OpenSpec canonical files, `.cursorrules`, `CLAUDE.md` |
| `<slot-count>` default | `2` (raise with `/dispatch N` when ready) |

### After `/opsx-propose`: auto-update the meta repo (hard)

When propose artifacts validate, **do not wait** for a separate commit request. Immediately:

1. Stage **only** `openspec/changes/<change-name>/` (plus any files that propose itself wrote). Leave `game-project/`, splash/UI code, and unrelated dirty files unstaged.
2. Commit on the **current meta branch** (do not switch to `main` unless already on it). Subject: `propose <change-name> <short why>.`
3. `git push -u origin HEAD` to `bwhittington/breakfast-of-champions-meta-repo`.
4. Report the commit SHA, remote branch, and that apply/issues were **not** started.

Do **not** open a PR, merge to `main`, edit canonical specs (that is `/opsx-sync`), or implement Godot in the same turn. If commit or push fails, report the error; do not rewrite history.

### Operator run policy (hard)

When the operator says **run**, **dispatch**, **go**, **do it**, or pastes `/dispatch` / `/opsx-apply` / `/gh-issue` / `/opsx-propose`:

1. **Do not ask for permission** to proceed — execute.
2. If `/dispatch` has **no N**, use `<slot-count>` default (`2`) — do not stop to ask for a number.
3. Bootstrap blockers yourself when required to dispatch (empty remote, missing worktree base, labels) — report what you did, don't pause for approval.
4. Only ask when a choice is **materially irreversible** and underspecified (e.g. force-push to main, delete a repo, contradict a locked canonical spec). "Which issue first" among ready P1s is **not** a pause — pick by priority then createdAt.
5. Prefer action + a slot table over clarifying questions.

### Filing-time labels

Exactly one type + exactly one priority. Add lane + subsystem when known. Add `agent-model:*` / `agent-effort:*` only when the operator pins them. Never apply `agent-claimed` at filing time.

### Dispatch notes for this project

- Implementation agents work under `game-project/` worktrees branching from `origin/main` of the **game** remote.
- Meta/spec-only issues stay on the meta repo; do not open game PRs for pure docs unless docs live in meta.
- Prefer bundling same-surface small tasks (e.g. three `map_system` copy fixes) into one issue/PR.

## Operator commands (cheat sheet)

| Command | Use |
|---|---|
| `/opsx-groom` | Brainstorm + clarifying questions → Design Brief → gated propose |
| `/opsx-explore` | Freeform thinking (no required brief/propose gate) |
| `/opsx-propose` | Create OpenSpec artifacts, then commit+push them on the meta repo |
| `/opsx-apply` | Solo implement from `tasks.md` |
| `/opsx-sync` / `/opsx-archive` | Merge deltas → canonical, close change |
| `/gh-issue …` | File a groomed, dispatchable slice |
| `/gh-issue-groom` / `/gh-issue-recon` | Clarify / size an existing GitHub issue |
| `/dispatch N` | Orchestrate N slots against ready issues |
| `/rescue` | Unstick a PR / red CI |

## Token discipline

Orchestration loops: caveman for status/coordination. Issue bodies and PR descriptions: humanizer. Never compress labels, `gh` commands, acceptance checklists, or `SPEC:` lines.
