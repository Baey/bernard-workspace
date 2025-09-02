#!/bin/bash
set -e

source /opt/ros/jazzy/setup.bash
source /bernard_ws/install/setup.bash

ros2 run bernard_hw_if actuator_state_publisher &

ros2 launch bernard_state_publisher state.launch.py
