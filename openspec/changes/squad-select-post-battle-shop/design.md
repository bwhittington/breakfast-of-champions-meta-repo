## Context

See `proposal.md` for motivation. Canonical party rules today default to **one starter** (`specs/canonical/characters.md`, `game_loop.md`); `kitchen-title-menu` implements Title Play with that shortcut. `RunController` owns run phase; combat victory currently returns straight to Run. Map `shop` nodes exist as optional Run-phase stops (`map_system.md`) — distinct from the operator's **post-every-battle** shop.

Target implementation: `game-project/` (Godot 4.3). Meta repo owns canonical amendments via this change.

## Goals / Non-Goals

**Goals:**

- Spec a clear **3-pick → 6-cap → all-fight → shop-after-battle** loop.
- Name **six hero identities** in canonical + machine-readable roster data.
- Define shop categories (items / recruit / upgrade) and boss-flow (shop then win).
- Preserve **1-starter Title Play** until character-select UI ships.

**Non-Goals:**

- Unlockables persistence, economy tuning, skill math, combat sprites.
- Replacing map `shop` nodes or bench/swap combat.
- Shipping select UI and shop in one PR (tasks split by dependency).

## Decisions

### 1. Run party as ordered id list on RunController

- **Choice:** Extend run state with `party_ids: Array[String]` (cap 6) and optional per-run upgrade flags. Interim: single `starter_id` populates a one-element party until select exists.
- **Why:** Shop recruitment and combat both need one source of truth.
- **Alternatives:** Separate PartyManager autoload — defer until combat needs more than ids.

### 2. Post-battle shop as Run-phase overlay / sub-state

- **Choice:** After combat victory signal, set `shop_pending = true` (or phase `run` + modal). Block map input until shop emits `dismissed`. Then apply existing return-to-run or boss-win logic.
- **Why:** Avoids a third top-level phase enum until combat controller matures.
- **Alternatives:** New `shop` phase in phase controller — valid later if overlay gets heavy.

### 3. Stub economy first

- **Choice:** Add `run_currency: int` on run start (seed value for debug). Shop purchases decrement currency; zero-cost stubs ok for v1.
- **Why:** Spec requires purchasable categories without fixing balance.
- **Alternatives:** Free everything — hides recruitment cap bugs.

### 4. Character select as separate scene (later slice)

- **Choice:** `scenes/ui/character_select.tscn` lists unlocked roster (all six until unlockables exist). Confirm → `start_run(selected_ids)` → harness or map. Title Play bypasses until wired.
- **Why:** Matches phased delivery; doesn't regress `kitchen-title-menu`.
- **Alternatives:** Embed select in title — couples two changes.

### 5. Three new heroes — revived ids with distinct enemy collision

- **Choice:** `pancake`, `toast` (party), `egg-scramble` with explicit note that enemy `burnt-toast` ≠ party `toast`.
- **Why:** Operator approved designing three new foods; ids were previously retired in title change.
- **Alternatives:** Brand-new ids — unnecessary churn.

### 6. Dual-repo task split

- **Choice:** Meta tasks amend `specs/canonical/*.md`. Game tasks: roster resource, party array, shop scene stub, harness hook on combat win.
- **Why:** Workspace git boundary per `CLAUDE.md`.

## Risks / Trade-offs

- **[Risk] Double shop (map node + post-battle)** → Mitigation: spec distinguishes triggers; map shop resolves inline in Run, post-battle shop only on combat victory.
- **[Risk] Boss run ends before shop** → Mitigation: boss win scenario requires shop dismiss before `outcome = win`.
- **[Risk] 1-starter vs 3-pick confusion in harness** → Mitigation: character-select spec documents interim shortcut; tasks label which slice changes Play behavior.
- **[Trade-off] All six on field** → Combat UI/layout complexity deferred; stub may show count only until battle scene exists.

## Migration Plan

1. Meta: OpenSpec change + canonical amendments (party rules, session flow note, map shop distinction).
2. Game: expand roster data → party array → post-battle shop stub → character select scene.
3. Rollback: remove shop hook; revert party to single starter; trim roster rows in canonical if needed.

## Open Questions

- Exact run currency earn rate per combat (defer to balance pass).
- Whether shop is skippable with a "Continue" button or must browse one offer (default: dismissible Continue always available).
