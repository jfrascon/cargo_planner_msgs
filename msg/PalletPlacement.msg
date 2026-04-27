# PalletPlacement.msg — Result of placing one pallet inside the truck.
#
# pose.position is the 3D position of the pallet CENTER in truck_frame.
# pose.orientation encodes the yaw rotation around Z:
#   rotated == false  →  yaw = 0    (lp along X, wp along Y)
#   rotated == true   →  yaw = π/2  (wp along X, lp along Y)
#
# The pallet footprint corners can be recovered from:
#   effective_lp = lp if not rotated, wp if rotated  (extent in X)
#   effective_wp = wp if not rotated, lp if rotated  (extent in Y)
#   x_min = pose.position.x - effective_lp / 2
#   y_min = pose.position.y - effective_wp / 2

string             id       # matches PalletDimensions.id
geometry_msgs/Pose pose     # center pose in truck_frame (position + orientation)
bool               rotated  # true if the pallet was placed at 90° yaw
