## 1. Canonical party and session flow (meta repo)

- [ ] 1.1 Amend `specs/canonical/characters.md` with party cap 6, target start-3 pick, all-members-fight rule, and three new hero rows (`pancake`, `toast`, `egg-scramble`) — verify the party table lists six ids and party `toast` is distinct from enemy `burnt-toast`
- [ ] 1.2 Amend `specs/canonical/game_loop.md` with post-battle shop in session flow, target character-select step, and note that Title Play 1-starter shortcut remains interim — verify combat-victory section references shop before returning to Run
- [ ] 1.3 Add a short note in `specs/canonical/map_system.md` that map `shop` nodes are optional path rewards and do not replace post-combat shop — verify the node-types section still lists map `shop`

## 2. Roster and run party model (game repo)

- [ ] 2.1 Extend seed roster data with `pancake`, `toast`, `egg-scramble` (display names, tags, fantasies) — verify `rg` in `game-project/` shows all six party ids in roster data
- [ ] 2.2 Replace single `starter_id`-only run state with `party_ids` array (cap 6); interim Title Play still sets one id — verify after Play, `RunController` exposes a party array of length 1
- [ ] 2.3 Add `run_currency` (int, debug seed) on `start_run` — verify currency is readable after run start

## 3. Post-battle shop stub (game repo)

- [ ] 3.1 Create `scenes/ui/post_battle_shop.tscn` (or overlay) with three labeled sections: Items, Recruit Hero, Upgrade Hero, plus Continue — verify F6 shows all three categories
- [ ] 3.2 Hook combat victory (harness or phase controller) to open shop before returning to Run — verify winning a stub combat shows shop before map/harness resumes
- [ ] 3.3 Wire Recruit to append a hero id when party size < 6 and currency allows; wire Upgrade to mark a party member upgraded — verify recruit blocked at 6 members
- [ ] 3.4 Boss victory: open shop, then set run outcome `win` only after Continue — verify boss win does not immediately end run before shop dismiss

## 4. Character select (game repo — after shop stub)

- [ ] 4.1 Create `scenes/ui/character_select.tscn` listing unlocked roster (all six until unlockables exist) with pick-3 confirm — verify confirm disabled until exactly 3 selected
- [ ] 4.2 Wire confirmed select to `start_run` with three ids, then transition to run destination — verify run party length is 3 after confirm
- [ ] 4.3 Document in harness or title that Title Play still uses 1-starter until explicitly rewired — verify Play path unchanged until operator opts in

## 5. Integration checks

- [ ] 5.1 Run `openspec validate squad-select-post-battle-shop` in meta repo — verify output reports valid
- [ ] 5.2 Playtest script: start run → stub combat win → shop recruit → continue → party size increased — verify party count on harness label or debug output
