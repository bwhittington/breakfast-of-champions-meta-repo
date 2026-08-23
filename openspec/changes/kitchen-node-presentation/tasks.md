## 1. Presentation mapping (game repo)

- [ ] 1.1 Add a single node-presentation table (resource or const) keyed by lowercase `combat` / `elite` / `event` / `rest` / `boss` with short name, `NODE_*` alias, icon asset key, and pool id — verify a lookup for `combat` returns Cook Line, `NODE_COMBAT`, `frying_pan_icon.tscn`, `pve_ingredients_easy` and does not change the input type string
- [ ] 1.2 Include rows for elite / event / rest / boss matching the delta spec (Kitchen Fire, Order Ticket, Cooling Rack, Oven Boss; burner / ticket / rack / `oven_cloche_icon.tscn`) — verify each of the five types round-trips in a unit or harness print
- [ ] 1.3 Leave `start` and `shop` off the kitchen-stop table (or explicitly unmapped) — verify lookup does not return Cook Line (etc.) for `start` or `shop`

## 2. Run map identity (game repo)

- [ ] 2.1 Point the run-map node widget (create a minimal parchment stub if none exists) at the table for standing icon + short name — verify five mapped types show distinct icons or placeholders plus Cook Line / Kitchen Fire / Order Ticket / Cooling Rack / Oven Boss, not landmark titles
- [ ] 2.2 Use frying-pan / burner / ticket / rack / oven placeholders if final `.tscn` art is missing; boss placeholder MUST read as an oven, not a cloche — verify Oven Boss is the standing boss label
- [ ] 2.3 Keep zone/landmark copy off the node standing label (run-info scroll MAY still say a zone name) — verify a `combat` node is not titled Waffle Woods on the parchment

## 3. Compatibility (game repo)

- [ ] 3.1 Do not rename phase-controller node type strings — verify `enter_combat` / non-combat resolve still use `combat` | `elite` | `boss` and `start` | `rest` | `shop` | `event`
- [ ] 3.2 Do not populate encounter pool tables or add seasoning on rest — verify rest still heals/revives only if rest resolution exists; verify no new generator required for this change

## 4. Smoke

- [ ] 4.1 Exercise map stub or harness showing all five mapped types plus start — verify F5/F6 (or headless script) lists correct short names and lowercase types together
