## Purpose

Defines how run-map nodes of known types appear to the player: kitchen-tool icons and short mechanic names, without changing DAG pathing or lowercase type strings.

## ADDED Requirements

### Requirement: Kitchen presentation mapping
The system MUST treat the following as the presentation contract for mapped node types. The runtime `type` field MUST remain the lowercase enum from `specs/canonical/map_system.md`. `NODE_*` values and `.tscn` keys MUST be presentation aliases only and MUST NOT replace `type` in phase or path logic.

| Runtime type | Short name | Alias | Icon asset key | Encounter pool id (name only) |
|---|---|---|---|---|
| `combat` | Cook Line | `NODE_COMBAT` | `frying_pan_icon.tscn` | `pve_ingredients_easy` |
| `elite` | Kitchen Fire | `NODE_ELITE` | `burner_flame_icon.tscn` | `pve_ingredients_hard` |
| `event` | Order Ticket | `NODE_EVENT` | `order_ticket_icon.tscn` | `kitchen_story_events` |
| `rest` | Cooling Rack | `NODE_REST` | `cooling_rack_icon.tscn` | `none_interactive_heal` |
| `boss` | Oven Boss | `NODE_BOSS` | `oven_cloche_icon.tscn` | `zone_boss_actors` |

The combat icon MUST read as a standard frying pan. The elite icon MUST read as a roaring stovetop burner with high flames. The event icon MUST read as a handwritten kitchen order ticket on a metal spike. The rest icon MUST read as a wire baking rack. The boss icon MUST read as a glowing commercial wood-fire oven. The asset key `oven_cloche_icon.tscn` MUST still be used; the visible mark MUST be the oven, not a cloche.

This change MUST NOT require populated encounter tables. Pool ids MUST exist as named keys on the mapping only.

#### Scenario: Combat presents as Cook Line
- **WHEN** the Run map shows an available or current `combat` node
- **THEN** the node identity MUST be the frying-pan icon and the short name Cook Line
- **THEN** the node's `type` MUST still be `combat`

#### Scenario: Elite presents as Kitchen Fire
- **WHEN** the Run map shows an `elite` node
- **THEN** the node identity MUST be the roaring-burner icon and the short name Kitchen Fire

#### Scenario: Event presents as Order Ticket
- **WHEN** the Run map shows an `event` node
- **THEN** the node identity MUST be the order-ticket icon and the short name Order Ticket

#### Scenario: Rest presents as Cooling Rack
- **WHEN** the Run map shows a `rest` node
- **THEN** the node identity MUST be the cooling-rack icon and the short name Cooling Rack

#### Scenario: Boss presents as Oven Boss
- **WHEN** the Run map shows the `boss` node
- **THEN** the node identity MUST be the wood-fire oven icon and the short name Oven Boss

### Requirement: Landmark names are not node identity
Zone or landmark copy (for example Waffle Woods, Doughnut Dunes) MUST NOT be used as the node's standing identity on the parchment. That copy MAY appear on a run-info panel or other zone flavor. Hover or select MAY show a longer line (for example Cook Line Battle) in addition to the short name.

#### Scenario: Parchment labels are mechanic names
- **WHEN** the player views the run map without opening extra UI
- **THEN** mapped nodes MUST show their short mechanic names, not landmark titles, as standing labels

### Requirement: Unmapped types stay unlabeled as kitchen stops
The `start` node MUST remain entry-only and MUST NOT use a kitchen-tool mechanic label from the mapping table. The `shop` type MUST remain a valid canonical type and MUST NOT gain a Pantry / Supplier presentation in this change.

#### Scenario: Start is not a Cook Line
- **WHEN** the party is on the `start` node
- **THEN** the system MUST NOT present that node as Cook Line, Kitchen Fire, Order Ticket, Cooling Rack, or Oven Boss

### Requirement: Pathing and phase rules unchanged
Selecting a mapped node MUST still follow `specs/canonical/map_system.md` path selection and `specs/canonical/game_loop.md` phase rules: `combat`, `elite`, and `boss` enter Combat; `event` and `rest` resolve in Run. Rest MUST still heal or recover a downed ally and MUST NOT grant a permanent seasoning upgrade in this change.

#### Scenario: Kitchen Fire still enters Combat
- **WHEN** the player selects an available `elite` node from Run
- **THEN** the system MUST enter Combat with that node's harder encounter
- **THEN** the node MUST still be typed `elite`

#### Scenario: Cooling Rack stays in Run
- **WHEN** the player selects an available `rest` node from Run
- **THEN** the system MUST keep the active phase as Run
- **THEN** the rest resolution MUST NOT apply a permanent seasoning upgrade
