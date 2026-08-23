## Purpose

Presents the kitchen Title / Hub after the studio splash so the player can start a run, open a stub options panel, or quit, on a living breakfast-standoff tableau.

## ADDED Requirements

### Requirement: Title hub follows studio splash
On a cold launch, the system MUST show the studio splash first. After splash hand-off completes, the next player-facing scene MUST be the kitchen title hub. The title hub MUST NOT be the application main/boot scene while a studio splash exists.

#### Scenario: Cold launch lands on title after splash
- **WHEN** the player starts the game from a cold launch and the splash sequence finishes
- **THEN** the next interactive scene MUST be the kitchen title hub (not the debug phase harness as the first post-boot landing)

### Requirement: Kitchen tableau matches the concept
The title hub MUST present the operator kitchen-menu concept as a full-bleed (or letterboxed) tableau: warm kitchen, toasted **BREAKFAST OF CHAMPIONS** wordmark in the art, wooden menu planks, and the breakfast standoff. The system MUST NOT draw a second title label on top of the painted wordmark.

#### Scenario: Painted wordmark is the only title
- **WHEN** the title hub is visible
- **THEN** the player MUST see the painted **BREAKFAST OF CHAMPIONS** wordmark and MUST NOT see a duplicate engine-drawn title string covering it

### Requirement: Four plank actions
The title hub MUST show four labeled actions: **Play Game**, **Unlockables**, **Options**, and **Quit**. Those controls MUST remain inside a bottom-left safe area so typical widescreen crop of the tableau does not hide **Play Game**.

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
While the title hub is active and no modal options panel has stolen focus, the system MUST allow keyboard and gamepad navigation to move focus among the four planks and to activate the focused plank.

#### Scenario: Gamepad activates Play
- **WHEN** the title hub is showing, a plank is focused via keyboard or gamepad, and the player confirms
- **THEN** the system MUST perform that plank's action (same outcomes as pointer activation)

### Requirement: Parchment map is decoration
The parchment map on the title tableau (including labels such as Bakery Battle, Syrup Swamp, Coffee Cavern, Oven Boss) MUST be non-interactive. The system MUST NOT treat it as a map control or change run-map generation because of those labels.

#### Scenario: Clicking the parchment does nothing
- **WHEN** the player clicks or focuses the parchment region
- **THEN** the system MUST NOT start a run, change scene, or highlight map nodes as selectable

### Requirement: Living idle motion on key mascots
While the title hub is visible, the system MUST play looping idle motion for at least: Bacon and the espresso mug shadow-boxing, Cereal waving, and fried-egg mascots scurrying in place. Other figures MAY stay static. Idle motion MUST NOT block plank input.

#### Scenario: Idles loop without blocking Play
- **WHEN** the title hub has been visible for several seconds
- **THEN** the required mascot idles MUST still be looping
- **THEN** the player MUST still be able to activate **Play Game**
