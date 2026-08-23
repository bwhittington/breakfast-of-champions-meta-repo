## Purpose

Presents the kitchen Title / Hub after the studio splash as the operator breakfast-standoff concept: painted menu planks, painted champion labels, and subtle in-pose motion from cutouts of that same painting.

## ADDED Requirements

### Requirement: Title hub follows studio splash
On a cold launch, the system MUST show the studio splash first. After splash hand-off completes, the next player-facing scene MUST be the kitchen title hub. The title hub MUST NOT be the application main/boot scene while a studio splash exists.

#### Scenario: Cold launch lands on title after splash
- **WHEN** the player starts the game from a cold launch and the splash sequence finishes
- **THEN** the next interactive scene MUST be the kitchen title hub (not the debug phase harness as the first post-boot landing)

### Requirement: Kitchen tableau matches the operator concept
The title hub MUST present the operator kitchen-title concept as a full-bleed (or letterboxed) tableau: warm kitchen, toasted **BREAKFAST OF CHAMPIONS** wordmark in the art, painted wooden menu planks, breakfast standoff, and painted champion name labels as they appear in that concept. The system MUST NOT draw a second title string or a second set of character name labels on top of the painting.

#### Scenario: Painted wordmark and names are the only titles
- **WHEN** the title hub is visible
- **THEN** the player MUST see the painted **BREAKFAST OF CHAMPIONS** wordmark and MUST NOT see a duplicate engine-drawn title covering it
- **THEN** the player MUST NOT see a second engine-drawn roster of names covering the painted champion labels

### Requirement: Painted planks are the menu look
The four actions **Play Game**, **Unlockables**, **Options**, and **Quit** MUST read as the wooden planks painted in the concept. The system MUST NOT draw a second set of rectangular button skins or extra plank labels on top of those painted planks. Interactive regions MUST align to the painted planks. Those regions MUST remain hittable in a bottom-left safe area so typical widescreen crop of the tableau does not hide **Play Game**. Hover and keyboard/gamepad focus MUST appear as a glow or outline on the focused painted plank, not as a generic overlay button.

#### Scenario: Menu is not a second button stack
- **WHEN** the title hub is visible and no plank is focused
- **THEN** the player MUST see the painted plank labels as the menu text
- **THEN** the player MUST NOT see a duplicate brown button stack covering those planks

#### Scenario: Focus highlights the painted plank
- **WHEN** the player moves pointer or focus onto **Play Game**
- **THEN** the system MUST show a glow or outline on that painted plank region
- **THEN** the system MUST NOT replace that plank with a separate rectangular button skin

### Requirement: Four plank actions
Activating the four plank regions MUST keep these outcomes: **Play Game** starts a new run (active phase `run`), skips character-select UI, and begins with exactly one party starter; **Unlockables** MUST NOT grant unlocks, persist meta-progression, or start a run, and MUST leave the title hub as the active scene; **Options** MUST show a stub panel the player can dismiss; **Quit** MUST close the application.

#### Scenario: Play starts a run without character select
- **WHEN** the player activates **Play Game** from the title hub
- **THEN** the system MUST start a new run (active phase `run`) and MUST skip character-select UI for this change
- **THEN** the run MUST begin with exactly one party starter

#### Scenario: Unlockables is visible but inert
- **WHEN** the player activates **Unlockables**
- **THEN** the system MUST NOT grant unlocks, persist meta-progression, or start a run
- **THEN** the title hub MUST remain the active scene (disabled control and/or a coming-soon message is sufficient)

#### Scenario: Options opens a stub panel
- **WHEN** the player activates **Options**
- **THEN** the system MUST show a stub options panel the player can dismiss to return to the title hub
- **THEN** the panel MAY include non-persistent placeholders (for example volume or fullscreen) and MUST NOT be required to save settings

#### Scenario: Quit exits the game
- **WHEN** the player activates **Quit** from the title hub
- **THEN** the application MUST close

### Requirement: Keyboard and gamepad can operate planks
While the title hub is active and no modal options panel has stolen focus, the system MUST allow keyboard and gamepad navigation to move focus among the four painted-plank regions and to activate the focused region.

#### Scenario: Gamepad activates Play
- **WHEN** the title hub is showing, a plank is focused via keyboard or gamepad, and the player confirms
- **THEN** the system MUST perform that plank's action (same outcomes as pointer activation)

### Requirement: Parchment map is decoration
The parchment map on the title tableau (including labels such as Bakery Battle, Syrup Swamp, Coffee Cavern, Oven Boss) MUST be non-interactive. The system MUST NOT treat it as a map control or change run-map generation because of those labels.

#### Scenario: Clicking the parchment does nothing
- **WHEN** the player clicks or focuses the parchment region
- **THEN** the system MUST NOT start a run, change scene, or highlight map nodes as selectable

### Requirement: In-pose cutout motion from the concept
While the title hub is visible, the system MUST play looping in-pose motion using cutouts taken from the same operator concept used as the tableau (for example steam, butter drip, small bob or breathe). Motion MUST stay in the painted pose. The system MUST NOT overlay placeholder mascot sprites, extra props, or untextured shapes that are not cut from that painting. Idle motion MUST NOT use boxing, waving, or scurrying as the required loops. Idle motion MUST NOT block plank input.

#### Scenario: Cutouts loop without blocking Play
- **WHEN** the title hub has been visible for several seconds
- **THEN** at least one concept-cutout idle (steam, drip, bob, or breathe) MUST still be looping
- **THEN** the player MUST still be able to activate **Play Game**

#### Scenario: No placeholder overlay junk
- **WHEN** the title hub is visible
- **THEN** the player MUST NOT see placeholder overlay mascots or untextured floating shapes that are not part of the concept painting or its cutouts
