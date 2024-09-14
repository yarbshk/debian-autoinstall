#!/bin/bash
set -e

# https://mullvad.net/en/download/vpn/linux

VERSION_CODENAME=bookworm

sudo apt install -y curl

# Download the Mullvad signing key
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc

# Add the Mullvad repository server to apt
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable $VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/mullvad.list
# Or add the Mullvad BETA repository server to apt
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/beta $VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/mullvad.list

# Install the package
sudo apt update
sudo apt install -y mullvad-vpn
