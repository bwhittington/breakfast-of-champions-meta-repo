## Purpose

Defines the six reusable hero combat classes and their baseline stat templates so party members feel distinct before full skill kits are implemented.

## ADDED Requirements

### Requirement: Six hero classes
The system MUST support exactly these party-hero class values: `tank`, `brawler`, `duelist`, `assassin`, `mage`, and `mystic`. The system MUST NOT assign these classes to enemies in this capability.

#### Scenario: Valid class enum
- **WHEN** party hero data is validated
- **THEN** `class` MUST be one of the six defined values

### Requirement: Per-class stat baselines
Each class MUST define baseline templates for `max_hp`, `speed`, and `defense` used when initializing a party hero of that class. Relative ordering MUST match role intent: `tank` highest durability, `assassin` highest speed with lowest durability, others between. Exact integers MAY be placeholders until balance pass.

#### Scenario: Tank durability skew
- **WHEN** a party hero with `class` `tank` is initialized from baselines
- **THEN** its baseline `max_hp` and `defense` MUST be greater than or equal to those of an `assassin` of the same implementation tier

#### Scenario: Assassin speed skew
- **WHEN** a party hero with `class` `assassin` is initialized from baselines
- **THEN** its baseline `speed` MUST be greater than or equal to that of a `tank` of the same implementation tier

### Requirement: Class is reusable across heroes
The system MUST treat class as a template independent of food identity. Multiple distinct hero ids MAY share the same class. The seed roster MAY introduce one exemplar hero per class without implying a permanent one-to-one mapping for future heroes.

#### Scenario: Future shared class
- **WHEN** a new hero id is added with `class` `brawler`
- **THEN** the system MUST apply the same `brawler` baseline template as existing brawler-class heroes

### Requirement: No duplicate-class party restriction
Party composition rules MUST NOT forbid selecting multiple heroes of the same class when character select is available.

#### Scenario: Two tanks allowed
- **WHEN** the player selects two party heroes both with `class` `tank` for run start
- **THEN** the selection MUST be accepted if otherwise valid under roster and party-size rules
