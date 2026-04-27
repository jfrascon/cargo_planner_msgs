# cargo_planner_msgs

ROS 2 interface package for `cargo_planner`. Defines the messages and services
used to communicate with the cargo planner node.

## Messages

### `PalletDimensions.msg`
Physical dimensions of one pallet in `truck_frame` axes:

| Field | Type | Description |
|-------|------|-------------|
| `id` | `string` | Unique pallet identifier |
| `lp` | `float64` | Length along X (door → back wall) [m] |
| `wp` | `float64` | Width along Y (right → left wall) [m] |
| `hp` | `float64` | Height along Z (floor → ceiling) [m] |

EUR-pallet standard: `lp=1.2, wp=0.8`.

### `PalletPlacement.msg`
Result of placing one pallet inside the truck:

| Field | Type | Description |
|-------|------|-------------|
| `id` | `string` | Matches `PalletDimensions.id` |
| `pose` | `geometry_msgs/Pose` | 3D center pose in `truck_frame` |
| `rotated` | `bool` | True if placed at 90° yaw |

## Services

### `SetTruckMap.srv`
Store the OccupancyGrid of the truck interior (call before `PlanCargo`).

```
Request:
  nav_msgs/OccupancyGrid grid_map     # from truck_inspector
  float64                truck_height # trailer height [m]
Response:
  bool   success
  string message
```

Truck length and width are inferred from grid metadata:
`truck_length = info.width * info.resolution`,
`truck_width  = info.height * info.resolution`.

### `SetPalletList.srv`
Provide the list of pallets to load (call before `PlanCargo`).

```
Request:
  cargo_planner_msgs/PalletDimensions[] pallets
Response:
  bool   success
  string message
```

### `PlanCargo.srv`
Run the placement algorithm and return the cargo plan.

```
Request: (empty — uses cached truck map and pallet list)
Response:
  cargo_planner_msgs/PalletPlacement[] placements
  string[]  no_placed
  float64   placed_area_m2
  float64   free_area_m2
  float64   total_area_m2
  float64   utilization_pct
```

## Typical call sequence

```bash
ros2 service call /cargo_planner/set_truck_map cargo_planner_msgs/srv/SetTruckMap \
  "{grid_map: ..., truck_height: 2.5}"

ros2 service call /cargo_planner/set_pallet_list cargo_planner_msgs/srv/SetPalletList \
  "{pallets: [{id: 'p1', lp: 1.2, wp: 0.8, hp: 1.5}]}"

ros2 service call /cargo_planner/plan_cargo cargo_planner_msgs/srv/PlanCargo "{}"
```
