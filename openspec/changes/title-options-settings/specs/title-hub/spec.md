## Purpose

Kitchen Title / Hub after studio splash: painted plank menu including Options that opens real, dismissible game settings instead of a non-persistent stub.

## ADDED Requirements

### Requirement: Options opens the settings panel
When the player activates the **Options** plank on the title hub, the system MUST show the game settings panel (audio, display, graphics quality). The panel MUST be dismissible so the player returns to the title hub. This requirement supersedes prior title-hub deltas that allowed a non-persistent Options stub and did not require saving settings.

#### Scenario: Options shows settings controls
- **WHEN** the player activates **Options** from the title hub
- **THEN** the system MUST show Master, Music, and SFX volume controls, window mode and resolution controls, and a Low / Medium / High graphics quality control
- **THEN** the system MUST NOT present Options as a non-interactive placeholder-only stub

#### Scenario: Dismiss returns to title hub
- **WHEN** the settings panel is open and the player dismisses it (close / back / equivalent)
- **THEN** the title hub MUST be the active interactive scene again
- **THEN** the four plank actions MUST remain operable

### Requirement: Settings panel is keyboard and gamepad operable
While the settings panel has focus, the system MUST allow keyboard and gamepad navigation among its controls and MUST allow dismiss without requiring a pointer.

#### Scenario: Gamepad dismisses Options
- **WHEN** the settings panel is open and the player uses the cancel/back control via gamepad or keyboard
- **THEN** the system MUST close the panel and restore title-hub plank focus
