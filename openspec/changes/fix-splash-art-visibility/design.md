## Context

See `proposal.md`. Operator playtest: black viewport + floating timer only; art missing for most of boot. Existing scene has `TextureRect` + timer overlay and a ~5s simulated load; clear color is near-black `#0a0a12`. Spec intent from `binary-deli-studio-splash` still stands; this change fixes the broken presentation and adds a post-zero fade.

## Goals / Non-Goals

**Goals:**

- Art visible from first readable frame through end of countdown.
- Timer overlay stays on the door region of that art.
- Default countdown ~2.5s; after `0:00`, 2.0s full-viewport fade to black; then `change_scene_to_file(post_boot_scene)`.
- Minimal diff; diagnose TextureRect/import/stretch/layering before rewriting the scene.

**Non-Goals:**

- New VFX beyond fade; interactive microwave buttons; changing harness as post-boot target.

## Decisions

### 1. Treat missing art as a display bug, not a new composition

- **Choice:** Keep raster `binary_deli_splash.png` + overlay labels; fix why `SplashArt` does not show (import, modulate, z-order, anchors, stretch, filter, or load timing).
- **Why:** Approved brand art already in repo; redesign out of scope.
- **Alternatives:** Rebuild splash in nodes — rejected for this fix.

### 2. Shorten `total_seconds` default to 2.5

- **Choice:** `@export var total_seconds := 2.5` (allow 2.0–3.0).
- **Why:** Operator chose shorter combined beat (option 4C).

### 3. Replace instant settle with a 2s fade-to-black

- **Choice:** On `0:00`, run a 2.0s tween/fade (full-screen ColorRect or modulate on root) from transparent/black-0 to opaque black, then hand off. Remove or subsume the old 0.35s settle delay into this fade.
- **Why:** Operator-requested blackout beat before harness.
- **Alternatives:** Fade only the art — rejected; full viewport fade specified.

### 4. Keep post_boot_scene = phase harness

- **Choice:** Do not change hand-off target in this change.
- **Why:** Out of scope; already wired on main.

## Risks / Trade-offs

- **[Risk] Art fails only in exported builds** → Mitigation: verify both editor F5 and `godot --path` run; check `.import` committed.
- **[Risk] Fade feels like “more black bug”** → Mitigation: art must be clearly visible for the full 2.5s before fade starts; AC calls that out.
- **[Risk] Two open splash deltas** (`binary-deli-studio-splash` unarchived + this fix) → Mitigation: this delta is the player-facing source of truth for boot UX going forward; archive/sync later in order.

## Migration Plan

1. Ship fix on game repo feature branch → PR → merge.
2. No data migration.
3. Rollback: revert splash script/scene to pre-fix commit.

## Open Questions

- None material; default 2.5s locked unless operator overrides at apply time.
