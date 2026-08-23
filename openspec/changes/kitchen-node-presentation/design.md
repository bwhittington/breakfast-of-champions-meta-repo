## Context

Canonical map types and phase transitions already exist (`specs/canonical/map_system.md`, `game_loop.md`). `run-vs-combat-phase-controller` binds those lowercase strings. See `proposal.md` for why presentation must change. Apply later will live in the game repo's run-map UI; this change's first jobs may be mapping data plus UI labels, with placeholder icons acceptable until art exists.

## Goals / Non-Goals

**Goals:**

- One lookup from runtime `type` → short name, alias, asset key, pool id.
- Map UI uses that lookup for standing identity (icon + short name).
- Phase controller and graph generation keep using `combat` / `elite` / `event` / `rest` / `shop` / `boss`.

**Non-Goals:**

- Filling `pve_ingredients_easy` (etc.) with real encounter lists.
- Shipping final icon scenes as a gate if a labeled placeholder can satisfy the mapping.
- Redesigning the parchment layout, zone scroll, or Syrup Coins display.

## Decisions

### Decision: Runtime type stays lowercase; aliases are presentation-only

- **Choice:** Keep `type` as `combat` (and siblings). Store `NODE_COMBAT` / `frying_pan_icon.tscn` beside it in a presentation table (resource, const dict, or equivalent).
- **Why:** Phase harness and future map generator already (or will) speak canonical strings. Renaming to `NODE_*` would be a breaking contract with `run-vs-combat-phase-controller`.
- **Alternatives:** Dual-write both enums at runtime (noise, easy to desync); rename the type field (rejected in groom).

### Decision: Asset key `oven_cloche_icon.tscn` with oven art

- **Choice:** Do not rename the key in this change. Art (or placeholder) MUST depict the oven.
- **Why:** Groom locked oven as the boss mark; the table already used this filename. Rename can be a later chore.
- **Alternatives:** `oven_icon.tscn` now (cleaner, extra churn); cloche art (rejected).

### Decision: Pool ids are keys, not generators

- **Choice:** Persist the five pool id strings on the mapping. Encounter spawn still uses existing `encounter_id` on the node until a generator change exists.
- **Why:** Spec says name-only pools. Wiring a fake generator would invent combat content.
- **Alternatives:** Stub empty pool resources now (fine if they are empty maps, not fake fights).

### Decision: Placeholder icons allowed until scenes exist

- **Choice:** Apply MAY use a distinct placeholder (tinted shape + short name) per type if `frying_pan_icon.tscn` is missing, as long as types are visually distinguishable and labeled with the short names.
- **Why:** This OpenSpec change is a presentation contract; art production was out of groom scope. Tasks should not block on illustration.
- **Alternatives:** Block apply until five `.tscn` files exist (slower, not required by the brief).

## Risks / Trade-offs

- **[Risk] Title parchment still shows landmark names** → Mitigation: title hub parchment is decorative (`title-hub` spec). This contract applies to the **run** map, not the title painting.
- **[Risk] Implementers treat `NODE_COMBAT` as `type`** → Mitigation: spec + a single mapping table; tests/assert on lowercase `type`.
- **[Risk] Shop nodes appear with no kitchen icon** → Mitigation: accepted; leave `shop` on canonical fallback until a pantry change.
- **[Risk] Filename `oven_cloche` confuses artists** → Mitigation: comment on the mapping row; optional rename later.

## Migration Plan

1. Add the mapping table in game data (or a tiny presentation helper) without changing the graph schema.
2. Point run-map node widgets at the table for icon + short name.
3. Leave phase transitions and `shop` / `start` as they are.
4. Rollback: hide kitchen labels and fall back to `type` string if UI is wrong; graph data does not migrate.

## Open Questions

- Exact hover copy for longer titles (Cook Line Battle vs Cook Line) — optional, does not change tasks.
