## Symptom / missing

Canonical specs still assume a single starter and a three-id party roster. They do not document party cap 6, pick-3 target flow, post-battle shop, or the three expanded hero identities from the approved change.

## Traceability

```
SPEC: specs/canonical/characters.md#party-breakfast-foods
SPEC: specs/canonical/game_loop.md#session-flow
SPEC: specs/canonical/map_system.md#node-types
CHANGE: openspec/changes/squad-select-post-battle-shop/
TASK: 1.1, 1.2, 1.3
```

## Affected code

- `specs/canonical/characters.md` (amend party rules + six hero rows)
- `specs/canonical/game_loop.md` (post-battle shop + character-select target flow)
- `specs/canonical/map_system.md` (map shop vs post-combat shop note)

## Acceptance criteria

- [ ] `characters.md` documents party cap 6, target start-3 pick, all-members-fight, and rows for `pancake`, `toast`, `egg-scramble` with party `toast` distinct from enemy `burnt-toast`
- [ ] `game_loop.md` documents post-battle shop after combat victory and that Title Play 1-starter shortcut remains interim
- [ ] `map_system.md` clarifies map `shop` nodes are optional path rewards, not the mandatory post-combat shop

## Scope boundary

Meta-repo canonical edits only. No Godot code. No `/opsx-sync` archive of the full change.

## Test plan

- Read amended sections; confirm no contradiction with untouched canonical combat/map rules
- Run `openspec validate squad-select-post-battle-shop` — must report valid
