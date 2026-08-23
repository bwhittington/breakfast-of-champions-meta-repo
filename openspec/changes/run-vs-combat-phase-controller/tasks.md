## 1. RunController foundation (game repo)

- [ ] 1.1 Add `game-project/scripts/run/run_controller.gd` as Autoload `RunController` with `active_phase` (`none`|`run`|`combat`), `run_outcome` (`none`|`win`|`loss`), and opaque `current_node_id`; register it in `project.godot` — verify Godot loads the project without errors and the Autoload appears in Project Settings
- [ ] 1.2 Implement `start_run()` to set phase `run`, outcome `none`, and a start node id — verify calling it from the debugger/script sets getters to those values
- [ ] 1.3 Implement `enter_combat(node_id, node_type)` for `combat`|`elite`|`boss` only when phase is `run`; reject otherwise — verify legal call → phase `combat`, illegal call leaves state unchanged
- [ ] 1.4 Implement `resolve_non_combat_node(node_id, node_type)` for `start`|`rest`|`shop`|`event` keeping phase `run` — verify phase stays `run` and `current_node_id` updates
- [ ] 1.5 Implement `combat_won()` / `combat_lost()` / `abandon_run()` per delta specs (normal victory → `run`; boss victory → outcome `win`; defeat → outcome `loss`) — verify each path with scripted calls

## 2. Debug harness (game repo)

- [ ] 2.1 Create `game-project/scenes/debug/phase_harness.tscn` (+ script) with buttons/actions: start run, pick fake combat/elite/boss/rest nodes, report combat win/loss — verify F5 runs the harness scene
- [ ] 2.2 Set `application/run/main_scene` to the phase harness — verify project main run opens the harness
- [ ] 2.3 Show on-screen labels for `active_phase`, `run_outcome`, and `current_node_id` bound to `RunController` — verify UI updates after each button action

## 3. Spec acceptance checks (game repo)

- [ ] 3.1 Manually walk Run → combat node → Combat → win → Run; confirm map/phase does not advance during combat (no second enter-combat success) — verify matches delta scenarios for enter/return
- [ ] 3.2 Manually walk boss combat → win → run ended `win`; and any combat → loss → run ended `loss` — verify harness shows terminal outcomes and further combat/node actions are rejected or no-ops
