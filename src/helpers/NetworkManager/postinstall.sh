#!/bin/bash

sudo cp src/helpers/NetworkManager/50-org.freedesktop.NetworkManager.rules /etc/polkit-1/rules.d/50-org.freedesktop.NetworkManager.rules

sudo gpasswd -a $USER network

sudo rm -fr /var/service/dhcpcd
sudo rm -fr /var/service/wpa_supplicant

sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/dbus /var/service

