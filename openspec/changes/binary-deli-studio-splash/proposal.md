## Why

Breakfast of Champions needs a studio identity beat before gameplay. Binary Deli Studios already has finished splash art (microwave + cyber-sub), but the Godot project has no branded boot screen or themed load feedback. Shipping this splash now establishes studio presence and a microwave-timer loading metaphor that matches the brand.

## What Changes

- Add a **Binary Deli Studios splash scene** that matches the provided splash art (microwave, BINARY DELI STUDIOS, tagline JACK IN, EAT OUT.).
- Add a **microwave-timer loading indicator**: the on-door digital clock (`M:SS` style, with `BD` mark) counts down as load progress advances, reaching `0:00` when boot work is complete.
- Make the splash the **first scene** shown on game launch; after the timer hits `0:00` and load work finishes, transition into the current post-boot scene (phase harness / future title hub).
- Check the provided splash image into `game-project/` art assets for use as the primary visual.

## Non-goals

- Interactive microwave buttons (START/CANCEL/AUTO COOK/POPCORN) as real controls — decorative in the art unless a later change adds skip/debug.
- Full title menu, character select, or audio stinger pack (optional one-shot SFX only if trivial).
- Replacing or implementing Run/Combat phase logic (`run-vs-combat-phase-controller` remains separate).
- Recreating the art from scratch in engine primitives when the provided raster is available.

## Capabilities

### New Capabilities

- `studio-splash`: Boot splash branding and microwave-timer countdown load progress for Binary Deli Studios.

### Modified Capabilities

- (none under `openspec/specs/` yet)

## Impact

- **Canonical touchpoint:** inserts before **Title / Hub** in `specs/canonical/game_loop.md` session flow (boot → then existing flow). No change to Run/Combat rules.
- **Code (game repo):** new splash scene/scripts, art under `game-project/`; `project.godot` `run/main_scene` points at splash first.
- **Coordination:** if phase-harness is also main_scene from the other change, splash owns boot and hands off to harness (or title) after load.
- **Asset:** operator-provided splash PNG becomes a tracked game asset.
