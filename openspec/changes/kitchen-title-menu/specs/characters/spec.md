## Purpose

Defines seed identities for playable breakfast foods and enemies so menu mascots, lore labels, and stub encounters share the same ids as canonical character data.

## ADDED Requirements

### Requirement: Seed party identities match the title poster
Until a later roster change, the seed party MUST consist of exactly these combatant ids with `role` `party`: `cereal` (Cereal Soldier / Cereal), `waffle` (Waffle Warrior), and `bacon` (Bacon Brawler). Each MUST have a display name and a one-line fantasy. The system MUST NOT list `egg-scramble`, `pancake`, or a party-role `toast` in the current seed party table.

#### Scenario: Seed party table contents
- **WHEN** a run or tool reads the current seed party roster
- **THEN** the party ids MUST be `cereal`, `waffle`, and `bacon` only

#### Scenario: Default run still uses one starter
- **WHEN** a run starts from the title hub without character select
- **THEN** the party in that run MUST contain exactly one of the seed party ids (not all three by default)

### Requirement: Seed enemy identities match the title poster
Until a later encounter change, the seed enemy table MUST include `espresso-mug`, `burnt-toast`, and `fried-egg` with `role` `enemy`, plus `kitchen-timer` as the Oven Boss stand-in. The system MUST NOT use `burnt-crumb`, `sour-milk`, or `hangry-waffle` as current seed enemy ids.

#### Scenario: Seed enemy table contents
- **WHEN** a run, harness, or encounter stub reads current seed enemy ids
- **THEN** those ids MUST be drawn from `espresso-mug`, `burnt-toast`, `fried-egg`, and `kitchen-timer`
- **THEN** the retired ids `burnt-crumb`, `sour-milk`, and `hangry-waffle` MUST NOT appear as live seed keys

### Requirement: Identity-only seed amendment
This capability MUST specify ids, display names, roles, and one-line fantasies only. It MUST NOT require new skill math, combat sprites, or encounter balance tables.

#### Scenario: No combat-stat contract in this change
- **WHEN** implementers apply this characters delta
- **THEN** existing placeholder combat stats MAY remain unchanged aside from renaming or replacing seed rows to the new ids
