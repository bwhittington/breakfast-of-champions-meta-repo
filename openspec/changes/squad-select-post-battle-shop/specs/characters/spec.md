## ADDED Requirements

### Requirement: Run party size and cap
A run MUST allow the player to field between **1** (interim debug / Title Play shortcut) and **6** party members. The system MUST NOT add party members beyond **6** in a single run. All non-downed party members in the active run party MUST participate simultaneously in Combat.

#### Scenario: Party cap enforced
- **WHEN** the run party already contains 6 members and the player attempts to recruit another hero
- **THEN** the recruitment MUST be rejected and the party size MUST remain 6

#### Scenario: All active members fight
- **WHEN** Combat begins with N party members in the run party (N between 1 and 6)
- **THEN** all N non-downed members MUST be present as combatants for that encounter

### Requirement: Target run start party size
When character select is available, a run MUST begin with **exactly 3** party members chosen from the player's unlocked roster. The system MUST NOT start a character-select-enabled run with fewer or more than 3 selected heroes.

#### Scenario: Three heroes chosen at run start
- **WHEN** the player confirms character select with three distinct unlocked hero ids
- **THEN** the run party MUST contain exactly those three ids

### Requirement: Expanded seed party roster
The seed party roster MUST include exactly six breakfast-food hero identities with `role` `party`: the existing `cereal`, `waffle`, and `bacon`, plus **`pancake`** (Pancake Paladin), **`toast`** (Toast Tank — hero, distinct from enemy `burnt-toast`), and **`egg-scramble`** (Egg Scramble Scout). Each MUST have a display name, tags, and a one-line fantasy. Enemy-only `toast` MUST NOT appear as a party id.

#### Scenario: Full roster readable
- **WHEN** a run, shop, or character-select flow reads the seed party roster
- **THEN** the party ids MUST be `cereal`, `waffle`, `bacon`, `pancake`, `toast`, and `egg-scramble` only

#### Scenario: Hero toast distinct from burnt toast enemy
- **WHEN** encounter or roster data references party hero `toast`
- **THEN** it MUST NOT be conflated with enemy id `burnt-toast`
