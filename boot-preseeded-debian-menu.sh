#!/bin/bash
qemu-system-x86_64 -boot d -cdrom /tmp/preseeded-debian.iso -m 8048 -hda hd_img.img