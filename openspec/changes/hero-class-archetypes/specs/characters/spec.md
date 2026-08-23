## ADDED Requirements

### Requirement: Party heroes carry class
Every party hero (`role` `party`) MUST have a `class` field referencing the hero-classes enum. Enemy combatants MUST NOT require `class` in this change.

#### Scenario: Seed party row includes class
- **WHEN** roster data for a seed party hero is read
- **THEN** a valid `class` value MUST be present

### Requirement: Seed hero class exemplars
The seed party roster MUST assign each of the six hero ids exactly one class as the first exemplar of that archetype:

| Hero id | Class |
|---------|-------|
| `toast` | `tank` |
| `bacon` | `brawler` |
| `waffle` | `duelist` |
| `egg-scramble` | `assassin` |
| `cereal` | `mage` |
| `pancake` | `mystic` |

#### Scenario: Toast is the Tank exemplar
- **WHEN** roster data for hero id `toast` is read
- **THEN** `class` MUST be `tank`

#### Scenario: Full seed class coverage
- **WHEN** the seed party roster is enumerated
- **THEN** each of the six ids MUST map to the class in the table above
- **THEN** all six class values MUST appear exactly once among seed heroes

### Requirement: Baselines applied on party init
When a party hero enters a run or combat from roster data, the system MUST initialize `max_hp`, `speed`, and `defense` from the class baseline template unless a later delta overrides with explicit per-hero stats.

#### Scenario: Waffle receives duelist baselines
- **WHEN** hero id `waffle` is added to the run party from seed roster
- **THEN** its initialized stats MUST match the `duelist` baseline template
