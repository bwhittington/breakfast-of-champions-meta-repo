# Map System

Multi-path, *Slay the Spire*-style node logic for a single run.

## Purpose

Define how a run map is generated, what node types exist, and how the player advances along branching paths during the **Run** phase (see `game_loop.md`).

## Core model

A run map is a **directed acyclic graph (DAG)** of nodes arranged in floors (rows):

- Floor `0` — single **start** node
- Floors `1..N-1` — branching combat / reward / event paths
- Floor `N` — single **boss** node

Edges only point forward (higher floor). The player cannot revisit a completed floor.

### Node

| Field           | Type     | Notes                                         |
|-----------------|----------|-----------------------------------------------|
| `id`            | string   | Unique within the run                         |
| `floor`         | int      | Row index                                     |
| `type`          | enum     | See node types below                          |
| `encounter_id`  | string?  | Required for combat-like nodes                |
| `edges_to`      | string[] | Node ids on the next reachable floor(s)       |
| `completed`     | bool     | Set when the player resolves this node        |

### Run map state

| Field            | Notes                                      |
|------------------|--------------------------------------------|
| `current_node`   | Where the party is                         |
| `available_next` | Nodes reachable from `current_node` that are not yet chosen |
| `seed`           | RNG seed used to generate this map         |

## Node types

| Type     | Phase effect                                      |
|----------|---------------------------------------------------|
| `start`  | Entry only; no encounter                          |
| `combat` | Enter Combat with a normal encounter              |
| `elite`  | Enter Combat with a harder encounter + better reward |
| `event`  | Inline choice / story beat; stay in Run           |
| `rest`   | Heal / recover downed ally; stay in Run           |
| `shop`   | Spend run currency (currency TBD); stay in Run    |
| `boss`   | Enter Combat with the floor boss; win ends the Run |

Combat-like types (`combat`, `elite`, `boss`) transition to the Combat phase. All others resolve in Run.

## Path selection rules

1. From `current_node`, the player may select **exactly one** node in `available_next`.
2. `available_next` is the set of nodes listed in `current_node.edges_to` that share the next floor (or are otherwise marked reachable).
3. Choosing a node sets it as `current_node`, marks the previous node `completed`, and triggers that node's resolution.
4. Nodes not chosen on a floor are **skipped** for that run (no visit, no reward).
5. The boss floor has a single node; all valid paths converge on it.

## Generation rules (baseline)

Until a dedicated generator delta exists, maps MUST satisfy:

1. Exactly one `start` and one `boss`.
2. Every non-boss node has at least one outgoing edge to a later floor.
3. Every node except `start` is reachable from `start`.
4. At least two distinct mid-run paths exist between start and boss (true branching, not a single corridor).
5. Encounter ids on combat-like nodes reference definitions backed by `characters.md` enemy data.

Exact floor count, branch width, and reward tables are TBD (seed defaults are fine for prototypes).

## Interaction with game loop

```
Run phase active
  → show map + highlight available_next
  → player picks node N
  → if N is combat-like: enter Combat with N.encounter_id
  → else: resolve N inline
  → on success: current_node = N; refresh available_next
  → if N is boss and Combat won: Run win
```

## Out of scope (for now)

- Infinite / endless maps
- Returning to earlier floors
- Shared online map seeds
- Act structure beyond a single boss floor (multi-act can be a later delta)

## Related specs

- `game_loop.md` — Run vs Combat phase ownership
- `characters.md` — encounter and enemy data attached to nodes
