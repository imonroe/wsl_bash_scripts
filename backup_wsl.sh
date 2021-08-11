#!/usr/bin/env bash

# Three-fingered Claw Technique
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

echo 'Backing up your WSL home directory.'
rsync --archive --human-readable --update --compress --progress /home/ian admin@192.168.1.223:Backups/regent/wsl_backup
echo 'You are all good, brother.'

