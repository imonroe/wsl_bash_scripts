#!/usr/bin/env bash

# Three-fingered Claw Technique
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

echo 'Backing up your Windows home directory.'
rsync --recursive --human-readable --update --compress --progress --no-owner --no-group --times --specials --links /mnt/c/Users/ian admin@192.168.1.223:Backups/regent/windows_backup
echo 'You are all good, brother.'

