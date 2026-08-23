## Context

See `proposal.md`. `title-hub-concept-fidelity` added `CutoutWaffle`, `CutoutBacon`, `CutoutEspresso`, and `CutoutSteam` as full `TextureRect` overlays on `kitchen_title.png`. The tableau already paints those champions. Cutout PNGs with feathered/circular alpha produce the reported **lens + double character** bug (operator screenshot 2026-08-23).

## Goals / Non-Goals

**Goals:**

- One cohesive painting read at rest and during idle loops.
- Preserve subtle life (steam/drip/bob) where possible without duplicate bodies.
- Keep smoke tests green for Play wiring and plank empty text.

**Non-Goals:**

- Full re-authoring of operator concept art.
- Replacing invisible plank hitboxes or focus outlines.

## Decisions

### 1. Remove full-body character cutouts from scene

- **Choice:** Delete or disable `CutoutWaffle`, `CutoutBacon`, and `CutoutEspresso` nodes (and their textures if unused). Keep tableau as single source for static character art.
- **Why:** Directly fixes duplicate-body bug; simplest correct fix.
- **Alternatives:** Mask holes in tableau under cutouts — needs art pipeline; rejected for v1.

### 2. Partial motion only (steam / drip)

- **Choice:** If motion is kept, allow **only** `CutoutSteam` and/or a small butter-drip fragment **if** cropped so it does not include a second full character mesh. Prefer animating steam only; remove waffle/bacon tweens.
- **Why:** Steam does not duplicate a full second body when aligned to mug region.
- **Alternatives:** Whole-tableau subtle breathe via shader — defer unless steam alone feels dead.

### 3. Align partial overlays to painted anchors

- **Choice:** Position any remaining partial cutouts using the same anchor math but verify visually at 1280×720 and 16:10 — no offset drift that exposes circular alpha fringe as a "portal."
- **Why:** Circular alpha on misaligned cutouts caused lens appearance.

### 4. Smoke test updates

- **Choice:** Update `kitchen_title_smoke.gd` to assert **no** `%CutoutWaffle` / `%CutoutBacon` / `%CutoutEspresso` full-body nodes (or they are hidden). Optional `%CutoutSteam` allowed.
- **Why:** Prevent regression.

## Risks / Trade-offs

- **[Risk] Title feels static without body bob** → Mitigation: keep steam loop + optional subtle tableau-scale breathe later.
- **[Trade-off] Less motion than concept-fidelity spec originally asked** → Spec delta explicitly forbids duplicate bodies; partial motion is enough.

## Migration Plan

1. Remove/disable full-body cutouts in scene + script tweens.
2. Visual verify F6 at 1280×720.
3. Update smoke test.
4. Delete unused cutout PNG assets if unreferenced.

## Open Questions

- Whether operator can supply steam-only/drip-only PNG crops; if not, steam cutout stays or motion is removed entirely.
