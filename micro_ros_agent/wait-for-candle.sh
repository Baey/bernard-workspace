#!/bin/bash

source /opt/ros/${ROS_DISTRO}/setup.bash

until ros2 node list | grep -q actuator_state_publisher; do
  echo "Waiting for actuator_state_publisher to be available..."
  sleep 2
done
exec "$@"