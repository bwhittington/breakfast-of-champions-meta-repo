# Characters

Data definitions for playable **Breakfast Foods** and **Enemies**.

## Purpose

Define the shared character model, party rules, and starter identity for combatants. Implementation in Godot should treat these as data (resources / tables), not hard-coded one-offs where avoidable.

## Shared combatant model

Every combatant (food or enemy) has at least:

| Field          | Type        | Notes                                      |
|----------------|-------------|--------------------------------------------|
| `id`           | string      | Stable kebab-case key                      |
| `display_name` | string      | Player-facing name                         |
| `role`         | enum        | `party` \| `enemy`                         |
| `max_hp`       | int         | Hit points at full                         |
| `hp`           | int         | Current; clamped `0..max_hp`               |
| `speed`        | int         | Higher acts earlier in turn order          |
| `skills`       | list        | Actions usable in Combat                   |
| `tags`         | string[]    | e.g. `hot`, `cold`, `sweet`, `savory`      |

Optional (may be filled by later deltas):

- `defense`, `energy` / `max_energy`
- status immunities, starting statuses
- portrait / scene path

## Party (Breakfast Foods)

### Rules

1. A run starts with a **party** of breakfast-food characters chosen at run start (exact party size TBD; default assumption: **1** starter until roster expands).
2. Party members persist for the run; HP and resource state carry between Combats unless a Rest/Event resets them.
3. A party member at `hp == 0` is **downed** and cannot act until revived (revival method TBD; default: Rest node or specific Event).
4. If every party member is downed at the end of an enemy turn wave / combat resolution, Combat is a defeat (see `game_loop.md`).

### Starter roster (seed — revise freely)

| id            | display_name   | tags              | fantasy                                      |
|---------------|----------------|-------------------|----------------------------------------------|
| `egg-scramble`| Egg Scramble   | `hot`, `savory`   | Flexible striker; reliable basic attacks     |
| `toast`       | Toast          | `hot`, `savory`   | Tanky; guards allies                         |
| `pancake`     | Pancake        | `hot`, `sweet`    | Support; stacks syrup (buffs)                |
| `cereal`      | Cereal         | `cold`, `sweet`   | Ranged / chip damage; milk resource theme    |
| `bacon`       | Bacon          | `hot`, `savory`   | High speed glass cannon                      |

These ids are **canonical placeholders**. Replace or extend via an active delta before treating art/code as final.

## Enemies

### Rules

1. Enemies are spawned from an encounter table attached to a map node (see `map_system.md`).
2. Enemies use the same combatant model with `role = enemy`.
3. Encounter definitions list enemy `id`s (and optional counts / elite flags), not free-form ad hoc stats in scenes.

### Starter encounter archetypes (seed)

| id                 | display_name      | intent                          |
|--------------------|-------------------|---------------------------------|
| `burnt-crumb`      | Burnt Crumb       | Trash mob                       |
| `sour-milk`        | Sour Milk         | Debuff / DoT                    |
| `hangry-waffle`    | Hangry Waffle     | Elite bruiser                   |
| `kitchen-timer`    | Kitchen Timer     | Boss — escalating pressure      |

## Skills (minimal contract)

Each skill has:

| Field        | Notes                                      |
|--------------|--------------------------------------------|
| `id`         | Stable key                                 |
| `name`       | Display                                    |
| `target`     | `self` \| `ally` \| `enemy` \| `all_enemies` |
| `effect`     | Damage, heal, status, or shield            |
| `cost`       | Energy or once-per-combat constraint       |

Exact skill math is deferred; Combat must not assume skills beyond this contract.

## Related specs

- `game_loop.md` — when characters enter Combat and how wipe/win works
- `map_system.md` — which encounters attach to which nodes
