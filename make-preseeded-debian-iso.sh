#!/bin/bash
set -e

INPUT_IMAGE_PATH=$PWD/debian-12.7.0-amd64-DVD-1.iso
PRESEED_CFG_PATH=$PWD/preseed.cfg

echo "Extracting files from ISO..."
DEBIAN_MNTDIR=/mnt/debian-iso-ro
DEBIAN_WORKDIR=/tmp/debian-iso-rw
sudo mkdir $DEBIAN_MNTDIR
sudo mount -o loop $INPUT_IMAGE_PATH $DEBIAN_MNTDIR
sudo rm -rf $DEBIAN_WORKDIR
rsync -a $DEBIAN_MNTDIR/ $DEBIAN_WORKDIR
sudo umount $DEBIAN_MNTDIR
sudo rm -rf $DEBIAN_MNTDIR

function inject_preseed_cfg_to_initrc_gz {
    local PRESEED_CFG_PATH=$1
    local INITRD_GZ_PATH=$2
    local INITRD_WORKDIR=$(dirname $INITRD_GZ_PATH)/initrd-tmp
    echo "Adding $PRESEED_CFG_PATH to $INITRD_GZ_PATH..."
    sudo mkdir $INITRD_WORKDIR
    pushd $INITRD_WORKDIR
    sudo gzip -d < $INITRD_GZ_PATH \
        | sudo cpio --extract --make-directories --no-absolute-filenames
    sudo cp $PRESEED_CFG_PATH preseed.cfg
    sudo chmod u+w $INITRD_GZ_PATH
    find . \
        | cpio -H newc --create \
        | gzip -9 \
        > $INITRD_GZ_PATH
    popd
    sudo rm -rf $INITRD_WORKDIR
}

# Automated install
inject_preseed_cfg_to_initrc_gz $PRESEED_CFG_PATH $DEBIAN_WORKDIR/install.amd/initrd.gz

# Graphical automated install
inject_preseed_cfg_to_initrc_gz $PRESEED_CFG_PATH $DEBIAN_WORKDIR/install.amd/gtk/initrd.gz

echo "Configuring autoinstall..."
sudo sed 's/initrd.gz/initrd.gz auto=true file=\/cdrom\/preseed.cfg/' -i $DEBIAN_WORKDIR/isolinux/txt.cfg

echo "Updating checksum..."
CHECKSUM_PATH=$DEBIAN_WORKDIR/md5sum.txt
sudo chmod u+w $CHECKSUM_PATH
md5sum $(find $DEBIAN_WORKDIR -type f) > $CHECKSUM_PATH

echo "Creating ISO from files..."
OUTPUT_IMAGE_PATH=/tmp/preseeded-debian.iso
sudo rm $OUTPUT_IMAGE_PATH
sudo mkisofs \
    -o $OUTPUT_IMAGE_PATH \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -J \
    -R \
    -V "Preseeded Debian" \
    $DEBIAN_WORKDIR

echo "Success!"