cmake_minimum_required(VERSION 3.8)
project(cargo_planner_msgs)

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(action_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(nav_msgs REQUIRED)

rosidl_generate_interfaces(
  ${PROJECT_NAME}
  "msg/CargoUnit.msg"
  "msg/CargoPlacement.msg"
  "srv/ContainerOccupancyGridRegistration.srv"
  "srv/CargoListRegistration.srv"
  "action/PlanCargo.action"
  DEPENDENCIES
  action_msgs
  geometry_msgs
  nav_msgs)

install(DIRECTORY imgs DESTINATION share/${PROJECT_NAME})
install(FILES README.md LICENSE DESTINATION share/${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_export_dependencies(rosidl_default_runtime)
ament_package()
