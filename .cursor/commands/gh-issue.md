---
name: "/gh-issue"
id: "gh-issue"
category: "Workflow"
description: "File a dispatchable GitHub issue slice from OpenSpec tasks (requires CHANGE + TASK traceability)"
---

File one **implementable slice** as a GitHub issue for later **`/dispatch`**.

Dispatch workers use **OpenSpec apply** scoped to this issue — the issue must
include `CHANGE:` and `TASK:` or slots will refuse the ticket.

Read `CLAUDE.md` issue body contract and traceability scheme.

## Required issue sections

1. **Symptom / missing** — slice gap only
2. **Traceability** — `SPEC:`, `CHANGE:`, `TASK:` (CHANGE is **required** for dispatch)
3. **Affected code** — verified paths or greenfield targets
4. **Acceptance criteria** — from `tasks.md`, independently testable
5. **Scope boundary** — what this slice does NOT do
6. **Test plan** — how to verify

## Dispatch note (include in Traceability)

```text
DISPATCH: openspec-dispatch-apply — run openspec instructions apply for CHANGE; implement TASK lines only.
```

## Labels (filing time)

Exactly one type + one priority + lane + subsystem when known + `ready-to-dispatch`.

Never apply `agent-claimed` at filing time.

## Repo routing

- Meta / canonical / OpenSpec-only → `bwhittington/breakfast-of-champions-meta-repo`
- Godot / `game-project/` → `bwhittington/breakfast-of-champions`

## Example bundles

Group related `tasks.md` sections (see `openspec/changes/*/gh-issues/` for templates).
