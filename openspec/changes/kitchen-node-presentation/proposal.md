## Why

The run map still reads as named breakfast landmarks (Waffle Woods, Doughnut Dunes) instead of kitchen work. Players cannot tell combat from rest from event at a glance. Canonical `map_system.md` already owns types and pathing; this change only makes those types look and label like kitchen tools so the parchment feels unique without changing the DAG.

## What Changes

- Bind each mapped node type to a short mechanic name, presentation alias, icon asset key, and named encounter-pool id (pools are identifiers only — not filled tables).
- Require the Run map UI to show **icon + short name** as the node's identity. Zone names stay on the run-info scroll, not as the node title.
- Keep type enum, path selection, phase transitions, and rest/shop/boss rules as they are in canonical specs.

## Non-goals

- Producing Godot `.tscn` art, filling encounter tables, or changing combat math.
- Shop / Pantry theming (`shop` stays a canonical type, unmapped here).
- Permanent seasoning upgrades on rest (heal / revive only).
- Cloche, spatula, coffee-stain, mitt, or honey-bear as required icons.
- Renaming runtime types to `NODE_*` (aliases only).
- Map generation, branching, rewards, or `game_loop.md` phase rules.

## Capabilities

### New Capabilities

- `map-system`: Player-facing kitchen presentation for mapped node types (`combat`, `elite`, `event`, `rest`, `boss`) while the DAG and lowercase type strings stay canonical. (Main `openspec/specs/` has no archived `map-system` yet; this delta is the presentation contract and mirrors `specs/canonical/map_system.md`.)

### Modified Capabilities

- (none — `openspec/specs/` has no existing capabilities yet)

## Impact

- **Canonical touched:** `specs/canonical/map_system.md` (node types — presentation columns only). `game_loop.md` and `characters.md` unchanged except that encounters still attach by id; pool names are documented, not populated.
- **Code (game repo, later apply):** run map UI under `game-project/` that currently (or will) draw nodes. No phase-controller string changes (`run-vs-combat-phase-controller` keeps `combat` / `elite` / `event` / `rest` / `shop` / `boss`).
- **Player-facing:** five kitchen-tool stops on the parchment; Oven Boss remains the oven mark.
- **Dependencies:** none beyond Godot 4.3 when applied.
