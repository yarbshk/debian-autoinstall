#!/bin/bash
set -e

# https://www.getmonero.org/resources/user-guides/verification-allos-advanced.html

MONERO_SIGNING_KEY_FILENAME=binaryfate.asc
HASH_FILENAME=hashes.txt

sudo apt install -y wget gpg gpg-agent lbzip2

wget -O $MONERO_SIGNING_KEY_FILENAME https://raw.githubusercontent.com/monero-project/monero/master/utils/gpg_keys/binaryfate.asc
gpg --keyid-format long --with-fingerprint $MONERO_SIGNING_KEY_FILENAME
gpg --import $MONERO_SIGNING_KEY_FILENAME

wget -O $HASH_FILENAME https://www.getmonero.org/downloads/hashes.txt
gpg --verify $HASH_FILENAME

wget --content-disposition https://downloads.getmonero.org/gui/linux64
MONERO_ARHIVE_FILENAME=$(ls monero-gui-linux-x64-v*.tar.bz2)
if [[ "$(cat $HASH_FILENAME)" != *"$(sha256sum $MONERO_ARHIVE_FILENAME)"* ]]; then
    echo "E: $MONERO_ARHIVE_FILENAME hash is invalid"
    exit 1
fi
sudo tar -xf $MONERO_ARHIVE_FILENAME -C /opt/

rm $MONERO_SIGNING_KEY_FILENAME
rm $HASH_FILENAME
rm $MONERO_ARHIVE_FILENAME
