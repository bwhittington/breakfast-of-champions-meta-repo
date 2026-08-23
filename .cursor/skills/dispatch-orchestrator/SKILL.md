---
name: dispatch-orchestrator
description: >-
  Orchestrate N parallel dispatch slots against ready-to-dispatch GitHub issues.
  Each slot MUST use openspec-dispatch-apply (OpenSpec apply scoped to issue
  TASK lines). Use when the operator runs /dispatch or says dispatch/go.
---

# Dispatch orchestrator

Fill **N** slots from the GitHub queue. Each slot runs
**openspec-dispatch-apply** — not ad-hoc issue fixing.

Read `CLAUDE.md` bindings first.

## Hard rules

1. **Default N** — if omitted, use `<slot-count>` (`2`).
2. **Queue** — issues labeled `ready-to-dispatch`, excluding `do-not-dispatch`,
   `blocked`, `needs-spec-input`, and already `agent-claimed`.
3. **Sort** — priority P0→P3, then oldest `createdAt`.
4. **One issue per slot** — do not stack multiple issues on one agent.
5. **Every slot uses OpenSpec apply** — worker prompt MUST include:
   - Load `.cursor/skills/openspec-dispatch-apply/SKILL.md`
   - Parse `CHANGE:` / `TASK:` from assigned issue
   - Run `openspec instructions apply` before code
6. **Claim** — add `agent-claimed` when a slot starts; remove on PR opened or
   blocked handoff.
7. **Execute** — do not ask permission unless irreversible and underspecified.

## Workflow

### 1. Bootstrap

```bash
gh auth status
gh issue list --repo bwhittington/breakfast-of-champions-meta-repo --label ready-to-dispatch --json number,title,labels,createdAt
gh issue list --repo bwhittington/breakfast-of-champions --label ready-to-dispatch --json number,title,labels,createdAt
```

Create missing labels if needed (see `CLAUDE.md`). Ensure `.worktrees/` exists.

### 2. Select up to N issues

Skip issues missing `CHANGE:` in body. If all lack `CHANGE:`, report queue
not dispatch-ready.

Prefer **meta canonical tasks before dependent game tasks** when priorities tie
(docs §1 before game §2 for same change).

### 3. Slot table (announce before spawning)

```text
| Slot | Issue | Repo | Change | Tasks | Agent |
|------|-------|------|--------|-------|-------|
| 1    | #12   | game | squad-select-post-battle-shop | 2.1-2.3 | Task |
| 2    | #5    | meta | hero-class-archetypes | 1.1-1.2 | Task |
```

### 4. Spawn workers

Use **Task** subagent per slot. Prompt template:

```text
You are dispatch slot <K> for Breakfast of Champions.

1. Read CLAUDE.md and .cursor/skills/openspec-dispatch-apply/SKILL.md — follow exactly.
2. Issue: <repo>#<N> — gh issue view for full body.
3. Run openspec instructions apply for CHANGE named in issue Traceability.
4. Implement ONLY the TASK lines from the issue.
5. Open PR with Closes #<N>.
6. Return SLOT report line from the skill.
```

Do **not** tell workers to "just fix the issue" without OpenSpec apply.

### 5. Monitor and summarize

When slots complete, table:

```text
| Slot | Issue | PR | tasks.md Δ | Status |
```

If blocked: leave `agent-claimed`, comment on issue with blocker, suggest
`/rescue` or spec update.

## Token discipline

Orchestrator status: caveman OK. Do not compress issue numbers, PR URLs, or
`CHANGE:` / `TASK:` lines.

## Anti-patterns

- Spawning generic "implement GitHub issue" agents without openspec-dispatch-apply
- Dispatching issues without `CHANGE:` traceability
- Workers completing entire `tasks.md` in one slot
- Merging PRs from orchestrator without operator ask
