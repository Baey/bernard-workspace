#!/bin/bash

# Inicjacja systemd (wymagane dla niektórych operacji udev)
# if [ -x "$(command -v systemd)" ]; then
#     /sbin/init --version > /dev/null 2>&1 && /sbin/init &
# fi

# Przeładuj reguły udev
# udevadm control --reload
# udevadm trigger --subsystem-match=usb

# Debugowanie
echo "=== Sprawdzanie dostępności urządzeń ==="
ls -l /dev | grep ttyACM
lsusb

# Uruchom węzeł
source /candle_ros2_ws/install/setup.bash
exec ros2 run candle_ros2 candle_ros2_node USB 8M