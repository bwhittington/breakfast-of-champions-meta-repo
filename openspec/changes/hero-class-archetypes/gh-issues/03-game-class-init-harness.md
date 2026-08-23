## Symptom / missing

Party heroes do not receive class baseline stats when added to a run. Harness/debug output does not show class labels.

## Traceability

```
CHANGE: openspec/changes/hero-class-archetypes/specs/characters/spec.md
TASK: 3.1, 3.2
DISPATCH: openspec-dispatch-apply — run openspec instructions apply for CHANGE; implement TASK lines only.
```

## Affected code

- `game-project/scripts/run/run_controller.gd:48-56` — apply baselines when party member added
- `game-project/scripts/debug/phase_harness.gd:73-77` — show class in labels

## Acceptance criteria

- [ ] Adding `waffle` to party initializes duelist baseline stats
- [ ] Harness or debug readout shows class name per party member
- [ ] Duplicate classes in party still allowed (no new restriction)

## Scope boundary

Init hook + debug display. No skill kits, no enemy classes.

## Test plan

- Start run with waffle → inspect HP/speed/defense match duelist baselines
- Harness label includes class for each party id
