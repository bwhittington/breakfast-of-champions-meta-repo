## Purpose

Presents the Binary Deli Studios brand on boot and reports load progress as a microwave digital timer that counts down to zero.

## ADDED Requirements

### Requirement: Studio splash is the boot entry
On game launch, the system MUST show the Binary Deli Studios splash before any gameplay, debug harness, or title/hub scene. The splash MUST display the studio splash art featuring the cyber microwave, the title **BINARY DELI STUDIOS**, and the tagline **JACK IN, EAT OUT.**

#### Scenario: Cold launch shows splash first
- **WHEN** the player starts the game from a cold launch
- **THEN** the first interactive frame MUST be the Binary Deli Studios splash scene

### Requirement: Microwave timer represents load progress
The splash MUST show a microwave-style digital timer in `M:SS` form (matching the on-door clock in the splash art). The displayed remaining time MUST decrease as boot/load progress increases. When load progress reaches completion, the timer MUST read `0:00`.

#### Scenario: Mid-load countdown
- **WHEN** boot/load progress is partially complete (greater than 0% and less than 100%)
- **THEN** the microwave timer MUST show a remaining time strictly between the configured start duration and `0:00`

#### Scenario: Load complete reaches zero
- **WHEN** boot/load progress reaches 100%
- **THEN** the microwave timer MUST display `0:00`

### Requirement: BD mark remains visible on the timer face
While the splash is visible, the timer face MUST keep the studio mark **BD** visible beneath or adjacent to the digital time, consistent with the splash art.

#### Scenario: BD visible during countdown
- **WHEN** the splash is on screen and the timer is counting down
- **THEN** the **BD** mark MUST remain visible with the digital time

### Requirement: Transition after load completes
After load progress is complete and the timer shows `0:00`, the system MUST transition to the configured next scene (post-boot target). The splash MUST NOT remain as the permanent main gameplay scene.

#### Scenario: Hand-off after 0:00
- **WHEN** load progress is complete and the timer displays `0:00`
- **THEN** the game MUST change to the configured post-boot scene within a short settle delay (same splash session)

### Requirement: Progress mapping is monotonic
As load progress increases, the remaining timer value MUST never increase. The timer MUST NOT jump backward in remaining time except when resetting for a new boot session.

#### Scenario: Progress only advances the countdown
- **WHEN** load progress moves from a lower percentage to a higher percentage during one boot
- **THEN** the remaining timer value MUST be less than or equal to its previous value
