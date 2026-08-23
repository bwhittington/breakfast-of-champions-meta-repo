## Context

See `proposal.md` for motivation. Title hub already has an Options plank that opens a stub panel (`title-hub-concept-fidelity` / `kitchen-title-menu`). No settings store or audio/display apply path exists yet. Implementation target: `bwhittington/breakfast-of-champions` (`game-project/`). Canonical session flow still starts at Title / Hub (`specs/canonical/game_loop.md`); this change is meta/boot UI only.

## Goals / Non-Goals

**Goals:**

- One Autoload (or equivalent) that loads/saves settings and applies audio, display, and quality.
- Title Options panel wired to that store; dismiss restores plank focus.
- Persist under `user://` so cold launch restores last choices.

**Non-Goals:**

- Pause menu / in-run settings entry.
- Custom typed resolutions, keybinding, language, accessibility beyond these controls.
- Perfect art fidelity for the panel chrome (readable kitchen/parchment-adjacent is enough).

## Decisions

### 1. Autoload `GameSettings` + ConfigFile

- **Choice:** Autoload script (e.g. `scripts/meta/game_settings.gd`) registered in `project.godot`. Persist with Godot `ConfigFile` at `user://game_settings.cfg` (or similar). Sections: `audio`, `display`, `graphics`. Call `load_and_apply()` early in boot (splash `_ready` or autoload `_ready`) so volumes/window are correct before Options opens.
- **Why:** Single owner for apply + persist; survives scene changes; matches Godot norms.
- **Alternatives:** Save only from the panel — rejected (boot would miss apply). JSON resource — ConfigFile is enough.

### 2. Audio buses: Master / Music / SFX

- **Choice:** Drive three named buses (`Master`, `Music`, `SFX`) via `AudioServer.set_bus_volume_db` (linear 0–1 UI ↔ dB). Ensure bus layout exists in the project (create Music/SFX under Master if missing). Sliders write live and debounce-save (or save on change + on panel close).
- **Why:** Spec requires three independent channels and immediate apply.
- **Alternatives:** One Master-only bus — rejected by groom. Per-stream volume — overkill.

### 3. Display: mode enum + curated 16:9 presets

- **Choice:** Window modes map to `DisplayServer.WINDOW_MODE_FULLSCREEN`, `WINDOW_MODE_EXCLUSIVE_FULLSCREEN` or borderless fullscreen via `WINDOW_MODE_FULLSCREEN` + borderless flag as appropriate for Godot 4.3, and `WINDOW_MODE_WINDOWED`. Resolution dropdown lists common 16:9 sizes (e.g. 1280×720, 1600×900, 1920×1080, 2560×1440, 3840×2160) filtered by `DisplayServer.screen_get_size` / available modes. On select: set mode then `window_set_size` / center when windowed. Brief non-blocking “Applying…” state optional; no confirm dialog in v1.
- **Why:** Matches groomed display scope; avoids free-form width×height.
- **Alternatives:** Fullscreen toggle only — rejected. OS native resolution picker — heavier, defer.

### 4. Quality preset → small ProjectSettings / Viewport knobs

- **Choice:** Enum `low|medium|high` maps to a fixed table, for example:
  - **Low:** MSAA off, shadows low/off, reduced glow/FX
  - **Medium:** light MSAA or FXAA, medium shadows
  - **High:** higher MSAA, better shadows, full FX
  Apply via Viewport/`RenderingServer` settings the project already uses; document the exact keys in code comments. Default **Medium**.
- **Why:** Spec wants three presets, immediate apply where possible—not a graphics kitchen sink.
- **Alternatives:** Individual toggles — out of scope. Restart-required quality — rejected by groom.

### 5. Options panel as modal child of title hub

- **Choice:** Replace stub Options UI with a `Control`/`Panel` overlay on the title scene: sections for Audio, Display, Graphics; Close/Back. Pointer + focus neighbors for gamepad. Opening Options steals focus from planks; dismiss restores last plank focus (Options).
- **Why:** Spec binds entry to the Options plank; no fifth plank.
- **Alternatives:** Separate settings scene — unnecessary scene churn for v1.

### 6. Defaults

- **Choice:** Master/Music/SFX = 1.0; window mode = windowed at a safe preset ≤ current screen (or fullscreen if that is the project default today—prefer windowed for editor-friendly first run); quality = Medium.
- **Why:** Safe first-run; Medium is the groomed default.

## Risks / Trade-offs

- **[Risk] Borderless vs exclusive fullscreen differs by OS** → Mitigation: map to Godot 4.3 DisplayServer modes; smoke-test Windows; document known quirks in tasks.
- **[Risk] Resolution change leaves window off-screen** → Mitigation: clamp/center after resize; if apply fails, revert to previous saved mode/size.
- **[Risk] Quality knobs no-op if project never enabled those features** → Mitigation: map only to settings that exist; Medium/Low/High still persist for future rendering work.
- **[Risk] Saving every slider tick causes disk churn** → Mitigation: apply live; persist on release, timer debounce, or panel close.
- **[Trade-off] Panel art may be simpler than the painted tableau** → Acceptable if controls are clear and dismissible.

## Migration Plan

1. Meta: this OpenSpec change (already proposed).
2. Game: add Autoload + config path; wire Options panel; ensure audio buses; apply on boot.
3. Rollback: restore stub Options panel; remove Autoload registration; delete `user://` config optionally (player-side).

## Open Questions

- Exact MSAA/shadow/FX keys for the quality table — finalize against `project.godot` at apply time once the live rendering features are known.
- Whether Music/SFX buses already exist in the game project — create if missing during apply.
