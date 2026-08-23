## Context

See `proposal.md`. Canonical combatants use `role: party | enemy` only (`specs/canonical/characters.md`). `squad-select-post-battle-shop` (same branch family) defines six hero ids but not classes. This change adds a **`class`** template layer and baseline stats without skill kits.

## Goals / Non-Goals

**Goals:**

- Spec six classes with relative stat curves.
- Wire seed heroes as first exemplars (one per class today).
- Keep class reusable for future roster expansion.
- Allow duplicate classes in pick-3 parties.

**Non-Goals:**

- Enemy classes, skills, passives, energy, UI polish, balance tuning beyond placeholder integers.

## Decisions

### 1. Field name `class` on party combatant data

- **Choice:** Add `class: StringName` (or enum) on party hero resources; omit on enemies.
- **Why:** Distinct from `role` (`party`/`enemy`); matches operator vocabulary.
- **Alternatives:** `archetype` — rejected; operator said "classes."

### 2. Baseline table as shared resource

- **Choice:** `class_baselines.gd` or `.tres` keyed by class id; roster rows reference `class`; spawn code copies baselines into runtime combatant.
- **Why:** Supports many heroes per class without duplicating numbers.
- **Alternatives:** Per-hero stats in roster — fights reuse goal.

### 3. Placeholder baseline integers (relative, not final)

| Class | max_hp | speed | defense | Intent |
|-------|--------|-------|---------|--------|
| tank | 120 | 4 | 8 | Highest soak |
| brawler | 100 | 6 | 5 | Aggressive melee |
| duelist | 90 | 7 | 4 | Fast skirmisher |
| assassin | 70 | 10 | 2 | Glass, fastest |
| mage | 80 | 5 | 3 | Fragile caster |
| mystic | 85 | 6 | 4 | Support-ish middle |

- **Why:** Satisfies spec ordering scenarios; easy to rebalance.
- **Alternatives:** Ratios only in spec — harder for implementers to test.

### 4. Seed mapping fixed in canonical + roster

- **Choice:** Table from brief (toast→tank, etc.); hero display names unchanged.
- **Why:** Operator approved mapping; six classes covered by six seed heroes.

### 5. Dual-repo split

- **Choice:** Meta amends `characters.md` + class baseline section. Game: extend roster resource, baseline table, spawn hook.
- **Why:** Per `CLAUDE.md` git boundaries.

## Risks / Trade-offs

- **[Risk] `class` keyword in GDScript** → Mitigation: use `hero_class` property name in code if needed; spec field remains `class`.
- **[Risk] Overlap with squad-select apply order** → Mitigation: apply squad roster ids first or same PR series; class change only adds columns.
- **[Trade-off] Baselines without skills** → Classes may feel subtle until kits land.

## Migration Plan

1. Meta: OpenSpec + canonical class section.
2. Game: baseline resource + roster `class` column + init hook.
3. Rollback: strip `class` from roster; revert to flat placeholder stats.

## Open Questions

- Whether UI shows class as Title Case label ("Assassin") — default yes in select/shop when those UIs exist.
