#!/usr/bin/env bash

# Remove any previous Aldery installation
rm -rf /tmp/aldery

# Install GIT
sudo dnf install -qy git git-lfs

# Clone repo to /tmp/aldery and run the installation script
git clone https://github.com/w23b07d28/aldery.git /tmp/aldery
cd /tmp/aldery || exit

bash ./src/main.sh