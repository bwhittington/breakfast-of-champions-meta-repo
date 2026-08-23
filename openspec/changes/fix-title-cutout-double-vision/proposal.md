## Why

After the studio splash, the kitchen title hub shows a **circular lens-like overlay** with **duplicate Waffle Warrior and Bacon Brawler** figures on top of the painted tableau. The operator concept art already includes those characters; separate full-body cutout textures stacked on the painting create double vision and break the standoff fantasy. This regresses `title-hub-concept-fidelity` intent.

## What Changes

- **Remove duplicate character rendering** — the title MUST NOT show the same champion twice (once in the tableau, once as a floating cutout).
- **Restrict animated overlays** to **partial, non-duplicative** elements only (e.g. steam wisps, butter drip) OR apply **subtle in-pose motion** without full-body cutout stacks.
- **Eliminate circular/feathered cutout artifacts** that read as a misplaced UI lens over the painting.
- Keep plank hitboxes, Play/Options/Quit behavior, and splash → title hand-off unchanged.

## Non-goals

- Re-exporting the full operator concept as layered PSD (unless apply discovers it is required).
- New mascot idles (boxing, waving, scurrying).
- Binary Deli boot splash timer changes.
- Map, combat, or roster work.

## Capabilities

### New Capabilities

- (none)

### Modified Capabilities

- `title-hub`: Clarify cutout/animation rules so motion never duplicates painted character bodies; forbid lens-like full-body overlays.

## Impact

- **Code (game repo):** `kitchen_title.tscn`, `kitchen_title.gd`, cutout assets under `assets/ui/`; update `kitchen_title_smoke.gd`.
- **Player-facing:** title reads as one cohesive painting with subtle life, not a screenshot-with-overlay glitch.
- **Related changes:** supersedes the broken overlay pattern from `title-hub-concept-fidelity` apply; does not revert plank-invisible-button work.
