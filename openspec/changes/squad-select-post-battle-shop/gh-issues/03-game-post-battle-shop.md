## Symptom / missing

Combat victory returns directly to Run with no shopping beat. There is no UI to buy items, recruit heroes (up to 6), or upgrade party members after a fight.

## Traceability

```
SPEC: specs/canonical/game_loop.md#combat-phase
CHANGE: openspec/changes/squad-select-post-battle-shop/specs/post-battle-shop/spec.md
CHANGE: openspec/changes/squad-select-post-battle-shop/specs/game-loop/spec.md
TASK: 3.1, 3.2, 3.3, 3.4
DISPATCH: openspec-dispatch-apply — run openspec instructions apply for CHANGE; implement TASK lines only.
```

## Affected code

- `game-project/scenes/ui/post_battle_shop.tscn` (create)
- `game-project/scripts/run/run_controller.gd:84-92` — `combat_won()` must gate boss win behind shop dismiss
- `game-project/scripts/debug/phase_harness.gd:47-50` — hook win button to shop flow

## Acceptance criteria

- [ ] Shop scene shows Items, Recruit Hero, Upgrade Hero, and Continue
- [ ] Stub combat win opens shop before Run/harness resumes
- [ ] Recruit adds hero when party < 6; blocked at 6
- [ ] Upgrade marks a party member upgraded for the run
- [ ] Boss win: shop opens first; run outcome `win` only after Continue

## Scope boundary

Shop stub and wiring only. No real item catalog balance, no art polish, no character select.

## Test plan

- Harness: enter combat → Win → shop appears → recruit → Continue → phase returns to `run`
- Boss path: Win on boss → shop → Continue → `run_outcome` is `win`
