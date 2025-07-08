FROM ros:jazzy-ros-base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        setserial \
        udev \
        # usbutils \
        # dbus \
        python3-colcon-common-extensions \
        python3-pip \
        build-essential \
        git \
        cmake \
        python3-rosdep \
        python3-vcstool && \
    rm -rf /var/lib/apt/lists/*

RUN rosdep update

WORKDIR /candle_ros2_ws/src
RUN git clone --recurse-submodules https://github.com/Baey/candle_ros2.git

WORKDIR /candle_ros2_ws
RUN rosdep install --from-paths src --ignore-src -r -y

RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build --symlink-install

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
