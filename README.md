# ComfyUI Ansible Installation for Linux

[![Ansible](https://img.shields.io/badge/Ansible-2.10+-blue.svg)](https://www.ansible.com/)
[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org/)
[![Tested on Ubuntu 25.10](https://img.shields.io/badge/Tested%20on-Ubuntu%2025.10-E95420?logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![Debian/RedHat](https://img.shields.io/badge/Debian%2FRedHat-Untested-orange)](https://github.com/aloonj/comfyui-on-linux-ansible)
[![NVIDIA CUDA](https://img.shields.io/badge/NVIDIA%20CUDA-Tested-76B900?logo=nvidia&logoColor=white)](https://developer.nvidia.com/cuda-zone)
[![AMD ROCm/CPU](https://img.shields.io/badge/AMD%20ROCm%2FCPU-Untested-orange)](https://github.com/aloonj/comfyui-on-linux-ansible)

OS-agnostic Ansible playbook for installing ComfyUI on Linux. Supports Debian/Ubuntu and RedHat/CentOS/Fedora with automatic GPU detection (NVIDIA/AMD) and systemd service.

## Features

- OS-agnostic (Debian/RedHat families)
- Automatic GPU detection (NVIDIA CUDA, AMD ROCm, CPU fallback)
- Two installation methods: CLI (comfy-cli) or source
- Python virtual environment with proper PyTorch installation
- Systemd service for automatic startup

## Prerequisites

- Ansible 2.10+
- Sudo access

## Quick Start

```bash
# Review/edit inventory.yml
# Run playbook and provide sudo password
ansible-playbook playbook.yml 
```

## Configuration

All configuration is in `inventory.yml`:

```yaml
# Installation
comfyui_install_method: cli              # 'cli' or 'source'
comfyui_install_dir: /home/comfyui/comfyui
comfyui_venv_dir: /home/comfyui/comfy-env

# User
comfyui_user: comfyui
comfyui_group: comfyui

# GPU
comfyui_gpu_type: auto                   # 'auto', 'nvidia', 'amd', 'cpu'

# Network
comfyui_bind_address: 127.0.0.1
comfyui_port: 8188

# Service
comfyui_enable_service: true
```

## Usage

### Service Management

```bash
sudo systemctl start comfyui
sudo systemctl stop comfyui
sudo systemctl status comfyui
sudo journalctl -u comfyui -f
```

### Access ComfyUI

http://127.0.0.1:8188

### Manual Launch

```bash
sudo -u comfyui bash -c 'source /home/comfyui/comfy-env/bin/activate && cd /home/comfyui/comfyui && python main.py --listen 127.0.0.1 --port 8188'
```

## Key Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `comfyui_install_method` | `cli` | Installation method |
| `comfyui_install_dir` | `/home/comfyui/comfyui` | Installation path |
| `comfyui_venv_dir` | `/home/comfyui/comfy-env` | Virtual environment |
| `comfyui_gpu_type` | `auto` | GPU detection mode |
| `comfyui_bind_address` | `127.0.0.1` | Listen address |
| `comfyui_port` | `8188` | HTTP port |
| `comfyui_install_manager` | `true` | Install ComfyUI-Manager |
| `pytorch_cuda_version` | `cu124` | CUDA version for PyTorch |


## Uninstall

```bash
sudo systemctl stop comfyui
sudo systemctl disable comfyui
sudo rm /etc/systemd/system/comfyui.service
sudo systemctl daemon-reload
sudo rm -rf /home/comfyui
sudo userdel comfyui
sudo groupdel comfyui
```

## License

Unlicense

## Credits

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [comfy-cli](https://github.com/Comfy-Org/comfy-cli)
- [ComfyUI Wiki](https://comfyui-wiki.com)
