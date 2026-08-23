## 1. Tableau art (game repo)

- [ ] 1.1 Replace `game-project/assets/ui/kitchen_title.png` with the operator kitchen-title concept (grooming image 1) and reimport — verify F6 on `kitchen_title.tscn` shows that painting full-bleed or letterboxed, with the painted wordmark and plank labels readable
- [ ] 1.2 Confirm stretch does not crop **Play Game** or the wordmark at 1280×720; switch Tableau off `keep_aspect_covered` to letterbox if needed — verify Play plank stays on-screen
- [ ] 1.3 Spot-check 16:10 or fullscreen — verify painted planks and wordmark remain visible and hittable

## 2. Painted plank hitboxes (game repo)

- [ ] 2.1 Clear the four title Button `text` values and replace brown `StyleBoxFlat` skins with transparent `normal` plus no-fill gold/amber outline on hover/focus/pressed — verify idle title shows only painted plank labels, no duplicate brown button stack
- [ ] 2.2 Reposition each Button rect to the matching painted plank (do not keep a misaligned generic VBox) — verify pointer hover outline sits on the painted wood, not in empty table space
- [ ] 2.3 Keep focus neighbors and default focus on Play — verify keyboard/gamepad can move among the four planks and confirm Play still starts a run
- [ ] 2.4 Keep Unlockables coming-soon and Options stub/Close (Close may stay a visible button) — verify Unlockables does not start a run and Options dismisses back to title without covering the painted planks as a second menu

## 3. Concept cutouts (game repo)

- [ ] 3.1 Remove `IdleBacon` / `IdleCereal` / `IdleEspresso` / `IdleFriedEggs` and their placeholder textures from the title scene; delete unused `idle_*.png` assets — verify no untextured circles, blocks, or mismatched overlay mascots remain
- [ ] 3.2 Add cutouts taken from the same concept (at least waffle bob/drip and espresso steam; a third champion if the silhouette cuts cleanly), parented with the Tableau, `mouse_filter` ignore — verify they sit on the painted figures, not floating in empty air
- [ ] 3.3 Replace boxing/waving/scurrying tweens with looping in-pose motion (steam, drip, bob, or breathe) — verify after several seconds the loop still runs and Play still clicks through

## 4. Smoke and hand-off (game repo)

- [ ] 4.1 Confirm `studio_splash` `post_boot_scene` still points at `kitchen_title.tscn` and `main_scene` remains the splash — verify cold F5: splash → concept title
- [ ] 4.2 Update `kitchen_title_smoke.gd` if node/style checks need to assert empty plank text / no idle placeholder paths — verify `godot --headless --path game-project -s res://scripts/ui/kitchen_title_smoke.gd` still passes Play → `start_run` + harness
