# cargo_planner_msgs

`cargo_planner_msgs` defines the ROS 2 data contract used by `cargo_planner`.
It contains two messages, two registration services and one planning action.
It contains no planning algorithm or executable.

## Coordinate and unit conventions

All lengths use meters.
All planar rotations use yaw around the positive Z axis.

The container coordinate frame is supplied by the registered `nav_msgs/msg/OccupancyGrid`:

- X follows grid columns from the container door toward the back wall.
- Y follows grid rows from the origin-side wall toward the opposite wall.
- Z starts at the container floor and points upward.

`CargoPlacement.pose` has no header.
Consumers must interpret it in the frame stored in the registered occupancy grid header.

## Messages

### `CargoUnit.msg`

A cargo unit is the complete rectangular load handled by the planner, including its pallet and
goods.

| Field | Meaning |
| --- | --- |
| `id` | Unique, non-empty cargo identifier. |
| `lx` | Positive finite size along the cargo X axis in meters. |
| `ly` | Positive finite size along the cargo Y axis in meters. |
| `lz` | Positive finite size along the cargo Z axis in meters. |

![Cargo unit](imgs/cargo_unit.png)

The cargo X axis follows the pallet's longest horizontal dimension.
The Y axis follows its width and the Z axis is vertical.

![Cargo axes](imgs/cargo_axes.png)

The planner models one rectangular cuboid with no overhang.
Goods extending beyond the declared footprint can make a geometrically valid plan physically
impossible.

The 2D collision algorithm uses `lx` and `ly`.
The planner compares `lz` with the registered container height and rejects units that are too tall.

### `CargoPlacement.msg`

A placement reports the center pose selected for one cargo unit.

| Field | Meaning |
| --- | --- |
| `id` | Matches `CargoUnit.id`. |
| `pose` | Cargo center in the registered occupancy-grid frame. |
| `rotated` | `false` for zero yaw and `true` for `pi / 2` yaw. |

The output Z coordinate is `lz / 2`, so the cuboid rests on the container floor.

![Rotated cargo](imgs/rotated_cargo.png)

## Services

### `ContainerOccupancyGridRegistration.srv`

This service replaces the stored container map.

Request:

- `grid_map`: occupancy grid of the container interior.
- `container_height`: positive finite interior height in meters.

The planner derives planar dimensions from:

```text
container_length = grid_map.info.width  * grid_map.info.resolution
container_width  = grid_map.info.height * grid_map.info.resolution
```

Response:

- `success`: whether validation and storage succeeded.
- `message`: human-readable result.

### `CargoListRegistration.srv`

This service replaces the stored cargo list.
Every cargo unit is validated and the planner sorts the list by descending volume before planning.
The request order is therefore not the planning order.

## `PlanCargo.action`

The goal is empty because the action uses the container grid and cargo list stored by the services.
Both registrations must have succeeded before goal execution begins.
A second goal is rejected while planning is active.

The result contains:

- `success` and a human-readable `message`.
- Successful `placements`.
- `no_placed` IDs for valid units that did not fit.
- Placed, remaining usable and total grid areas in square meters.
- Utilization as `placed_area_m2 / total_area_m2 * 100`.

Feedback reports the total cargo count.
The placed count is zero while computing and contains the final count immediately before the result.

Cancellation is accepted.
The current algorithm checks cancellation before and after its non-interruptible planning step.

## Call sequence

1. Call `container_occupancy_grid_registration`.
2. Call `cargo_list_registration`.
3. Send an empty goal to `cargo_planning`.

The two registration services may be called in either order and may be called again to replace
stored state.

## Build and test

From the workspace root:

```bash
source /opt/ros/jazzy/setup.bash
colcon build --merge-install --packages-select cargo_planner_msgs
source install/setup.bash
colcon test --merge-install --packages-select cargo_planner_msgs
colcon test-result --test-result-base build/cargo_planner_msgs --verbose
```

## License

This package is distributed under the Apache License 2.0.
See [LICENSE](LICENSE).
