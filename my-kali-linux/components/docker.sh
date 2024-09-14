#!/bin/bash
set -e

# https://docs.docker.com/engine/install/debian/
# https://docs.docker.com/engine/install/linux-postinstall/

VERSION_CODENAME=bookworm

# Add Docker's official GPG key:
sudo apt -y install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $VERSION_CODENAME stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Post-installation steps
if [[ -n "$USER" ]]; then
  sudo groupadd -f docker
  sudo usermod -aG docker $USER
  newgrp docker
fi
