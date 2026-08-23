## Why

The kitchen title hub’s **Options** plank still opens a non-persistent stub. Players need a real settings surface on the home screen to tune sound, resolution/window mode, and graphics quality—and have those choices survive relaunch.

## What Changes

- Replace the Options stub panel with a dismissible settings panel on the title hub (same Options plank; no fifth menu item).
- Add persistent game settings: Master / Music / SFX volume, window mode + resolution presets, and a Low / Medium / High graphics quality preset.
- Load saved settings on boot so the title hub (and later play) respect the last choices.
- **BREAKING** (relative to prior title-hub deltas): Options is no longer “stub / save not required”; it MUST expose real controls and MUST persist settings.

## Capabilities

### New Capabilities

- `game-settings`: Persist and apply player audio, display (window mode + resolution), and graphics-quality presets across launches.

### Modified Capabilities

- `title-hub`: Options plank MUST open the real settings panel (not a non-persistent stub) and return focus to the title hub on dismiss. (Main `openspec/specs/` may still lack an archived `title-hub`; this delta updates the Options contract from `title-hub-concept-fidelity` / `kitchen-title-menu`.)

## Impact

- **Code (game repo):** title Options UI; new settings store/autoload (e.g. `ConfigFile` under `user://`); `AudioServer` bus levels; `DisplayServer` window mode/size; quality preset mapping to a small Godot graphics set.
- **Player-facing:** Options on the home/title screen is usable and sticky across sessions.
- **Specs:** OpenSpec change `title-options-settings`; touches session entry at Title / Hub in `specs/canonical/game_loop.md` (meta/boot only—no Run/Combat rule changes).
- **Non-goals:** In-run pause settings; key rebinding; language; cloud sync; unlockables; advanced per-toggle graphics UI; changing the four-plank layout or splash → title hand-off.
