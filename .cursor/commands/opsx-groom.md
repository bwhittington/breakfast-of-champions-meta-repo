---
name: "/opsx-groom"
id: "opsx-groom"
category: "Workflow"
description: "Brainstorm and groom a game idea with clarifying questions, then hand off to OpenSpec propose"
---

Brainstorm and groom a game-design idea until it is specific enough for a strong OpenSpec proposal.

**Load and follow the project skill:** `.cursor/skills/game-spec-groom/SKILL.md`

**Planning / design only.** Do not implement Godot code. Do not file GitHub issues unless the operator explicitly asks after propose.

**Input:** The argument after `/opsx-groom` is the idea, system, or spec path to groom. Examples:

- `/opsx-groom combat should feel like reheating leftovers`
- `/opsx-groom specs/canonical/map_system.md`
- `/opsx-groom` (ask what they want to improve)

## Quick steps

1. Orient against `specs/canonical/` (+ any named OpenSpec change).
2. Optionally offer 2–4 design directions.
3. Ask up to 5 high-leverage questions per turn until ≥90% confidence.
4. Present a **Design Brief** (fantasy, in/out scope, success, spec touchpoints).
5. Only when the operator confirms, run the `/opsx-propose` / openspec-propose workflow using that brief.
6. Remind them: propose ≠ GitHub issues; use `/gh-issue` next if they want the dispatch queue filled.

End each turn with the `GROOM:` contract line from the skill.
