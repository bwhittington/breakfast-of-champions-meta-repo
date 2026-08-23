## 1. Settings store Autoload

- [ ] 1.1 Add `game-project/scripts/meta/game_settings.gd` as Autoload `GameSettings` with load/save via `ConfigFile` at `user://game_settings.cfg` (sections `audio`, `display`, `graphics`) and defaults (volumes 1.0, windowed safe preset, quality Medium) — verify Godot loads the project and the Autoload appears in Project Settings
- [ ] 1.2 Implement `load_and_apply()` on Autoload ready (and callable after panel edits) that applies audio, display, and quality; on missing/corrupt file use defaults without error spam — verify cold launch with no config file still reaches the title hub

## 2. Audio buses and apply

- [ ] 2.1 Ensure Master / Music / SFX buses exist in the project bus layout (create Music and SFX under Master if missing) — verify Audio bus editor shows three usable buses
- [ ] 2.2 Wire Master / Music / SFX linear 0–1 levels to `AudioServer` bus volume (dB) with immediate apply and persist on change or panel close — verify moving SFX to 0 silences SFX while Music can remain audible

## 3. Display and quality apply

- [ ] 3.1 Implement window mode (Fullscreen / Borderless / Windowed) + curated 16:9 resolution presets filtered to the current monitor; apply on selection and center/clamp windowed size — verify selecting Windowed + a supported preset changes the window without restart
- [ ] 3.2 Implement Low / Medium / High quality preset mapping to the project’s available MSAA/shadow/FX knobs (document keys in code); default Medium; apply live where possible — verify changing preset persists in config and reloads after relaunch

## 4. Title Options panel

- [ ] 4.1 Replace the title-hub Options stub with a dismissible settings panel exposing Master/Music/SFX sliders, window mode, resolution dropdown, and quality preset — verify Options plank opens the panel with those controls
- [ ] 4.2 Bind panel controls to `GameSettings` (live apply + save) and Close/Back dismisses to title hub restoring plank focus — verify dismiss returns operable Play / Unlockables / Options / Quit planks
- [ ] 4.3 Add keyboard/gamepad focus neighbors for panel controls and cancel/back to dismiss — verify gamepad or keyboard can adjust a slider and dismiss without a mouse

## 5. Persistence smoke

- [ ] 5.1 Change volumes, window mode/resolution, and quality; quit; cold launch — verify all three categories restore and apply before Options is needed again
