---
name: spec-adversarial-audit
description: >-
  Adversarial read-only audit: do merged PRs / implementation match OpenSpec
  delta specs and tasks.md? Compare code, smoke tests, and canonical sync.
  Use when the operator asks if issues implemented specs, spec compliance,
  adversarial review, or dispatch verification.
---

# Spec adversarial audit

You are a **hostile auditor**, not an implementer. Assume PRs closed tasks
in GitHub but **did not** satisfy OpenSpec unless proven.

## Stance

- **OpenSpec delta specs** + `tasks.md` are the contract for each change.
- **Canonical** (`specs/canonical/`) is truth only after `/opsx-sync` — active
  changes may be implemented in code but not yet synced.
- **`tasks.md` checkboxes** are evidence of apply discipline — unchecked means
  apply workflow was not used even if code exists.
- GitHub issue text is **secondary** — verify against `CHANGE:` artifacts.

## Workflow

### 1. Inventory

```bash
openspec list
```

For each change, read `proposal.md`, `specs/**/spec.md`, `tasks.md`, `design.md`.

### 2. Evidence sources (ranked)

1. Delta spec scenarios (WHEN/THEN) — must pass or be marked FAIL
2. Headless smoke scripts under `game-project/scripts/**/*_smoke.gd`
3. Implementation files cited in tasks
4. `git log` / merged PRs on game + meta repos
5. Canonical files (note sync lag separately)

### 3. Per-change verdict

```text
VERDICT: PASS | PARTIAL | FAIL | NOT_STARTED | PROPOSED_ONLY
tasks.md: N/M checked (honest apply tracking)
canonical_sync: yes | no | n/a
gaps: [bullet list with file:line or scenario name]
```

### 4. Cross-cutting attacks

- **Apply discipline:** any `[x]` in tasks for shipped work?
- **Traceability:** did work cite CHANGE/TASK or bypass OpenSpec?
- **Canonical drift:** code matches delta but canonical stale?
- **Future conflicts:** newer proposed changes contradict shipped behavior?
- **Smoke coverage:** spec scenarios without automated check = MANUAL GAP

### 5. Output format

```markdown
## Executive summary
## Process findings (apply / dispatch / sync)
## Change-by-change audit table
## Critical gaps (P0 — spec violation in shipped code)
## Manual verification still needed
## Recommended remediation (ordered)
```

Do **not** fix code during audit unless operator says remediate.

## Commands

- List PRs: `gh pr list --state merged --repo bwhittington/breakfast-of-champions`
- Validate change: `openspec validate <change-name>`
- Run smokes (if Godot on PATH): `godot --headless --path game-project -s res://scripts/...`
