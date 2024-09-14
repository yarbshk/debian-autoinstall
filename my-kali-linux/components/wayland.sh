#!/bin/bash
set -e
# https://www.kali.org/docs/general-use/wayland/#what-is-wayland-or-x11
mkdir -p /etc/systemd/system/gdm.service.d
sudo ln -sf /dev/null /etc/systemd/system/gdm.service.d/disable-wayland.conf
