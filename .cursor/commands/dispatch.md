---
name: "/dispatch"
id: "dispatch"
category: "Workflow"
description: "Orchestrate N agent slots — each runs OpenSpec apply scoped to a ready GitHub issue"
---

Orchestrate parallel implementation slots against the GitHub dispatch queue.

**Each slot MUST use OpenSpec apply**, not freeform issue interpretation.

**Load and follow:** `.cursor/skills/dispatch-orchestrator/SKILL.md`

Workers **MUST load and follow:** `.cursor/skills/openspec-dispatch-apply/SKILL.md`
(which wraps `openspec-apply-change` scoped to the issue's `TASK:` lines).

**Input:** Optional slot count `N` after `/dispatch` (default: `2` per `CLAUDE.md`).

## Quick steps

1. List `ready-to-dispatch` issues on meta + game repos (exclude claimed/blocked).
2. Pick up to **N** issues that include `CHANGE:` + `TASK:` in Traceability.
3. Show slot table (issue → change → tasks).
4. Spawn one worker per slot with openspec-dispatch-apply instructions.
5. Each worker runs `openspec instructions apply --change "<name>" --json` **before** code.
6. Summarize PRs and `tasks.md` progress when slots finish.

## Not this command

- **`/opsx-apply`** — solo, full change (or remaining tasks), no GitHub issue required.
- **`/dispatch`** — multi-agent, **one issue slice** per slot, OpenSpec-scoped.

Do not archive or sync canonical specs from dispatch — operator runs `/opsx-sync` later.
