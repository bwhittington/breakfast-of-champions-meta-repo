---
name: openspec-dispatch-apply
description: >-
  Implement a GitHub issue slice using OpenSpec apply — not freeform issue
  interpretation. Use when /dispatch assigns a slot, when an issue has CHANGE:
  and TASK: traceability, or when a worker agent picks up a ready-to-dispatch
  ticket. Always run openspec instructions apply before editing code.
allowed-tools: Bash(openspec:*)
---

# OpenSpec dispatch apply (issue slice)

A dispatched slot is **`/opsx-apply` scoped to one GitHub issue**, not a
standalone ticket interpretation. The issue is a **task filter** on an OpenSpec
change; OpenSpec artifacts are the behavior contract.

## Hard rules

1. **OpenSpec first** — run `openspec instructions apply --change "<name>" --json`
   before any implementation edit. Read every path in `contextFiles`.
2. **Task filter** — implement **only** the `TASK:` ids/lines listed in the
   issue body. Do not complete other checkboxes in the same session unless the
   operator expands scope.
3. **No invented behavior** — delta specs + design + canonical win over issue
   prose if they conflict. Pause and report conflicts.
4. **Check off tasks** — after each finished task, mark `- [x]` in
   `openspec/changes/<name>/tasks.md` (meta repo). One PR may cover multiple
   tasks if the issue bundles them.
5. **Correct repo** — meta/spec issues → meta repo; Godot issues →
   `game-project/` (separate git remote). Never mix remotes in one commit.
6. **PR closes issue** — commit subject conventional; PR body ends with
   `Closes #<N>`.

## Inputs (from orchestrator or issue)

- Issue number and repo (`bwhittington/breakfast-of-champions-meta-repo` or
  `bwhittington/breakfast-of-champions`)
- `CHANGE: openspec/changes/<name>/` from Traceability section
- `TASK: …` lines (e.g. `2.1, 2.2, 2.3` or full checkbox text)
- `SPEC:` paths for extra context

If `CHANGE:` is missing, stop — issue is not dispatch-ready. Label
`needs-spec-input` and do not implement.

## Workflow

### 1. Load issue and parse traceability

```bash
gh issue view <N> --repo <slug> --json title,body,labels
```

Extract `CHANGE:` → `<change-name>`, `TASK:` → scoped task ids.

### 2. OpenSpec apply bootstrap (required)

Follow **openspec-apply-change** steps 1–4:

```bash
openspec status --change "<change-name>" --json
openspec instructions apply --change "<change-name>" --json
```

Read all `contextFiles` (proposal, specs, design, tasks). Apply `context` and
`operationGuidance` from the apply output.

If `state: "blocked"`, stop and report — do not improvise implementation.

### 3. Map tasks to issue scope

Open `openspec/changes/<change-name>/tasks.md`. Select only tasks matching the
issue's `TASK:` lines. Show:

```text
Dispatch slice: issue #N → change <name> → tasks X.Y, …
```

### 4. Worktree / workspace

- **Game issue:** branch from `origin/main` of game remote in
  `.worktrees/<branch>` or edit `game-project/` per `CLAUDE.md`.
- **Meta issue:** branch on meta repo; edit `specs/canonical/` only when the
  task says so (not full `/opsx-sync` unless tasked).

Branch: `feat/<N>-<short-slug>` or `docs/<N>-<short-slug>`.

### 5. Implement (openspec-apply loop, scoped)

For each in-scope pending task:

1. Announce task id + description
2. Implement per delta spec + design (not issue summary alone)
3. Verify per task's inline verification in `tasks.md`
4. Mark `- [x]` in `tasks.md`
5. Commit on slice branch

Pause on ambiguity, spec conflict, or scope creep.

### 6. Pull request

- Title: `[#N] <concise what>`
- Body: Symptom fixed, tasks completed, test evidence, Traceability block
  copied, `Closes #N`
- Target: `main` on the issue's repo
- Remove `agent-claimed` if present; do not merge unless operator asked

### 7. Slot report (to orchestrator)

```text
SLOT: issue=#N change=<name> tasks=[…] branch=<branch> pr=<url> status=done|blocked
```

## Anti-patterns

- Implementing from issue acceptance criteria **without** reading OpenSpec artifacts
- Completing the **whole** change while dispatched on one slice
- Skipping `tasks.md` checkboxes
- Editing canonical specs when the task only mentions delta/game code
- Using `/opsx-archive` or `/opsx-sync` from a dispatch slot (orchestrator/operator only)

## Relationship

| Command / skill | Role |
|---|---|
| `openspec-apply-change` | Full change apply (solo path) |
| **openspec-dispatch-apply** (this) | Apply **subset** of tasks for one issue |
| `dispatch-orchestrator` | Fills N slots, assigns issues |
