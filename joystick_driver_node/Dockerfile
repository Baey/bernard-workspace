FROM ros:jazzy-ros-base

RUN apt update && apt install -y \
    ros-jazzy-joy-linux \
    joystick \
    && rm -rf /var/lib/apt/lists/*

# COPY disable_fastdds_shm.xml /tmp/
# ENV FASTRTPS_DEFAULT_PROFILES_FILE=/tmp/disable_fastdds_shm.xml

CMD ["ros2", "run", "joy_linux", "joy_linux_node"]