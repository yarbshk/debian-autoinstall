#!/bin/bash
set -e
# https://protonvpn.com/support/official-linux-vpn-debian/
sudo apt install -y curl wget gnupg2
PROTONVPN_REPO_URL=https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/
PROTONVPN_PACKAGE_NAME=$(curl -s $PROTONVPN_REPO_URL | grep "protonvpn-stable-release" | awk '{print $3 " " $4 " " $1 " " $2}' | sort -r | head -1 | grep -Po 'href="\K[^"]+' || echo "")
if [[ -z "$PROTONVPN_PACKAGE_NAME" ]]; then
  echo "E: Can not resolve package name of ProtonVPN"
  exit 1
fi
wget $PROTONVPN_REPO_URL$PROTONVPN_PACKAGE_NAME
sudo dpkg -i ./$PROTONVPN_PACKAGE_NAME
sudo apt update
sudo apt install -y proton-vpn-gnome-desktop
sudo apt install -y libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
rm $PROTONVPN_PACKAGE_NAME
