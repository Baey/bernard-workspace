# Najmniejszy Dockerfile dla candle_ros2_node na bazie oficjalnego obrazu ROS2 Jazzy
FROM ros:jazzy-ros-base

ENV DEBIAN_FRONTEND=noninteractive

# Instalacja narzędzi i zależności budowania
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

# Inicjalizacja rosdep
RUN rosdep update

# Utwórz workspace i pobierz kod
WORKDIR /candle_ros2_ws/src
RUN git clone --recurse-submodules https://github.com/Baey/candle_ros2.git

# Instalacja zależności pakietów
WORKDIR /candle_ros2_ws
RUN rosdep install --from-paths src --ignore-src -r -y

# Budowanie workspace
RUN . /opt/ros/$ROS_DISTRO/setup.sh && colcon build --symlink-install

# ENTRYPOINT: uruchom node candle_ros2
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
