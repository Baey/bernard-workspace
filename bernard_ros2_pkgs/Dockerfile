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

WORKDIR /bernard_ws/src
RUN git clone https://github.com/Baey/bernard_state_publisher.git
RUN git clone https://github.com/Baey/bernard_actuator_if.git --recursive

WORKDIR /bernard_ws
RUN rosdep install --from-paths src --ignore-src -r -y
RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]