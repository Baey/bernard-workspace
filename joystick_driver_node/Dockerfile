FROM ros:jazzy-ros-base

RUN apt update && apt install -y \
    ros-jazzy-joy-linux \
    joystick \
    && rm -rf /var/lib/apt/lists/*

CMD ["ros2", "run", "joy_linux", "joy_linux_node"]