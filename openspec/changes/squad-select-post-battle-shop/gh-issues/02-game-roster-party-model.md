## Symptom / missing

Game roster data lists only three party ids. `RunController` tracks a single `starter_id` with no party array or run currency for shop purchases.

## Traceability

```
SPEC: specs/canonical/characters.md#party-breakfast-foods
CHANGE: openspec/changes/squad-select-post-battle-shop/specs/characters/spec.md
TASK: 2.1, 2.2, 2.3
DISPATCH: openspec-dispatch-apply — run openspec instructions apply for CHANGE; implement TASK lines only.
```

## Affected code

- `game-project/scripts/characters/seed_roster.gd:7-14` — extend `PARTY_IDS` to six heroes
- `game-project/scripts/run/run_controller.gd:29-56` — replace `_starter_id`-only state with `party_ids` (cap 6) + `run_currency`
- `game-project/scripts/ui/kitchen_title.gd` — Play path still passes one starter (interim)

## Acceptance criteria

- [ ] Roster includes `cereal`, `waffle`, `bacon`, `pancake`, `toast`, `egg-scramble` with display metadata
- [ ] After Title Play, `RunController` exposes `party_ids` array of length 1 (interim)
- [ ] `run_currency` is set on `start_run` and readable for shop stub
- [ ] Recruit-at-cap rejection can be tested once shop exists (party cap enforced in controller)

## Scope boundary

Data model + run state only. No shop UI, no character select scene, no combat layout changes.

## Test plan

- Grep `game-project/` for six party ids in roster data
- Play from title → harness shows party array length 1 and currency value
- `RunController` smoke tests updated if present
