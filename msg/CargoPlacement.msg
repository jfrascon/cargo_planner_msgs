# Result of placing one cargo unit inside the truck's container.
#
# pose is the cargo center expressed in the frame of the registered OccupancyGrid.
# The message has no Header, so consumers must retain that grid frame as context.
# pose.orientation encodes the yaw rotation around Z:
#  rotated == false  -> yaw = 0    (lx along container's x-axis, ly along container's y-axis)
#  rotated == true   -> yaw = π/2  (ly along container's x-axis, lx along container's y-axis)
string             id       # matches CargoUnit.id
geometry_msgs/Pose pose     # cargo center with z = CargoUnit.lz / 2
bool               rotated  # false for 0 yaw, true for pi / 2 yaw
