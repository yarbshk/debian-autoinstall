#!/bin/bash
set -e
# https://github.com/mviereck/x11docker
sudo apt install -y curl
curl -fsSL https://raw.githubusercontent.com/mviereck/x11docker/master/x11docker | sudo bash -s -- --update
