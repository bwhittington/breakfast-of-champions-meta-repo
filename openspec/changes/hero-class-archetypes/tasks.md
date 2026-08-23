## 1. Canonical class model (meta repo)

- [ ] 1.1 Amend `specs/canonical/characters.md` with `class` field on party heroes, six-class enum, baseline stat table, and seed hero class column — verify all six ids map to the approved classes
- [ ] 1.2 Document that `role` remains `party | enemy` and class applies to party heroes only — verify no enemy class requirement in canonical text

## 2. Class baseline data (game repo)

- [ ] 2.1 Add `class_baselines` resource or script with placeholder `max_hp`, `speed`, `defense` per class matching design ordering — verify tank beats assassin on HP/defense and assassin beats tank on speed
- [ ] 2.2 Extend seed roster entries with `class` for all six hero ids — verify each id matches the spec table (`toast`→`tank`, etc.)

## 3. Party init hook (game repo)

- [ ] 3.1 When a party hero is added to run state, copy baseline stats from its class unless explicit overrides exist — verify `waffle` initializes with duelist baselines in debug output or harness
- [ ] 3.2 Expose class label in roster/debug readout (harness or print) — verify output shows class name for each party member

## 4. Validation

- [ ] 4.1 Run `openspec validate hero-class-archetypes` in meta repo — verify output reports valid
- [ ] 4.2 Confirm duplicate-class party selection remains allowed in character-select spec (no new restriction added) — verify `squad-select-post-battle-shop` and this change both validate
