FROM ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p foxglove_agent_ws
WORKDIR foxglove_agent_ws

RUN apt update && apt install \
    ros-$ROS_DISTRO-foxglove-bridge -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash", "-c", "source /opt/ros/$ROS_DISTRO/setup.bash && ros2 launch foxglove_bridge foxglove_bridge_launch.xml"]