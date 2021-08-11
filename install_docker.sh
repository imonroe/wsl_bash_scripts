#!/usr/bin/env bash

# bash script to help set up a Drupal-friendly LAMP stack local development environment
# comments and questions to ian [at] ianmonroe.com# Update the apt package list.

# Three-fingered Claw Technique
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }


# Update the apt package list.
try sudo apt-get update -y

# Install Docker's package dependencies.
try sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Download and add Docker's official public PGP key.
try curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify the fingerprint.
try sudo apt-key fingerprint 0EBFCD88

# Add the `stable` channel's Docker upstream repository.
#
# If you want to live on the edge, you can change "stable" below to "test" or
# "nightly". I highly recommend sticking with stable!
try sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package list (for the new apt repo).
try sudo apt-get update -y

# Install the latest version of Docker CE.
try sudo apt-get install -y docker-ce

# Allow your user to access the Docker CLI without needing root access.
try sudo usermod -aG docker $USER

# Install Python and PIP.
try sudo apt-get install -y python python-pip

# Install Docker Compose into your user's home directory.
try pip install --user docker-compose

try echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.bashrc && source ~/.bashrc
