## Why

Party heroes today have **identity only** (food id, tags, fantasy). The operator wants **six combat classes** — Tank, Brawler, Duelist, Assassin, Mage, Mystic — so squad picks feel distinct in combat. Class must be a **reusable template** (many heroes can share a class over time) with **stat baselines** that differentiate role feel before full skill kits exist.

## What Changes

- Add **`class`** field on **party heroes only** — enum: `tank`, `brawler`, `duelist`, `assassin`, `mage`, `mystic`.
- Define **per-class stat baselines** for `max_hp`, `speed`, and `defense` (placeholder numbers; relative curves are normative).
- Assign each **seed hero** as the first exemplar of one class (six heroes, six classes today; model allows sharing later).
- **Party building:** any 3 from roster; **duplicate classes allowed**.
- **Enemies:** no class field in this change.

## Non-goals

- Enemy class archetypes.
- Skill kits, passives, or energy systems per class.
- Forced party composition (e.g. must include a Tank).
- Character select UI, shop, or combat implementation (data contract + canonical amend only).
- Renaming seed hero display names beyond existing squad-select identities.

## Capabilities

### New Capabilities

- `hero-classes`: Class enum, stat baseline templates, and rules for how class applies to party heroes.

### Modified Capabilities

- `characters`: Combatant model adds optional-for-enemies / required-for-party-heroes `class`; seed roster rows include class assignments.

## Impact

- **Canonical (meta):** `specs/canonical/characters.md` (model, baselines, seed class column).
- **Code (game repo):** roster / combatant resources read `class` and apply baseline stats when spawning party members.
- **Coordination:** Complements `squad-select-post-battle-shop` (same six hero ids); does not change party cap or shop rules.
