## Context

See `proposal.md` for motivation. Operator-supplied splash art (Binary Deli microwave / cyber-sub) is the visual source of truth. Implementation targets Godot 4.3 in `game-project/` (`bwhittington/breakfast-of-champions`). Session flow in `specs/canonical/game_loop.md` starts at Title/Hub — this splash inserts **before** that. Parallel change `run-vs-combat-phase-controller` may set a debug harness as main; this design owns boot and hands off to that harness (or a future title) after load.

## Goals / Non-Goals

**Goals:**

- Faithful presentation of the provided splash image (full-bleed / letterboxed, not cropped awkwardly).
- Loading feedback as the **on-door microwave clock** counting down to `0:00`, not a generic horizontal bar.
- Configurable total countdown duration mapped from a 0.0–1.0 progress signal.
- Clean hand-off to `post_boot_scene` path set in the splash script or project setting.

**Non-Goals:**

- Procedural redraw of the microwave in Control nodes; raster art is primary.
- Making panel buttons functional.
- Streaming/threaded ResourceLoader complexity beyond a simple progress driver (fake-smooth progress OK for v1 if real loads are instant).

## Decisions

### 1. Raster splash as full-screen TextureRect

- **Choice:** Import the provided PNG into `game-project/assets/branding/binary_deli_splash.png` and display it full-rect with `keep_aspect_covered` or letterbox on a dark `#0a0a12`-ish clear color matching the art.
- **Why:** Matches the approved brand frame exactly; avoids drift from hand-rebuilt UI.
- **Alternatives:** Rebuild with Godot nodes — rejected for v1 (costly, will mismatch).

### 2. Timer is an overlay Label (or two), not a second progress bar

- **Choice:** Position a pixel/digital-style `Label` over the art’s timer region (top-right of the microwave window) showing `M:SS`, plus a small `BD` label under it. Update text from progress; do **not** add a separate horizontal ProgressBar.
- **Why:** Operator asked for a loading bar *designed like* a microwave timer — the clock *is* the bar.
- **Alternatives:** Hide art’s baked `0:00` by cropping — harder; overlay with opaque backing plate behind digits if baked pixels fight the live text.
- **Assumption:** If baked `0:00` in the PNG conflicts, cover that region with a small ColorRect + live labels (cyan/green neon to match art).

### 3. Progress → remaining time mapping

- **Choice:** `remaining = ceil(total_seconds * (1.0 - clamp(progress, 0, 1)))`, format as `M:SS`. Default `total_seconds = 5` (exported). At `progress >= 1.0`, force `0:00`, wait `settle_delay` (~0.35s), then `change_scene_to_file(post_boot_scene)`.
- **Why:** Monotonic countdown; easy to tune; works with fake or real progress.
- **Alternatives:** Wall-clock independent of progress — rejected (can hit 0:00 before load finishes).

### 4. Boot progress driver (v1)

- **Choice:** Splash script runs a short simulated load curve (or polls `ResourceLoader` if preloading the next scene) and feeds `progress` each frame.
- **Why:** Project has little to load today; simulation still exercises the timer UX. Swap driver later without changing requirements.
- **Alternatives:** Block until user presses START — out of scope (non-goal).

### 5. Main scene ownership

- **Choice:** `application/run/main_scene` = splash. Exported `post_boot_scene` defaults to the phase harness path when that exists, else a placeholder title stub path documented in tasks.
- **Why:** Guarantees splash-first cold launch per spec.
- **Conflict note:** Coordinate with `run-vs-combat-phase-controller` so harness is the hand-off target, not a rival main_scene.

## Risks / Trade-offs

- **[Risk] Baked timer digits clash with live Label** → Mitigation: mask plate over timer region; match font size/color to art.
- **[Risk] Aspect ratios crop the tagline** → Mitigation: letterbox preferred over crop; test 16:9 and 16:10.
- **[Risk] Instant loads make countdown invisible** → Mitigation: minimum splash duration = `total_seconds` mapped with smooth ease so brand always reads.

## Migration Plan

1. Add asset + splash scene; point main_scene at splash.
2. Set `post_boot_scene` to current gameplay/debug entry.
3. Rollback: restore previous main_scene; remove splash scene/asset if needed.

## Open Questions

- Exact minimum splash duration vs true load time preference if loads become long later — default keep mapping to real progress with a floor of ~2s brand time; revisit when asset volume grows.
