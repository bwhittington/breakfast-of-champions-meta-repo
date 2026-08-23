## Symptom / missing

Canonical combatant model has no hero `class` field, no six-class enum, and no stat baseline templates. Seed heroes lack class assignments.

## Traceability

```
SPEC: specs/canonical/characters.md#shared-combatant-model
CHANGE: openspec/changes/hero-class-archetypes/specs/hero-classes/spec.md
CHANGE: openspec/changes/hero-class-archetypes/specs/characters/spec.md
TASK: 1.1, 1.2
DISPATCH: openspec-dispatch-apply — run openspec instructions apply for CHANGE; implement TASK lines only.
```

## Affected code

- `specs/canonical/characters.md` — add `class` on party heroes, enum, baseline table, seed class column

## Acceptance criteria

- [ ] Six classes documented: tank, brawler, duelist, assassin, mage, mystic
- [ ] Baseline templates for `max_hp`, `speed`, `defense` with relative ordering per spec
- [ ] Seed mapping: toast→tank, bacon→brawler, waffle→duelist, egg-scramble→assassin, cereal→mage, pancake→mystic
- [ ] `role` remains `party | enemy`; enemies do not require class

## Scope boundary

Meta canonical amend only. No Godot code. No skill kits.

## Test plan

- Run `openspec validate hero-class-archetypes` — valid
- Cross-check mapping matches `openspec/changes/hero-class-archetypes/specs/characters/spec.md`
