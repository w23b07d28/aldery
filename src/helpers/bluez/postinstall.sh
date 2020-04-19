#!/bin/bash

sudo ln -s /etc/sv/dbus /var/service/
sudo ln -s  /etc/sv/bluetoothd /var/service/

sudo usermod -a -G bluetooth $USER

sudo sv restart dbus
sudo sv restart NetworkManager

