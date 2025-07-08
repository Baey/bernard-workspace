#!/bin/bash

source /opt/ros/${ROS_DISTRO}/setup.bash

until ros2 node list | grep -q candle_ros2_node; do
  echo "Waiting for candle_ros2_node to be available..."
  sleep 2
done
exec "$@"