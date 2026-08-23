## Purpose

Owns mutually exclusive Run and Combat phases for a single Breakfast of Champions run, including valid transitions and run win/loss outcomes.

## ADDED Requirements

### Requirement: Single active phase
The system MUST maintain exactly one active phase for an in-progress run: `run` or `combat`. The system MUST NOT advance map position or resolve map-node selection while the active phase is `combat`.

#### Scenario: Query active phase during run
- **WHEN** a run is in progress and the player is navigating the map
- **THEN** the active phase MUST be `run`

#### Scenario: Query active phase during combat
- **WHEN** a run is in progress and an encounter is being resolved
- **THEN** the active phase MUST be `combat`

### Requirement: Enter combat from combat-capable nodes
When the player commits to a combat-capable node (`combat`, `elite`, or `boss`), the system MUST transition the active phase from `run` to `combat` and MUST associate the encounter with that node before combat resolution begins.

#### Scenario: Normal combat node selected
- **WHEN** the active phase is `run` and the player selects an available `combat` node
- **THEN** the active phase MUST become `combat`

#### Scenario: Elite or boss node selected
- **WHEN** the active phase is `run` and the player selects an available `elite` or `boss` node
- **THEN** the active phase MUST become `combat`

### Requirement: Non-combat nodes remain in run
When the player commits to a non-combat node (`rest`, `shop`, `event`, or `start`), the system MUST keep the active phase as `run` and MUST NOT enter `combat` for that resolution.

#### Scenario: Rest node selected
- **WHEN** the active phase is `run` and the player selects an available `rest` node
- **THEN** the active phase MUST remain `run` after the node resolves

### Requirement: Combat victory returns to run
When combat ends in victory and the committed node is not a victorious boss clear, the system MUST set the active phase to `run` and MUST retain the party at the node where combat was fought. Surviving party combat state (at least HP) MUST carry back into the run phase.

#### Scenario: Victory on a normal combat node
- **WHEN** the active phase is `combat` on a `combat` or `elite` node and all enemies are defeated
- **THEN** the active phase MUST become `run` at that node

### Requirement: Boss victory ends the run as a win
When combat ends in victory on a `boss` node, the system MUST end the run with outcome `win` and MUST NOT leave the run in an active `run` or `combat` phase.

#### Scenario: Boss defeated
- **WHEN** the active phase is `combat` on a `boss` node and all enemies are defeated
- **THEN** the run MUST end with outcome `win`

### Requirement: Combat defeat ends the run as a loss
When combat ends in defeat (all party members defeated), the system MUST end the run with outcome `loss` and MUST NOT allow further map progress for that run.

#### Scenario: Party wiped
- **WHEN** the active phase is `combat` and all party members are defeated
- **THEN** the run MUST end with outcome `loss`

### Requirement: Illegal transitions are rejected
The system MUST reject phase-transition requests that violate the rules above (for example, entering combat while already in combat, or returning to run without a combat result). Rejected requests MUST leave the active phase and run outcome unchanged.

#### Scenario: Duplicate enter-combat while already in combat
- **WHEN** the active phase is `combat` and a caller requests enter-combat again
- **THEN** the request MUST be rejected and the active phase MUST remain `combat`
