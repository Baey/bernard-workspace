# Bernard Robot Docker Workspace

A containerized workspace for running all essential services and programs for the **BERNARD** (Bipedal Experimental RL-based Neuromorphic Autonomous Reconfigurable Droid) robot on AMD Kria KV260 platform.

## 🎯 Overview

This workspace provides a comprehensive Docker-based solution for managing and running the BERNARD bipedal robot's software stack. It containerizes all critical services to ensure reliable operation and minimize system risks on the Ubuntu-based Kria KV260 embedded platform.

The architecture is designed to be extensible, with current basic services and planned AI/ML services that will leverage the Kria KV260's FPGA capabilities for real-time inference and advanced robotics applications.

## 🏗️ Architecture

The workspace currently consists of three main containerized services, with additional services planned for future releases:

### 📡 Micro-ROS Agent
- **Container**: `micro_ros_agent`
- **Purpose**: Bridge between micro-ROS nodes and ROS 2 ecosystem
- **Hardware Interface**: `/dev/ttyACM1` serial communication
- **Baud Rate**: 921600

### 🦾 Candle ROS2 Node
- **Container**: `candle_ros2_node`
- **Purpose**: Motor control and communication with MD80 servo drives
- **Hardware Interface**: `/dev/ttyACM1` (CAN-USB adapter)
- **Features**: Position, velocity, and impedance control

### 🎮 Gamepad Controller Node
- **Container**: `joy_linux`
- **Purpose**: Bluetooth gamepad input handling for robot control and mode switching
- **Hardware Interface**: `/dev/input/js0` (Bluetooth via ASUS USB-BT500)
- **Supported Controllers**: Xbox One Series (tested)
- **Control Features**:
  - **Mode Switching**: Toggle between autonomous, manual, and other robot modes
  - **Autonomous Navigation**: Third-person game-style directional control for RL inference
  - **Manual Positioning**: Switch between zero position (all encoders at zero) and lying pose
  - **Auto-detection**: Smart device detection and reconnection support

### 🚧 Planned Services

#### 🧠 RL Policy Inference (Coming Soon)
- **Container**: `rl_inference_node` *(planned)*
- **Purpose**: Real-time reinforcement learning policy inference
- **Hardware**: FPGA acceleration on Kria KV260
- **Features**: 
  - Hardware-accelerated neural network inference
  - Low-latency policy execution for bipedal locomotion
  - Integration with trained RL models from simulation

## 🚀 Quick Start

### Prerequisites
- AMD Kria KV260 with Ubuntu
- Docker and Docker Compose installed
- Required hardware connected:
  - MD80 servo controllers via CAN-USB adapter
  - ASUS USB-BT500 Bluetooth adapter (for gamepad)
  - Xbox One Series controller or compatible (optional)
  - STM32 micro-ROS board

### 1. Clone and Setup
```bash
git clone <repository-url>
cd bernard-workspace
```

### 2. Set Environment Variables
```bash
# Set your user/group IDs for proper permissions
export UID=$(id -u)
export GID=$(id -g)
```

### 3. Build and Run Services
```bash
# Build all containers
docker-compose build

# Start all services
docker-compose up -d

# View logs
docker-compose logs -f
```

### 4. Individual Service Control
```bash
# Start specific service
docker-compose up -d micro_ros_agent

# Stop all services
docker-compose down

# Rebuild specific service
docker-compose build candle_ros2_node
```

## 🔧 Configuration

### Hardware Mappings
- **Serial Communication**: `/dev/ttyACM1` → micro-ROS and motor control
- **Bluetooth Gamepad**: `/dev/input/` directory mapped for dynamic device detection
- **Shared Memory**: `/dev/shm` for efficient inter-process communication

### Network Configuration
- **Network Mode**: Host networking for minimal latency
- **ROS Domain**: ID 0 (configurable via environment)

### Restart Policies
- **micro_ros_agent**: Always restart (critical service)
- **candle_ros2_node**: No auto-restart (manual control)
- **joy_node**: No auto-restart (Bluetooth gamepad input)

## 📁 Project Structure

```
bernard-workspace/
├── docker-compose.yml          # Main orchestration file
├── candle_ros2_node/           # Motor control service
│   ├── Dockerfile
│   ├── disable_fastdds_shm.xml
│   └── candle_ros2/            # ROS2 package source
├── joystick_driver_node/       # Bluetooth gamepad input service
│   ├── Dockerfile
│   ├── disable_fastdds_shm.xml
│   └── wait_for_joystick.sh    # Smart device detection script
├── micro_ros_agent/            # Micro-ROS bridge service
│   └── Dockerfile
├── agent_logs/                 # Service logs directory
└── [planned services]/         # Future AI/ML containers
    └──  rl_inference_node/     # FPGA-accelerated RL inference
```

## 🛠️ Advanced Usage

### Custom ROS Domain
```bash
ROS_DOMAIN_ID=5 docker-compose up -d
```

### Development Mode
```bash
# Mount local code for development
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
```

### Debugging
```bash
# Enter container for debugging
docker exec -it candle_ros2_node bash

# View real-time logs
docker-compose logs -f candle_ros2_node
```

## 🔍 Troubleshooting

### Gamepad Not Detected
The gamepad service includes intelligent detection:
- Automatically waits for `/dev/input/js0` to become available
- Supports Bluetooth reconnection for gamepads
- Compatible with ASUS USB-BT500 Bluetooth adapter
- Configurable timeout and retry intervals

**Bluetooth Setup Tips:**
```bash
# Pair Xbox controller via Bluetooth
sudo bluetoothctl
# In bluetoothctl:
# scan on
# pair <controller_MAC>
# trust <controller_MAC>
# connect <controller_MAC>
```

### Serial Port Issues
```bash
# Check device permissions
ls -la /dev/ttyACM*

# Add user to dialout group
sudo usermod -a -G dialout $USER
```

### Container Build Failures
```bash
# Clean rebuild
docker-compose down
docker system prune -f
docker-compose build --no-cache
```

### Gamepad Control Layout
The Xbox One Series controller provides intuitive robot control:

**Mode Switching:**
- **Start Button**: Switch between autonomous RL and manual modes
- **Select Button**: Emergency stop or safety mode

**Autonomous RL Mode:**
- **Left Stick**: Movement direction (forward/backward/strafe)
- **Right Stick**: Turning and rotation
- **Triggers**: Speed control

**Manual Mode:**
- **A Button**: Move to zero position (all encoders at zero)
- **B Button**: Move to lying pose
- **X/Y Buttons**: -

## 🎯 Use Cases

### Current Robot Operation
1. **Autonomous RL Mode**: RL inference + gamepad for directional control (third-person style)
2. **Manual Mode**: Direct robot control via gamepad (zero position, lying pose switching)
3. **Mode Switching**: Seamless transitions between operation modes via gamepad
4. **Development**: Individual service testing and debugging

### Future Capabilities (Planned)
1. **Enhanced RL Locomotion**: FPGA-accelerated policy inference for advanced bipedal walking
2. **Autonomous Navigation**: Complete perception-to-action pipeline
3. **Multi-Modal Control**: Seamless switching between manual, scripted, and RL control

### System Benefits
- **Isolation**: Each service runs in isolated environment
- **Reliability**: Container restart policies ensure uptime
- **Portability**: Easy deployment across different systems
- **Scalability**: Simple service addition/removal
- **Future-Ready**: Architecture designed for expanding AI capabilities

## 🔗 Related Projects

This workspace is part of the larger BERNARD robot ecosystem:
- **Main Repository**: [bernard-bipedal-robot](https://github.com/Baey/bernard-bipedal-robot)
- **STM32 Firmware**: [bernard-stm32-ros-node](https://github.com/Baey/bernard-stm32-ros-node)
- **RL Training**: [bernard-rl](https://github.com/Baey/bernard-rl)

## 📄 License

This project is part of a master's thesis at AGH University of Krakow.

## 🤝 Contributing

Please refer to the main [BERNARD](https://github.com/Baey/bernard-bipedal-robot) repository for contribution guidelines and project coordination.

---