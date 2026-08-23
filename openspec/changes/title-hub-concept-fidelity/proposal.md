## Why

The kitchen Title / Hub currently layers generic brown buttons and mismatched mascot sprites on top of the kitchen painting. That double-labels the plank menu, leaves floating placeholder junk, and breaks the fantasy that the player is looking at the approved breakfast-standoff concept. The operator concept painting is the visual source of truth and should read as the scene itself.

## What Changes

- Present the operator kitchen-title concept (warm kitchen, syrup wordmark, painted wooden planks, labeled champions, parchment map) as the full-bleed (or letterboxed) title tableau.
- Replace overlay Button skins with invisible hit/focus zones aligned to the **painted** Play Game / Unlockables / Options / Quit planks. Hover and keyboard/gamepad focus MUST read as a glow or outline on that plank region, not a second brown button.
- Do not draw a second engine title or a second set of character name labels over the painting.
- Animate only **cutouts taken from that same painting**, staying in pose (steam, butter drip, small bob/breathe). Remove placeholder overlay sprites and extra props.
- Keep existing plank **actions** (Play starts a run and skips character select; Unlockables inert; Options stub; Quit exits), parchment-as-decoration, and splash → title hand-off.

## Capabilities

### New Capabilities

- `title-hub`: Kitchen title after studio splash MUST match the operator concept as a living tableau — painted planks are the menu look, hitboxes sit on those planks, and mascot motion is in-pose cutouts from the same art. (Main `openspec/specs/` may still lack an archived `title-hub`; this delta is the presentation contract. It supersedes the overlay-button and placeholder-idle presentation from `kitchen-title-menu`.)

### Modified Capabilities

- (none under `openspec/specs/` if capability not archived yet)

## Impact

- **Code (game repo):** kitchen title scene/scripts, concept raster and cutout textures under `game-project/`; plank Controls restyled as invisible zones with focus highlight; remove mismatched overlay mascots.
- **Player-facing:** title hub looks like the concept painting with a slightly living table; menu still clickable and focusable.
- **Out of scope:** Binary Deli boot splash, map interaction, unlockables content, options persistence, combat sprites.
- **Specs:** OpenSpec change `title-hub-concept-fidelity`.
