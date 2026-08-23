## Purpose

Binary Deli Studios boot splash shows brand art and a microwave door-clock countdown together, then fades to black before the next scene.

## ADDED Requirements

### Requirement: Splash art and timer share the same boot screen
For the entire countdown, the system MUST display the Binary Deli splash art (cyber microwave, **BINARY DELI STUDIOS**, **JACK IN, EAT OUT.**) on screen at the same time as the live microwave door timer (`M:SS` and **BD**). The system MUST NOT present a boot phase that is only a countdown on a black (or empty) viewport without the splash art.

#### Scenario: First readable frame includes art
- **WHEN** the splash boot sequence begins on a cold launch
- **THEN** the first readable frame MUST show the splash art together with the door timer (not black-only digits)

#### Scenario: Art remains during countdown
- **WHEN** the timer is counting down mid-boot
- **THEN** the splash art MUST remain visible behind or with the timer overlay for that entire interval

### Requirement: Combined art-and-timer duration is short
The combined art-and-timer countdown MUST last approximately 2–3 seconds (configurable; default 2.5 seconds) from boot start until the timer reaches `0:00`.

#### Scenario: Default short beat
- **WHEN** the splash runs with default timing settings
- **THEN** the timer MUST reach `0:00` about 2.5 seconds after splash start (±0.5s tolerance for frame timing)

### Requirement: Fade to black after zero before hand-off
When the timer reaches `0:00`, the system MUST fade the full viewport (art and timer) to black over **2.0 seconds**, and MUST only then transition to the configured post-boot scene. The system MUST NOT jump to the post-boot scene immediately at `0:00` without that fade.

#### Scenario: Two-second fade then harness
- **WHEN** the timer displays `0:00`
- **THEN** the viewport MUST fade to black over 2.0 seconds and only afterward change to the post-boot scene

### Requirement: BD mark stays with the live timer
While the splash art and countdown are visible, the **BD** mark MUST remain visible with the digital time on the timer face.

#### Scenario: BD during combined countdown
- **WHEN** art and timer are both on screen mid-countdown
- **THEN** **BD** MUST remain visible with the `M:SS` readout

### Requirement: Progress mapping stays monotonic
As boot progress increases during one splash session, remaining timer seconds MUST never increase.

#### Scenario: Countdown only decreases
- **WHEN** boot progress advances during the combined art-and-timer phase
- **THEN** displayed remaining time MUST be less than or equal to its previous value
