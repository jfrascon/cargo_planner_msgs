# Result of placing one cargo unit inside the truck's container.
#
# (pose.position.x, pose.position.y) is the 2D position of the cargo_frame in container_frame.
# pose.orientation encodes the yaw rotation around Z:
#  rotated == false  -> yaw = 0    (lx along container's x-axis, ly along container's y-axis)
#  rotated == true   -> yaw = π/2  (ly along container's x-axis, lx along container's y-axis)
string             id       # matches CargoUnit.id
geometry_msgs/Pose pose
bool               rotated
