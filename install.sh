#!/bin/sh
echo "Install git and clone the VOPI repository to start installation..."

sudo xbps-install git
git clone https://github.com/balintkiraly/vopi.git /tmp/vopi
cd /tmp/vopi || exit

bash ./src/main.sh
