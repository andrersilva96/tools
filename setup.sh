#!/usr/bin/env bash

# Set locale and timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata
sudo locale-gen en_US.UTF-8 pt_BR.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Update system
sudo apt-get update \
    && sudo apt-get -y dist-upgrade \
    && sudo apt-get autoclean \
    && sudo apt-get autoremove \
    && sudo apt-get clean

# Remove LibreOffice
sudo apt-get remove --purge libreoffice*

# Utilities
sudo apt-get install -y git openssh-client openssh-server tree htop curl vim
sudo bash /etc/bash_completion

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER

# Snaps
sudo apt -y install snapd
sudo snap install code --classic
sudo snap install spotify
sudo snap install postman

# PHP runner
sudo chown -R $(whoami) /usr/local

sudo echo '#!/bin/sh
docker run --rm \
    -i \
    --network=host \
    -v "$HOME":"$HOME":ro \
    -u $(id -u) \
    -w "$PWD" \
    php:7-alpine \
    php "$@"
exit $?' > /usr/local/bin/php

sudo chmod +x /usr/local/bin/php

# System
sudo echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/99-custom.conf
sudo sysctl -p --system

# Adjust to dualboot
timedatectl set-local-rtc 1 --adjust-system-clock

echo "Please reboot your system"
