## 1. Diagnose and restore art (game repo)

- [ ] 1.1 Reproduce black/timer-only boot on current `main` splash scene and note whether `SplashArt` texture is assigned, imported, and drawn — verify with editor remote scene tree / visible rect
- [ ] 1.2 Fix splash so `binary_deli_splash.png` is visible full-bleed (or letterboxed) for the entire countdown alongside the timer overlay — verify first readable frame shows microwave art + title/tagline, not black-only digits
- [ ] 1.3 Confirm timer `M:SS` + `BD` remain overlaid on the door region while art is visible — verify mid-countdown screenshot/playtest

## 2. Timing and fade (game repo)

- [ ] 2.1 Set default combined countdown to ~2.5s (`total_seconds` in 2–3s range) — verify timer hits `0:00` about 2.5s after splash start
- [ ] 2.2 Implement 2.0s full-viewport fade to black starting at `0:00`, then `change_scene_to_file(post_boot_scene)` (harness) — verify no instant cut to harness at zero
- [ ] 2.3 Cold F5 / `godot --path` acceptance: art+timer together → fade → harness; remaining time never increases — verify against delta scenarios
