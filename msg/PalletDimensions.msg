# PalletDimensions.msg — Physical footprint and height of a single pallet.
#
# Coordinate convention follows truck_frame:
#   lp  length along X axis (door  → back wall)
#   wp  width  along Y axis (right → left wall)
#   hp  height along Z axis (floor → ceiling)
#
# Only lp and wp participate in the 2D placement algorithm.
# hp is stored and forwarded to the 3D output pose (z-center = hp / 2).

string  id    # unique pallet identifier (e.g. "p1", "EUR-001")
float64 lp    # pallet length along truck X axis [m]  (EUR-pallet: 1.2)
float64 wp    # pallet width  along truck Y axis [m]  (EUR-pallet: 0.8)
float64 hp    # pallet height along truck Z axis [m]  (load included)
