#!/usr/bin/env bash

# The script enables RPM Fusion Repository, Flathub repository, and Snaps by
# installing necessary packages and adding required repositories. It also installs
# npm and globally installs yarn. Each command is executed in sequence in the terminal.

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y
sudo dnf install snapd -y
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install core
sudo snap refresh core
sudo dnf install npm -y
sudo npm install yarn -g
