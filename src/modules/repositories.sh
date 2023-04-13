#!/usr/bin/env bash

# RPM Fusion free and nonfree repositories.
sudo dnf install -y  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade --refresh
sudo dnf groupupdate core
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y dnf-plugins-core

# Flatpak is installed by default,
# but one needs to enable the Flathub store.
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# Snap support.
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
sudo snap install core
sudo snap refresh core
sudo snap refresh

#sudo dnf install npm -y
#sudo npm install yarn -g
