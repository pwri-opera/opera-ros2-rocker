FROM osrf/ros:humble-desktop-full

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git vim python-is-python3 python3-colcon-common-extensions \
        ros-humble-rosbridge-suite \
        ros-humble-controller-manager \
        ros-humble-joint-trajectory-controller \
        ros-humble-joint-state-broadcaster \
        ros-humble-moveit \
        ros-humble-moveit-planners-ompl \
        ros-humble-moveit-planners-chomp \
        ros-humble-moveit-visual-tools \
        ros-humble-navigation2 \
        ros-humble-robot-localization && \
    apt-get clean

RUN mkdir -p /ws/src

ADD all.launch.xml /ws/all.launch.xml

RUN source /opt/ros/$ROS_DISTRO/setup.bash && \
    mkdir -p /ws/src && \
    cd /ws/src && \
    git clone -b main-ros2 https://github.com/Unity-Technologies/ROS-TCP-Endpoint.git && \
    git clone --depth=1 https://github.com/pwri-opera/com3_ros.git && \
    git clone --depth=1 https://github.com/pwri-opera/zx120_ros2.git && \
    git clone --depth=1 https://github.com/pwri-opera/zx200_ros2.git && \
    cd /ws && \
    colcon build
