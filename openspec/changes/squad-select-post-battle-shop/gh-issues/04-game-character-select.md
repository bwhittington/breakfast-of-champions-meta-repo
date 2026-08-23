## Symptom / missing

No pre-run UI to pick exactly 3 heroes from the unlocked roster. Title Play still bypasses select with one starter (interim path must remain until explicitly rewired).

## Traceability

```
SPEC: specs/canonical/game_loop.md#session-flow
CHANGE: openspec/changes/squad-select-post-battle-shop/specs/character-select/spec.md
TASK: 4.1, 4.2, 4.3
```

## Affected code

- `game-project/scenes/ui/character_select.tscn` (create)
- `game-project/scripts/run/run_controller.gd:48-56` — accept three ids on `start_run`
- `game-project/scripts/ui/kitchen_title.gd` — document Play still uses 1-starter interim

## Acceptance criteria

- [ ] Select lists all six roster heroes (all unlocked until meta unlocks exist)
- [ ] Confirm disabled until exactly 3 distinct heroes selected
- [ ] Confirm starts run with `party_ids` length 3
- [ ] Title Play path unchanged: still one starter, skip select

## Scope boundary

Character select scene + wiring. Does not remove Title Play shortcut. Duplicates allowed (any 3).

## Test plan

- Open character select directly → pick 3 → confirm → harness shows 3 party ids
- Title Play → still 1 starter
