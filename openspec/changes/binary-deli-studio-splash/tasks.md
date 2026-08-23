## 1. Branding asset (game repo)

- [ ] 1.1 Copy the operator splash PNG into `game-project/assets/branding/binary_deli_splash.png` and import in Godot (filter off / nearest for pixel look) — verify the texture opens in the FileSystem dock without errors
- [ ] 1.2 Confirm art shows microwave, **BINARY DELI STUDIOS**, and **JACK IN, EAT OUT.** at readable size on a 1280×720 test window — verify no critical crop of title/tagline

## 2. Splash scene + microwave timer (game repo)

- [ ] 2.1 Create `game-project/scenes/boot/studio_splash.tscn` with full-rect splash `TextureRect` on a dark clear color — verify F6 on the scene shows the art
- [ ] 2.2 Add overlay timer UI (`M:SS` + `BD`) positioned over the microwave door clock region, with a small mask plate if baked `0:00` fights live text — verify labels are readable against the art
- [ ] 2.3 Implement splash script: map `progress` 0→1 to remaining seconds (`total_seconds` exported, default 5), format `M:SS`, monotonic updates, force `0:00` at completion — verify driving progress in-editor updates the clock correctly
- [ ] 2.4 On progress complete + short settle delay, `change_scene_to_file(post_boot_scene)` — verify hand-off leaves the splash

## 3. Boot wiring (game repo)

- [ ] 3.1 Set `application/run/main_scene` to `studio_splash.tscn` and point `post_boot_scene` at the current post-boot target (phase harness if present, else a minimal placeholder scene) — verify cold F5 shows splash before the next scene
- [ ] 3.2 Manually confirm cold boot: timer counts down to `0:00`, then next scene loads; remaining time never increases mid-boot — verify against delta scenarios
