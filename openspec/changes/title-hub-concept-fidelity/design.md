## Context

See `proposal.md` for motivation and `specs/title-hub/spec.md` for behavior. The kitchen title already exists in the game repo: `scenes/ui/kitchen_title.tscn`, `scripts/ui/kitchen_title.gd`, `assets/ui/kitchen_title.png`, plus placeholder `idle_*.png` overlays. Studio splash already hands off via `post_boot_scene` to the title scene. This change is presentation-only: keep Play / Unlockables / Options / Quit wiring, swap the tableau to the operator concept, and stop drawing a second UI layer that fights the painting.

## Goals / Non-Goals

**Goals:**

- Concept raster is the plate; Controls exist only for hit, focus, and a glow/outline on the painted planks.
- Cutout motion stays in pose and is sourced from that same raster.
- Existing smoke checks for Play → `start_run` + harness still pass.

**Non-Goals:**

- Changing splash timing, splash art, or `main_scene`.
- New animation toolchain (Spine/Aseprite pipeline).
- Rebuilding the kitchen as a node diorama.

## Decisions

### 1. Replace `kitchen_title.png` with the operator concept

- **Choice:** Import the approved concept (image 1 from grooming) as `game-project/assets/ui/kitchen_title.png` (or same path, new file). Keep `TextureRect` `expand_mode` / `keep_aspect_covered` (`stretch_mode` 6) unless crop hides the wordmark or Play plank; then letterbox instead of covering those regions.
- **Why:** Spec requires the concept as the tableau, not the current kitchen plate that already contains a painted menu the overlay fights.
- **Alternatives:** Keep current PNG and only restyle buttons — rejected; operator chose the first concept as the plate.

### 2. Invisible Buttons aligned to painted planks

- **Choice:** Keep four `Button` nodes for focus neighbors and activation. Clear `text`. Use a fully transparent `StyleBoxEmpty` (or 0-alpha flat) for `normal`. Hover/focus/pressed use a **no-fill** glow or outline (`StyleBoxFlat` with transparent `bg_color`, gold/amber border, optional shadow). Reposition `PlankSafe` so each button’s rect matches the painted plank in the new raster; do not keep a generic stacked VBox if it no longer lines up.
- **Why:** Gamepad/keyboard still need Controls; the look must be the painting.
- **Alternatives:** TextureButtons with plank skins — rejected (second set of labels). Area2D click zones — worse for `ui_focus`.

### 3. Cutouts from the concept; drop placeholder idle PNGs

- **Choice:** Cut at least waffle (butter drip / bob), espresso (steam), and one more champion that reads cleanly from the concept. Place `Sprite2D`/`TextureRect` cutouts over the matching painted figures. Loop small `position`/`scale`/`modulate` tweens (breathe, drip, steam puff). Remove `idle_bacon.png`, `idle_cereal.png`, `idle_espresso.png`, `idle_fried_eggs.png` from the scene (delete unused assets if nothing else references them). `mouse_filter` ignore so cutouts never steal plank clicks.
- **Why:** Spec forbids placeholder overlays and boxing/waving/scurrying as required loops.
- **Alternatives:** Animate the whole PNG — cannot isolate motion. Keep old idle textures — rejected.

### 4. Coming-soon and Options stay modal, not plank skins

- **Choice:** Unlockables still shows a small coming-soon message that does not cover the plank column. Options panel remains a dismissible overlay; its Close button may keep a visible skin because it is not one of the painted planks.
- **Why:** Spec allows a coming-soon message; only the four title planks must stay painted.
- **Alternatives:** Disabled Unlockables with no feedback — weaker UX.

### 5. Dual-repo split

- **Choice:** Meta repo owns this OpenSpec change. Game repo owns scene, script, and art. Do not mix remotes in one commit.
- **Why:** Workspace git boundary.

## Risks / Trade-offs

- **[Risk] `keep_aspect_covered` crops painted planks** → Mitigation: verify Play/Quit stay on-screen at 16:9 and 16:10; switch to letterbox if crop hides a plank.
- **[Risk] Cutouts drift at other aspect ratios** → Mitigation: parent cutouts to the same full-rect container as `Tableau` with proportional anchors; accept small drift until a layered diorama change.
- **[Risk] Transparent buttons are hard to find without a mouse** → Mitigation: default focus on Play plus a visible outline on the focused plank.
- **[Trade-off] Subtle motion is quieter than boxing idles** → Required by the operator; do not restore punch loops.

## Migration Plan

1. Meta: this OpenSpec change (already the planning home).
2. Game: replace tableau, restyle/reposition planks, swap cutouts, update smoke if node names change.
3. Rollback: restore previous `kitchen_title.png`, overlay button styles, and placeholder idle textures.

## Open Questions

- Exact pixel rects of the four planks in the imported concept — set at apply time against the raster.
- Whether waffle, mug steam, and bacon are all cut, or only the two cleanest silhouettes — implementer picks the set that composites cleanly as long as at least one in-pose loop is visible.
