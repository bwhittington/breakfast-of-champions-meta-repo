## Symptom / missing

Roster data has no `class` field. No shared baseline stat table exists for the six hero classes.

## Traceability

```
SPEC: specs/canonical/characters.md#shared-combatant-model
CHANGE: openspec/changes/hero-class-archetypes/specs/hero-classes/spec.md
TASK: 2.1, 2.2
```

## Affected code

- `game-project/scripts/characters/seed_roster.gd:7-14` — add class per party id
- `game-project/scripts/characters/class_baselines.gd` (create) or `data/characters/class_baselines.tres`

## Acceptance criteria

- [ ] Baseline resource defines max_hp, speed, defense per class with tank > assassin on HP/defense and assassin > tank on speed
- [ ] All six seed heroes have correct `class` in roster data
- [ ] Property name avoids GDScript `class` keyword conflict if needed (`hero_class`)

## Scope boundary

Data definitions only. No combat UI, no stat application on spawn (next issue).

## Test plan

- Unit or debug print: load baselines; assert ordering constraints
- Grep roster for six class assignments matching spec table
