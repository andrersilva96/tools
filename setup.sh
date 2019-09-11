#!/usr/bin/env bash

# Set locale and timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata
sudo locale-gen en_US.UTF-8 pt_BR.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Update system
sudo apt-get update \
    && sudo apt -y dist-upgrade \
    && sudo apt autoclean \
    && sudo apt -y autoremove \
    && sudo apt clean

# Utilities
sudo apt install -y git openssh-client openssh-server tree htop curl
sudo bash /etc/bash_completion

# Snap
sudo apt install -y snapd
sudo snap install code --classic
sudo snap install gitkraken
sudo snap install postman

# Docker
sudo apt remove -y docker docker-engine docker.io containerd runc

sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker

curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER

echo "Launch VS Code Quick Open (Ctrl+P), paste the following command, and press enter."
echo "ext install humao.rest-client equinusocio.vsc-material-theme ms-azuretools.vscode-docker editorconfig.editorconfig dbaeumer.vscode-eslint felixfbecker.php-debug felixfbecker.php-pack christian-kohler.path-intellisense felixfbecker.php-debug felixfbecker.php-pack ms-vscode.vscode-typescript-tslint-plugin wix.vscode-import-cost"
echo "Please reboot your system"

