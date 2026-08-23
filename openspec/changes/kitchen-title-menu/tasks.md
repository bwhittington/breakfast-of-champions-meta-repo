## 1. Canonical seed identity (meta repo)

- [ ] 1.1 Update `specs/canonical/characters.md` starter party to `cereal`, `waffle`, `bacon` (display names + one-line fantasies; drop `egg-scramble`, `pancake`, party-`toast`) — verify the party table lists only those three ids
- [ ] 1.2 Update `specs/canonical/characters.md` enemy seed to `espresso-mug`, `burnt-toast`, `fried-egg`, keep `kitchen-timer` as Oven Boss; remove `burnt-crumb`, `sour-milk`, `hangry-waffle` — verify retired ids are gone from the live tables
- [ ] 1.3 Add a session-flow note in `specs/canonical/game_loop.md` that Title **Play Game** starts a run with one starter and skips character select until that UI exists — verify the Title / Hub section still precedes Run start

## 2. Title art and scene (game repo)

- [ ] 2.1 Copy the operator kitchen-menu concept into `game-project/assets/ui/kitchen_title.png` (or `.jpg`) and import in Godot — verify the texture opens in the FileSystem dock without errors
- [ ] 2.2 Create `game-project/scenes/ui/kitchen_title.tscn` with full-rect tableau `TextureRect` (`keep_aspect_covered` or letterbox if the wordmark would otherwise crop) and **no** extra title `Label` — verify F6 shows **BREAKFAST OF CHAMPIONS** only as painted art
- [ ] 2.3 Add a non-interactive parchment region (`mouse_filter` ignore) — verify clicks on the map area do not change scene or start a run

## 3. Plank UI (game repo)

- [ ] 3.1 Add bottom-left safe-rect **Play Game**, **Unlockables**, **Options**, **Quit** buttons with focus neighbors for keyboard/gamepad — verify 1280×720 and a wider window still show Play, and Tab/arrows move focus
- [ ] 3.2 Wire Unlockables as disabled and/or coming-soon that stays on the title — verify it does not start a run or persist unlocks
- [ ] 3.3 Add a dismissible Options stub panel (placeholders ok; persistence not required) — verify Open then Close returns to the title with planks usable
- [ ] 3.4 Wire Quit to exit the application — verify Quit closes the game from the title

## 4. Mascot idles (game repo)

- [ ] 4.1 Overlay ignore-mouse sprites (placeholders ok) for bacon, espresso, cereal, and fried eggs with looping AnimationPlayer/tween: shadow-box, wave, scurry — verify all four motions loop for several seconds
- [ ] 4.2 Confirm idles do not steal clicks — verify Play still activates while animations run

## 5. Roster data, Play, and boot hand-off (game repo)

- [ ] 5.1 Add `seed_roster` data (script or Resource) with live party/enemy ids matching canonical; default starter `cereal` — verify no live use of retired ids (`rg` in `game-project/` for `egg-scramble`, `pancake`, `burnt-crumb`, `sour-milk`, `hangry-waffle`)
- [ ] 5.2 Extend `RunController.start_run` to record a single `starter_id` (default `cereal`) without adding skill/HP systems — verify after Play the run phase is `run` and starter is one seed party id
- [ ] 5.3 Title Play calls `start_run` then `change_scene_to_file` to `res://scenes/debug/phase_harness.tscn`; harness `_ready` must not auto-`start_run` — verify Play lands on the harness already in `run`, and harness Start Run still works as a debug reset
- [ ] 5.4 Set splash `post_boot_scene` to `res://scenes/ui/kitchen_title.tscn` (keep `main_scene` as splash) — verify cold F5: splash → kitchen title, not harness first
