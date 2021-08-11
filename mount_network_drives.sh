#!/usr/bin/env bash

# Three-fingered Claw Technique
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

echo 'Mounting your network drives'
echo 'M: -- Media on Monarch'
echo 'U: -- Home directory on Monarch'
echo 'Y: -- backups directory on Monarch'
echo 'Z: -- MyDrive, Google drive via Monarch'

# [ -d "/mnt/m" ] || try sudo mkdir /mnt/m && sudo chmod 777 /mnt/m
# [ -d "/mnt/u" ] || try sudo mkdir /mnt/u && sudo chmod 777 /mnt/u
# [ -d "/mnt/y" ] || try sudo mkdir /mnt/y && sudo chmod 777 /mnt/y
# [ -d "/mnt/z" ] || try sudo mkdir /mnt/m && sudo chmod 777 /mnt/z

try sudo mount -t drvfs M: /mnt/m
try sudo mount -t drvfs U: /mnt/u
try sudo mount -t drvfs Y: /mnt/y
try sudo mount -t drvfs Z: /mnt/z

echo "All set, homey!"
