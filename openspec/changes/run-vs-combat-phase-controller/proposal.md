## Why

Canonical `specs/canonical/game_loop.md` defines Run vs Combat as mutually exclusive phases, but `game-project/` has no controller that owns phase state or transitions. Without that spine, map navigation and combat cannot be composed safely. Building the phase controller now establishes the run session entry point everything else plugs into.

## What Changes

- Add a Godot **run/phase controller** that owns the active phase (`run` | `combat`) for a single run session.
- Enforce canonical transition rules: combat-capable nodes enter Combat; victory returns to Run; defeat ends the run; non-combat nodes stay in Run.
- Expose a minimal API for map and combat systems to request transitions and query phase (stubs allowed where full systems do not exist yet).
- Wire a temporary debug/dev path so phase transitions can be exercised without a finished map UI or combat AI.

## Non-goals

- Full map generation, path UI, or node graph implementation (see `map_system.md` — later change).
- Full turn-based combat, skills, status effects, or AI (see `characters.md` / later combat change).
- Character select, hub, meta-progression, save/load, multiplayer.
- Persisting run state across app restarts.

## Capabilities

### New Capabilities

- `game-loop`: Formalize Run vs Combat phase ownership, valid transitions, and run win/loss outcomes as implementable requirements (mirrors and tightens `specs/canonical/game_loop.md` for the controller slice).

### Modified Capabilities

- (none — `openspec/specs/` has no existing capabilities yet)

## Impact

- **Canonical touched:** `specs/canonical/game_loop.md` (phase model, session flow, state ownership).
- **Code (game repo):** new scripts/scenes under `game-project/` (phase/run controller, thin stubs for combat/run surfaces).
- **Dependencies:** Godot 4.3 GDScript; no new third-party packages.
- **Downstream:** unlocks later map-system and combat changes that call into this controller rather than owning phase themselves.
