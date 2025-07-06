FROM ros:jazzy-ros-base

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p candle_ros2_ws
WORKDIR candle_ros2_ws

RUN git clone --recurse-submodules https://github.com/Baey/candle_ros2.git src/candle_ros2_setup \
&&  . /opt/ros/$ROS_DISTRO/setup.sh \
&&  apt update \
&&  apt install -y ed python3-pip \
&&  apt autoremove -y \
&&  rosdep update --rosdistro $ROS_DISTRO\
&&  rosdep install --from-paths src --ignore-src -y \
&&  colcon build --symlink-install --packages-select candle_ros2\
&&  rm -rf /var/lib/apt/lists/*

COPY ../disable_fastdds_shm.xml /tmp/
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/tmp/disable_fastdds_shm.xml

RUN echo ". /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc \
&&  echo ". /candle_ros2_ws/install/setup.bash" >> ~/.bashrc

CMD ["/bin/bash", "-c", "source /opt/ros/$ROS_DISTRO/setup.bash && source /candle_ros2_ws/install/setup.bash && ros2 run candle_ros2 candle_ros2_node USB 8M"]