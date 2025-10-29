.PHONY: help install install-cpu install-nvidia install-amd install-source start stop restart status logs enable disable uninstall check syntax

help:
	@echo "ComfyUI Ansible Makefile"
	@echo ""
	@echo "Installation:"
	@echo "  make install          - Install ComfyUI (auto-detect GPU)"
	@echo "  make install-cpu      - Install ComfyUI (CPU only)"
	@echo "  make install-nvidia   - Install ComfyUI (force NVIDIA GPU)"
	@echo "  make install-amd      - Install ComfyUI (force AMD GPU)"
	@echo "  make install-source   - Install ComfyUI from source"
	@echo ""
	@echo "Service Management:"
	@echo "  make start            - Start ComfyUI service"
	@echo "  make stop             - Stop ComfyUI service"
	@echo "  make restart          - Restart ComfyUI service"
	@echo "  make status           - Check service status"
	@echo "  make logs             - View service logs (follow)"
	@echo "  make enable           - Enable service at boot"
	@echo "  make disable          - Disable service at boot"
	@echo ""
	@echo "Maintenance:"
	@echo "  make check            - Check playbook syntax"
	@echo "  make syntax           - Alias for check"
	@echo "  make uninstall        - Remove ComfyUI installation"
	@echo ""
	@echo "Examples:"
	@echo "  make install                              # Default install"
	@echo "  make install-nvidia                       # NVIDIA GPU"
	@echo "  ansible-playbook playbook.yml -e 'comfyui_port=8189'  # Custom port"

install:
	ansible-playbook playbook.yml -K

install-cpu:
	ansible-playbook playbook.yml -K -e "comfyui_gpu_type=cpu"

install-nvidia:
	ansible-playbook playbook.yml -K -e "comfyui_gpu_type=nvidia"

install-amd:
	ansible-playbook playbook.yml -K -e "comfyui_gpu_type=amd"

install-source:
	ansible-playbook playbook.yml -K -e "comfyui_install_method=source"

start:
	sudo systemctl start comfyui

stop:
	sudo systemctl stop comfyui

restart:
	sudo systemctl restart comfyui

status:
	sudo systemctl status comfyui

logs:
	sudo journalctl -u comfyui -f

enable:
	sudo systemctl enable comfyui

disable:
	sudo systemctl disable comfyui

check:
	ansible-playbook playbook.yml --syntax-check

syntax: check

uninstall:
	@echo "This will remove ComfyUI installation. Press Ctrl+C to cancel, or Enter to continue..."
	@read -r dummy
	-sudo systemctl stop comfyui
	-sudo systemctl disable comfyui
	-sudo rm /etc/systemd/system/comfyui.service
	-sudo systemctl daemon-reload
	-sudo rm -rf /opt/comfyui
	-sudo rm -rf /var/log/comfyui
	-sudo userdel comfyui
	-sudo groupdel comfyui
	@echo "ComfyUI has been uninstalled"
