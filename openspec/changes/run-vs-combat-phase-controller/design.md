## Context

See `proposal.md` for motivation. Canonical behavior lives in `specs/canonical/game_loop.md`; map and character systems are still stubs. `game-project/` is a nearly empty Godot 4.3 project (`project.godot` only). This design introduces the first session spine: a phase/run controller that other systems will call into.

Target repo for implementation: `bwhittington/breakfast-of-champions` (`game-project/`).

## Goals / Non-Goals

**Goals:**

- One authoritative owner of `active_phase` and run outcome for a single run.
- Explicit transition API that map/combat (or temporary stubs) call — no scene-local phase flags.
- Enough stub surfaces to manually verify Run→Combat→Run and win/loss endings in-editor.
- Scripts small and named; scenes under `game-project/scenes/`, scripts under `game-project/scripts/`.

**Non-Goals:**

- Real map DAG, path UI, encounter tables, or combat turns/skills/AI.
- Autoload-heavy architecture beyond what this controller needs.
- Save/load or multi-run meta.

## Decisions

### 1. Autoload `RunController` as phase owner

- **Choice:** Register a Godot Autoload (singleton) `RunController` that holds `active_phase`, `run_outcome` (`none` | `win` | `loss`), and current node id (opaque string for now).
- **Why:** Canonical “Game / run controller” ownership; any scene can query/transition without finding a node in the tree.
- **Alternatives:** Scene-local controller only — rejected because map and combat will be separate scenes and would duplicate state. Signal bus with no owner — rejected because someone must still enforce illegal transitions.

### 2. Explicit transition methods, not free-form setters

- **Choice:** Public methods such as `start_run()`, `enter_combat(node_id, node_type)`, `resolve_non_combat_node(node_id, node_type)`, `combat_won()`, `combat_lost()`, `abandon_run()`, plus read-only getters.
- **Why:** Spec requires rejecting illegal transitions; a writeable `phase` property invites bugs.
- **Alternatives:** Generic `set_phase(next)` — rejected; too easy to skip outcome rules (boss win vs normal victory).

### 3. Stub combat and run harness for verification

- **Choice:** Minimal `RunPhaseStub` / `CombatPhaseStub` scenes (or one debug HUD) that call the controller: pick fake node types, start combat, report win/loss.
- **Why:** Specs are testable now without waiting on map/combat changes.
- **Alternatives:** Unit-test-only verification — deferred; Godot test harness not set up yet. Manual editor verification is the acceptance path for this change.

### 4. Node types as string enums matching canonical map types

- **Choice:** Use string constants aligned with `map_system.md`: `start`, `combat`, `elite`, `event`, `rest`, `shop`, `boss`.
- **Why:** Avoid inventing a parallel taxonomy; map system can pass the same values later.
- **Alternatives:** Integer enums — fine later; strings are clearer for stubs and issue evidence.

### 5. Main scene points at the harness

- **Choice:** Set `run/main_scene` in `project.godot` to the debug harness scene that hosts the stubs.
- **Why:** Project currently has empty `main_scene`; need a runnable entry for apply/dispatch verification.
- **Trade-off:** Will be replaced when hub/character-select exists — acceptable.

## Risks / Trade-offs

- **[Risk] Autoload becomes a god-object** → Mitigation: only phase, outcome, and opaque node id; party/map/combat stay elsewhere.
- **[Risk] Stub harness becomes production UI** → Mitigation: name scenes/scripts with `Stub`/`Debug`; later hub change removes them from `main_scene`.
- **[Risk] Map/combat changes redefine node ids** → Mitigation: treat node id as opaque; only `node_type` drives transition rules.

## Migration Plan

1. Implement controller + stubs on a feature branch in the game repo.
2. No data migration (greenfield).
3. Rollback: remove Autoload entry and harness main scene; delete new scripts/scenes.

## Open Questions

- Exact party HP carry model when combat stubs report victory — defer detailed party resource object to the characters/combat change; stubs may use a single integer HP bag on the controller temporarily if needed for the “HP carries back” scenario.
