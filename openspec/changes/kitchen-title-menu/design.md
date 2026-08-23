## Context

See `proposal.md` for motivation and `specs/title-hub/spec.md` / `specs/characters/spec.md` for behavior. Canonical session flow still lists Title / Hub then character select (`specs/canonical/game_loop.md`); this change implements the hub and **skips** select. Splash already owns `application/run/main_scene` (`scenes/boot/studio_splash.tscn`) and hands off via `post_boot_scene`, currently `scenes/debug/phase_harness.tscn`. `RunController` is an autoload with `start_run()`; the harness does not store enemy ids today.

Target implementation: `bwhittington/breakfast-of-champions` (`game-project/`). Canonical seed tables live in the meta repo (`specs/canonical/characters.md`).

## Goals / Non-Goals

**Goals:**

- Painted tableau + overlay UI that stays clickable/focusable.
- Splash → title → Play starts a run and opens the existing harness.
- Seed identity tables in canonical + a machine-readable roster the harness can show if needed.
- Placeholder mascot motion without a new animation toolchain.

**Non-Goals:**

- Replacing the phase harness as the run debug surface.
- Party HP, skills, or combat scenes.
- Map DAG or parchment-driven navigation.

## Decisions

### 1. Full-bleed raster + Control overlay (not a rebuilt diorama)

- **Choice:** Import the operator concept into `game-project/assets/ui/kitchen_title.png` (or `.jpg`). Root `TextureRect` with `keep_aspect_covered` (letterbox only if covered crop hides the wordmark too much). Overlay a `Control` for planks and a `mouse_filter` ignore region over the parchment.
- **Why:** Spec requires fidelity to the painting; node-recreating the kitchen is out of scope.
- **Alternatives:** Nine-slice kitchen tiles — rejected. Full Spine scene — out of scope.

### 2. Planks as real Buttons in a bottom-left safe rect

- **Choice:** Four `Button`s (or `TextureButton`s) in a `MarginContainer` anchored bottom-left. Labels **Play Game / Unlockables / Options / Quit**. Unlockables `disabled` (or click shows a coming-soon label and stays on title). Options is a child `Panel`/`Window` with dummy sliders and Close. Quit calls `get_tree().quit()`. Do not place a `Label` for the game title.
- **Why:** Safe-area and focus-neighbor graphs are native if the planks are Controls, not baked into the PNG.
- **Alternatives:** Invisible click zones only — worse for gamepad. World-space 3D planks — overkill.

### 3. Mascot idles as overlay sprites + AnimationPlayer

- **Choice:** Cutout or placeholder `Sprite2D`s (or `TextureRect`s) for bacon, espresso, cereal, fried eggs, positioned over the painting. Looping `AnimationPlayer` (or tween) tracks: punch pair, wave, scurry. `mouse_filter` ignore so they never steal plank clicks.
- **Why:** Spec requires looping motion now; sheets can replace textures later without changing the scene contract.
- **Alternatives:** Animate the whole PNG — cannot isolate characters. Wait for Spine — violates the idle requirement.

### 4. Play: `start_run` then harness scene

- **Choice:** Play calls `RunController.start_run()` (extend with optional `starter_id` defaulting to `cereal` if no party field exists) then `change_scene_to_file` to `res://scenes/debug/phase_harness.tscn`. Do **not** call `start_run()` again in harness `_ready`. Keep harness Start Run button for debug resets.
- **Why:** Autoload survives the scene change; player-facing Play must leave phase `run` with one starter.
- **Alternatives:** Stay on title and embed harness — mixes debug HUD into the poster. Skip harness and invent a map scene — out of scope.

### 5. Seed roster as data + canonical amend

- **Choice:** Amend `specs/canonical/characters.md` party/enemy seed tables in the **meta** repo. In the **game** repo, add a small data script or Resource (`scripts/characters/seed_roster.gd` or `data/characters/seed_roster.tres`) listing the live ids. If the harness (or comments) mention retired ids, update them. No skill math.
- **Why:** Spec is identity-only; both humans and stubs need one list.
- **Default starter:** `cereal` until character select exists.
- **Alternatives:** Hard-code ids only in the title script — harness and future combat would drift.

### 6. Dual-repo task split

- **Choice:** Meta commits: OpenSpec change + canonical `characters.md` (and a one-line session-flow note in `game_loop.md` that Play may skip select until that UI exists). Game commits: scenes, assets, splash export, roster resource.
- **Why:** Workspace git boundary; never mix remotes in one operation.

## Risks / Trade-offs

- **[Risk] `keep_aspect_covered` crops planks painted in the raster** → Mitigation: overlay Buttons in a safe rect; painted planks are backdrop only.
- **[Risk] Overlay sprites drift off the painting at other aspect ratios** → Mitigation: place overlays in the same container as the art with proportional offsets; accept small drift until a layered diorama change.
- **[Risk] `start_run()` twice (Play + harness Ready)** → Mitigation: harness `_ready` must only refresh labels.
- **[Risk] Retired ids linger in comments/docs** → Mitigation: grep game + canonical for old keys in tasks.
- **[Trade-off] Placeholder motion looks cheap vs the painting** → Acceptable for this slice; sheets can drop in.

## Migration Plan

1. Meta: canonical seed tables + this OpenSpec change.
2. Game: title scene, asset, splash `post_boot_scene`, roster data, Play → harness.
3. Rollback: restore `post_boot_scene` to the harness; remove title scene/asset; revert canonical tables.

## Open Questions

- Exact export format of the operator concept (png vs jpg, resolution) — importer settings at apply time.
- Whether Options stub toggles real `DisplayServer.window_set_mode` for fullscreen — allowed if trivial; persistence still out of scope.
