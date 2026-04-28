# One rectangular cargo unit handled by the planner.
# A cargo unit is the full rectangular load handled by the planner.
# It includes the pallet and the goods carried on it.
#
# No goods should go beyond the pallet footprint.
# The planner assumes the cargo unit is a rectangular cuboid with dimensions `lx x ly x lz` and does
# not account for any overhang.
# If the actual cargo has goods sticking out beyond the pallet footprint, the planner may produce
# placements that are not physically feasible.
#
# Coordinate convention:
#  lx: size along cargo's x-axis
#  ly: size along cargo's y-axis
#  lz: size along cargo's z-axis
#
# Only lx and ly participate in the 2D placement algorithm.
# lz is stored and forwarded to the 3D output pose (z-center = lz / 2).

string  id    # unique cargo unit identifier (e.g. "c1", "EUR-001")
float64 lx    # cargo size along x-axis [m]  (EUR-pallet: 1.2)
float64 ly    # cargo size  along y-axis [m]  (EUR-pallet: 0.8)
float64 lz    # cargo size along z-axis [m]  (load included)
