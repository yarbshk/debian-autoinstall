#!/bin/bash
set -e
# https://guides.cakewallet.com/
sudo apt install -y curl wget
CAKE_WALLET_VERSION=$(basename $(curl -Ls -o /dev/null -w %{urle.path} https://github.com/cake-tech/cake_wallet/releases/latest/))
CAKE_WALLET_BASENAME=Cake_Wallet_${CAKE_WALLET_VERSION}_Linux
CAKE_WALLET_ARCHIVE_FILENAME=$CAKE_WALLET_BASENAME.tar.xz
APPLICATIONS_DIR=/opt
CAKE_WALLET_DIR=$APPLICATIONS_DIR/$CAKE_WALLET_BASENAME
DESKTOP_FILES_DIR=~/.local/share/applications
wget -O $CAKE_WALLET_ARCHIVE_FILENAME https://github.com/cake-tech/cake_wallet/releases/download/$CAKE_WALLET_VERSION/$CAKE_WALLET_ARCHIVE_FILENAME
sudo tar -xf $CAKE_WALLET_ARCHIVE_FILENAME -C $APPLICATIONS_DIR
mkdir -p $DESKTOP_FILES_DIR
cat <<EOF > $DESKTOP_FILES_DIR/cake-wallet.desktop
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=$CAKE_WALLET_DIR/cake_wallet
Name=Cake Wallet
Icon=$CAKE_WALLET_DIR/data/flutter_assets/assets/images/app_logo.png
EOF
rm $CAKE_WALLET_ARCHIVE_FILENAME
