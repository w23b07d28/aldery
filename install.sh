#!/bin/bash

rm -rf /tmp/aldery
sudo dnf install git -y
git clone https://github.com/w23b07d28/aldery.git /tmp/aldery
cd /tmp/aldery || exit
bash ./src/main.sh
rm -rf /tmp/aldery