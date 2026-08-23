## 1. Remove duplicate full-body cutouts (game repo)

- [ ] 1.1 Remove or hide `CutoutWaffle`, `CutoutBacon`, and `CutoutEspresso` from `kitchen_title.tscn` — verify F6 shows single Waffle/Bacon/Espresso figures from tableau only (no circular lens overlay)
- [ ] 1.2 Remove waffle/bacon/espresso tweens from `kitchen_title.gd`; keep steam-only motion if `CutoutSteam` remains — verify no `_bob`/`_breathe` on full-body cutouts after several seconds
- [ ] 1.3 Re-align or remove `CutoutSteam` if circular alpha fringe still visible — verify no vignette/lens artifact over champions

## 2. Asset cleanup (game repo)

- [ ] 2.1 Delete unused `cutout_waffle.png`, `cutout_bacon.png`, `cutout_espresso.png` if unreferenced — verify Godot FileSystem has no broken imports
- [ ] 2.2 Keep `kitchen_title.png` as sole source for static champion art — verify scene references only tableau + optional steam partial

## 3. Smoke and acceptance (game repo)

- [ ] 3.1 Update `kitchen_title_smoke.gd` to fail if full-body cutout nodes `%CutoutWaffle`, `%CutoutBacon`, or `%CutoutEspresso` are present and visible — verify headless smoke passes
- [ ] 3.2 Manual cold boot: splash → title; confirm no duplicate champion labels/bodies and Play still works — verify against operator screenshot symptom

## 4. Validation (meta repo)

- [ ] 4.1 Run `openspec validate fix-title-cutout-double-vision` — verify valid
