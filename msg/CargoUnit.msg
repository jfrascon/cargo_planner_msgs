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
# lx and ly define the 2D footprint.
# lz must fit within the registered container height and sets the output z-center to lz / 2.

string  id    # unique, non-blank cargo unit identifier, for example "c1" or "EUR-001"
float64 lx    # strictly positive finite size along the cargo x-axis [m]
float64 ly    # strictly positive finite size along the cargo y-axis [m]
float64 lz    # strictly positive finite size along the cargo z-axis [m], including the load
