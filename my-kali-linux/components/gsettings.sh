#!/bin/bash
set -e
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad click-method areas
gsettings set org.gnome.desktop.interface enable-hot-corners false
