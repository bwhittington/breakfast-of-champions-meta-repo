## Why

Session flow already names a Title / Hub, but after the studio splash the player still lands on the debug phase harness. The kitchen standoff concept is ready: without a title scene, there is no branded way to start a run, and the seed roster still names foods that the poster does not show.

## What Changes

- Add a **kitchen title / hub** after splash: full-bleed concept art, wooden-plank **Play Game / Unlockables / Options / Quit**, looping idles on a few mascots.
- **Play** starts a run through the existing `RunController` / phase harness path (character select skipped until that UI exists). Runs still start with **one** starter; the poster is a squad poster, not a three-hero party.
- **Unlockables** is visible but non-functional. **Options** is a stub panel. **Quit** exits.
- Planks sit in a **bottom-left safe rect**; parchment map is **non-interactive**. Keyboard / gamepad can focus and activate planks. Painted title is the only title (no duplicate label).
- **BREAKING** for seed identity: amend starter party and enemy tables to match the poster (`cereal`, `waffle`, `bacon`; `espresso-mug`, `burnt-toast`, `fried-egg`; keep `kitchen-timer` as Oven Boss). Retire `egg-scramble`, `pancake`, hero-`toast`, `burnt-crumb`, `sour-milk`, `hangry-waffle`. Identity only — no skill math or combat sprites.
- Point splash `post_boot_scene` at the title scene. Update any harness/stub encounter ids that still use retired keys.

## Non-goals

- Character select, real unlocks / meta-progression, full options/audio mix, save/load.
- Combat or run-map UI; parchment location names do not change `map_system.md`.
- Animating every character; Spine / sprite-sheet pipeline; full layered diorama.
- Plank hover-tilt / wood-knock SFX; kitchen room-tone bed.
- Changing Run vs Combat phase rules.

## Capabilities

### New Capabilities

- `title-hub`: Kitchen title scene after splash — tableau, plank actions, focus, idles, Play starts a run.
- `characters`: Seed party and enemy **identity** aligned with the title poster (ids, display names, roles, one-line fantasy).

### Modified Capabilities

- (none — `openspec/specs/` has no archived capabilities yet; splash hand-off target is specified under `title-hub` and in Impact)

## Impact

- **Canonical:** `specs/canonical/game_loop.md` (Title / Hub; Play → run start; character select still listed but skipped). `specs/canonical/characters.md` (**amend** seed tables). `specs/canonical/map_system.md` untouched for generation.
- **Code (game repo):** new title scene/scripts, concept raster under `game-project/`; `studio_splash.gd` `post_boot_scene` → title; harness/stubs if they reference enemy ids.
- **Coordination:** splash still owns `application/run/main_scene`. Phase harness remains the Play destination, not the cold-boot landing.
- **Asset:** operator kitchen-menu concept PNG is the visual source of truth.
