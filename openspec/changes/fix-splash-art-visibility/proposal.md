## Why

Cold boot currently shows a black screen with a floating countdown instead of the Binary Deli splash art and microwave timer together. That breaks the studio brand beat and violates the splash intent (art + door clock as one composition). Fixing it now restores the approved fantasy before more boot polish piles on.

## What Changes

- Make splash **art visible for the full countdown** alongside the live door-clock timer (no black-only timer phase).
- Shorten the combined art+timer beat to ~**2–3 seconds** (default **2.5s**).
- After the timer hits **`0:00`**, play a **2 second fade to black**, then hand off to the phase harness.
- Tighten `studio-splash` requirements so combined art+timer and fade-before-hand-off are explicit and testable.

## Non-goals

- Sandwich spin, glitch FX, interactive START/CANCEL buttons.
- Changing the post-boot target away from the phase harness.
- Title/hub or Run/Combat gameplay work.

## Capabilities

### New Capabilities

- `studio-splash`: Boot splash must show Binary Deli art and microwave timer together; after `0:00`, fade to black (2s) before post-boot hand-off. (Main `openspec/specs/` has no archived `studio-splash` yet; this delta supersedes the broken v1 boot behavior.)

### Modified Capabilities

- (none under `openspec/specs/` — capability not archived yet)

## Impact

- **Code (game repo):** `scenes/boot/studio_splash.tscn`, `scripts/boot/studio_splash.gd`, possibly texture import / layering / stretch.
- **Specs:** new OpenSpec change delta for `studio-splash`; aligns with prior `binary-deli-studio-splash` intent.
- **Player-facing:** cold F5 shows art+timer, then fade, then harness.
