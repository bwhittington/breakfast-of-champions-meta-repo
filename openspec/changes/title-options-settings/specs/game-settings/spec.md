## Purpose

Owns persistent player preferences for audio mix, display (window mode and resolution), and graphics quality so the game applies the last chosen settings across launches.

## ADDED Requirements

### Requirement: Settings persist across launches
The system MUST store player settings in durable local storage and MUST load them on cold launch before the title hub accepts Options input. Missing or corrupt storage MUST fall back to defaults without crashing.

#### Scenario: Relaunch restores volumes
- **WHEN** the player sets Master, Music, and SFX volumes then quits and cold-launches again
- **THEN** the system MUST restore those three volume levels and MUST apply them to playback

#### Scenario: Corrupt store uses defaults
- **WHEN** saved settings are missing or unreadable on cold launch
- **THEN** the system MUST apply default settings and MUST remain playable

### Requirement: Audio channels are adjustable
The system MUST expose Master, Music, and SFX volume controls as independent levels from 0% through 100%. Changing a control MUST apply that channel’s level immediately (no restart required).

#### Scenario: Lower SFX while panel is open
- **WHEN** the player lowers the SFX control while audio can play
- **THEN** subsequent SFX MUST play quieter (or silent at 0%) without restarting the game

### Requirement: Window mode and resolution are adjustable
The system MUST let the player choose window mode among Fullscreen, Borderless, and Windowed. The system MUST offer a curated list of common 16:9 resolution presets, filtered to modes the current monitor supports. Changing window mode or resolution MUST apply on selection (no restart required for the change to take effect).

#### Scenario: Select windowed preset
- **WHEN** the player selects Windowed and a supported resolution preset
- **THEN** the game window MUST adopt that mode and size without requiring a full application restart

#### Scenario: Unsupported modes are not offered
- **WHEN** the resolution list is shown
- **THEN** the system MUST NOT list presets the current monitor cannot support

### Requirement: Graphics quality preset
The system MUST offer Low, Medium, and High graphics quality presets. Selecting a preset MUST apply the mapped graphics settings immediately where the engine allows (no restart required when apply is possible). Defaults MUST be Medium when no saved quality exists.

#### Scenario: Switch to Low
- **WHEN** the player selects the Low quality preset
- **THEN** the system MUST apply the Low mapping without requiring a restart when the engine can apply it live

#### Scenario: Default quality on first run
- **WHEN** the player has never saved a quality preset
- **THEN** the active quality MUST be Medium
