FROM microros/base:humble

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /uros_ws
    
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
&&  . install/local_setup.sh \
&&  ros2 run micro_ros_setup create_agent_ws.sh \
&&  ros2 run micro_ros_setup build_agent.sh \
&&  rm -rf log/ build/ src/

COPY wait-for-candle.sh /wait-for-candle.sh
RUN chmod +x /wait-for-candle.sh
ENTRYPOINT ["/wait-for-candle.sh"]
CMD ["/bin/sh", "-c", ". /opt/ros/$ROS_DISTRO/setup.sh && . /uros_ws/install/local_setup.sh && ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyACM1 -b 921600"]