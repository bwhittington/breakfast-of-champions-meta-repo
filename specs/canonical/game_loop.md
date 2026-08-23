# Game Loop

High-level architecture for a single run of *Breakfast of Champions*.

## Purpose

Define the two primary phases of play — **Run** (map navigation and choice) and **Combat** (turn-based encounters) — and the rules for entering, leaving, and winning or losing a run.

## Phase model

| Phase   | Player focus                         | Owns                            |
|---------|--------------------------------------|---------------------------------|
| Run     | Choosing the next map node           | Map position, path availability |
| Combat  | Resolving an encounter               | Turn order, HP, skills, status  |

Only one phase is active at a time. The run never advances the map while Combat is active.

## Session flow

Until a character-select UI exists, **Title Play** starts a run with **exactly one starter** and **skips** Character select. The long-term diagram still includes that step.

```
Title / Hub
    → Character select  [skipped for now: Title Play starts a run with one starter]
    → Run start (generate map, place party at start node)
    → [Run phase]
         → Player selects an available connected node
         → Resolve node type:
              Combat / Elite / Boss → enter Combat phase
              Rest / Shop / Event   → resolve inline, stay in Run
         → On Combat victory → return to Run at that node
         → On Combat defeat  → Run ends (loss)
    → Boss victory → Run ends (win)
```

## Run phase

### Requirements

1. The player may only move to a node that is **adjacent** to the current node and **unlocked** by the map rules (see `map_system.md`).
2. Selecting a node commits the party to that node; backtracking to previous floors is not allowed unless a future delta explicitly adds it.
3. Non-combat nodes resolve immediately and return control to the Run phase on the same node.
4. Combat-capable nodes transition to the Combat phase with an encounter defined by the node (and character/enemy data from `characters.md`).

### Exit conditions

| Outcome        | Trigger                                      |
|----------------|----------------------------------------------|
| Run win        | Defeat the floor boss                        |
| Run loss       | Party wiped in Combat, or an explicit fail event |
| Abandon        | Player quits; run is discarded (no persist yet)  |

## Combat phase

### Requirements

1. Combat is turn-based. Each combatant acts according to initiative / turn order defined by character data.
2. The player controls breakfast-food party members; enemies are AI-controlled.
3. Combat ends when all enemies are defeated (**victory**) or all party members are defeated (**defeat**).
4. On victory, surviving party state (HP, resources) carries back into the Run phase unless a node effect says otherwise.
5. On defeat, the Run ends; no further map progress is allowed.

### Out of scope (for now)

- Persistent meta-progression between runs
- Multiplayer
- Real-time (non-turn-based) combat

## State ownership (implementation guide)

| Concern              | Canonical owner        |
|----------------------|------------------------|
| Current phase        | Game / run controller  |
| Map graph + position | Map system             |
| Party roster + stats | Characters / run party |
| Active encounter     | Combat controller      |

## Related specs

- `characters.md` — who fights and their data
- `map_system.md` — how nodes and paths are built and chosen
