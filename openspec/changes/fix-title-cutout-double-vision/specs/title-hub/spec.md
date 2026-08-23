## MODIFIED Requirements

### Requirement: In-pose cutout motion from the concept
While the title hub is visible, the system MAY play looping in-pose motion derived from the operator concept. Motion MUST stay in the painted pose and MUST NOT block plank input. The system MUST NOT overlay full-body champion cutouts on top of the same champions already visible in the tableau painting. Acceptable motion sources are: (a) **partial overlays** that animate only non-duplicative fragments (e.g. steam wisps, butter drip, small highlight) aligned to painted figures, or (b) **subtle transform on partial regions** without introducing a second full character silhouette.

#### Scenario: No duplicate champion bodies
- **WHEN** the title hub is visible
- **THEN** the player MUST NOT see two full Waffle Warrior or Bacon Brawler bodies at different scales or positions
- **THEN** the player MUST NOT see a circular or vignette lens overlay duplicating part of the painting

#### Scenario: Cutouts loop without blocking Play
- **WHEN** the title hub has been visible for several seconds
- **THEN** at least one subtle in-pose motion (steam, drip, bob, or breathe) MAY still be looping if implemented
- **THEN** the player MUST still be able to activate **Play Game**

#### Scenario: No placeholder overlay junk
- **WHEN** the title hub is visible
- **THEN** the player MUST NOT see placeholder overlay mascots, untextured floating shapes, or full-body cutout stacks that are not part of the single cohesive painting read
