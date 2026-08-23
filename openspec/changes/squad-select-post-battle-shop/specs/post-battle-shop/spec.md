## Purpose

Provides a mandatory shopping beat after every combat victory where the player spends run currency on items, recruits new heroes up to the party cap, or upgrades heroes already in the run party.

## ADDED Requirements

### Requirement: Shop after every combat victory
After Combat ends in **victory** on a `combat`, `elite`, or `boss` node, the system MUST enter a **post-battle shop phase** before returning to the Run map or ending the run. The player MUST NOT return directly to map navigation without passing through or explicitly dismissing the shop (when implemented).

#### Scenario: Normal combat victory opens shop
- **WHEN** the player wins Combat on a `combat` or `elite` node
- **THEN** the post-battle shop phase MUST open before the Run map is shown again

#### Scenario: Boss victory opens shop then ends run
- **WHEN** the player wins Combat on a `boss` node
- **THEN** the post-battle shop phase MUST open
- **THEN** after the shop is dismissed, the run MUST end with outcome `win`

### Requirement: Shop offer categories
During the post-battle shop phase, the system MUST expose at least three offer categories: **items**, **new hero recruitment**, and **hero upgrades** for members of the current run party. Offers MAY be stubbed in early implementation but the categories MUST remain distinguishable.

#### Scenario: Recruitment respects party cap
- **WHEN** the player purchases a new hero from the shop and the run party has fewer than 6 members
- **THEN** the recruited hero MUST be added to the run party

#### Scenario: Upgrade applies to run party member
- **WHEN** the player purchases an upgrade for a hero id in the current run party
- **THEN** that hero's upgrade state for the run MUST reflect the purchase

### Requirement: Distinct from map shop nodes
Post-battle shop MUST be triggered by **combat victory**, not by visiting a map `shop` node. Map `shop` nodes MAY continue to exist as optional Run-phase path rewards without replacing the post-battle shop beat.

#### Scenario: Map shop node does not substitute post-battle shop
- **WHEN** the player wins Combat and has not yet dismissed the post-battle shop
- **THEN** the system MUST NOT skip the post-battle shop solely because a map `shop` node was visited earlier in the run
