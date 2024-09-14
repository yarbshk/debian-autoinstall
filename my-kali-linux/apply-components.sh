#!/bin/bash
set -e

apply_component () {
  COMPONENT_NAME=$1
  dashes=$(printf "%0.s-" {1..55})
  printf "\n\n#$dashes\n# Applying $COMPONENT_NAME component...\n#$dashes\n\n"
  bash ./components/$COMPONENT_NAME.sh
}

COMPONENT_NAME=$1
if [[ $SKIP_INITIAL_APT_UPDATE -ne 1 ]]; then
  sudo apt update
fi
if [[ -n "$COMPONENT_NAME" ]]; then
  apply_component $COMPONENT_NAME
  exit 0
fi

apply_component apt-packages
apply_component cake-wallet
apply_component docker
apply_component git-config
apply_component gsettings
apply_component joplin
apply_component monero
apply_component mullvadvpn
apply_component nodejs
apply_component protonvpn
apply_component ungoogled-chromium
apply_component vscodium
apply_component wayland
apply_component x11docker
