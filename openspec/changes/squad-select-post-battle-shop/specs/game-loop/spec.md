## ADDED Requirements

### Requirement: Post-battle shop phase in session flow
The session flow MUST include a **post-battle shop** step after combat victory and before resuming Run navigation (or before run win on boss). The active phase during shop MAY be `run` with a shop overlay or a dedicated sub-state, but map node selection MUST remain blocked until the shop is dismissed.

#### Scenario: Map blocked during shop
- **WHEN** the post-battle shop is active after a combat victory
- **THEN** the player MUST NOT select the next map node until the shop is dismissed

### Requirement: Character select in target session flow
The long-term session flow MUST be: Title / Hub → **Character select** (pick 3) → Run start → Run / Combat loop with post-battle shop after each combat victory. Character select MUST remain skippable only via the documented interim Title Play shortcut until the select UI ships.

#### Scenario: Target flow lists select before run
- **WHEN** documentation or tooling describes the full player-facing session flow
- **THEN** character select MUST appear after Title / Hub and before Run start in the target flow

## MODIFIED Requirements

### Requirement: Combat victory returns to run
When combat ends in victory and the committed node is not a victorious boss clear, the system MUST enter the **post-battle shop phase** for that victory. After the shop is dismissed, the system MUST set the active phase to `run` and MUST retain the party at the node where combat was fought. Surviving party combat state (at least HP) MUST carry back into the run phase.

#### Scenario: Victory on a normal combat node
- **WHEN** the active phase is `combat` on a `combat` or `elite` node and all enemies are defeated
- **THEN** the post-battle shop phase MUST open
- **THEN** after the shop is dismissed, the active phase MUST become `run` at that node

### Requirement: Boss victory ends the run as a win
When combat ends in victory on a `boss` node, the system MUST open the **post-battle shop phase**, then MUST end the run with outcome `win` after the shop is dismissed. The run MUST NOT end with outcome `win` before the post-battle shop is dismissed.

#### Scenario: Boss defeated
- **WHEN** the active phase is `combat` on a `boss` node and all enemies are defeated
- **THEN** the post-battle shop phase MUST open
- **THEN** after the shop is dismissed, the run MUST end with outcome `win`
