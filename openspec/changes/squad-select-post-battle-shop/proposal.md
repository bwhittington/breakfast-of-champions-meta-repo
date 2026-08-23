## Why

Party rules today assume a **single starter** and a **three-id seed roster** with no growth loop. The operator wants squad-building as a core fantasy: **pick 3 heroes**, **fight together on the field**, **recruit toward 6**, and **shop after every battle** for items, new heroes, and upgrades. Without a spec'd target, implementation will keep drifting toward one-starter debug flows.

## What Changes

- **Party roster (canonical amend):** six unlockable breakfast-food heroes (`cereal`, `waffle`, `bacon` plus three new identities); **run cap 6**; **all active party members fight simultaneously**.
- **Character select (target flow):** before Run start, player picks **exactly 3** from their unlocked roster.
- **Post-battle shop:** after **every combat victory** (`combat`, `elite`, `boss`), enter a **mandatory shop phase** before returning to the Run map (boss win may show shop then end the run).
- Shop offers **items**, **hero recruitment** (respecting cap 6), and **hero upgrades** for the current run party.
- **Phased delivery:** Title **Play = 1 starter, skip select** stays until character-select UI lands (`kitchen-title-menu` interim path unchanged for now).
- **Map shop nodes** remain optional path rewards; they are **not** the primary “shop after every battle” beat.

## Non-goals

- Full meta-progression / unlockables persistence between runs (which heroes are unlocked).
- Skill math, combat AI, item/upgrade economy balance, or art/sprites for new heroes.
- Bench / swap combat — everyone active fights.
- Replacing the 1-starter Play shortcut in the same slice as shop/select UI.
- Removing or redesigning map `shop` node type.

## Capabilities

### New Capabilities

- `character-select`: Pre-run UI and rules for picking exactly 3 heroes from the unlocked roster.
- `post-battle-shop`: Mandatory shop interstitial after combat victory — items, recruitment, upgrades.

### Modified Capabilities

- `characters`: Party size rules (start 3 pick, cap 6), three new hero identities, recruitment constraints.
- `game-loop`: Session flow adds post-battle shop; combat-victory hand-off amended; character select documented as target flow while 1-starter shortcut remains interim.

## Impact

- **Canonical (meta):** `specs/canonical/characters.md`, `specs/canonical/game_loop.md`; note in `map_system.md` that map `shop` nodes differ from post-combat shop.
- **Code (game repo):** roster data expansion, run party model, post-battle shop scene/controller, character-select scene (later slice), `RunController` / phase harness hooks.
- **Coordination:** Does not block `kitchen-title-menu` 1-starter Play; apply should land in dependency order (specs → roster data → shop stub → select UI).
