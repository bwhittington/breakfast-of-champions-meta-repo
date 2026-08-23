## Purpose

Lets the player choose exactly three breakfast-food heroes from their unlocked roster before a run begins, establishing the starting squad for recruitment and combat.

## ADDED Requirements

### Requirement: Pick three from unlocked roster
Before Run start (when this capability is implemented), the system MUST present every **unlocked** seed party hero and MUST let the player select **exactly 3** distinct ids. The system MUST NOT allow confirming selection until exactly 3 are chosen.

#### Scenario: Confirm requires three picks
- **WHEN** the player has selected fewer or more than 3 heroes on the character-select screen
- **THEN** the confirm action MUST be disabled or rejected

#### Scenario: Selected heroes become run party
- **WHEN** the player confirms a valid three-hero selection
- **THEN** the run MUST start with those three ids as the initial run party

### Requirement: Interim shortcut unchanged
Until character select is implemented, Title **Play Game** MAY start a run with **exactly one** starter and MUST skip character select. That interim path MUST NOT be removed by this capability's initial slices.

#### Scenario: Title Play still uses one starter
- **WHEN** the player starts a run from Title Play before character-select UI exists
- **THEN** the run party MUST contain exactly one starter id (default `cereal`)
