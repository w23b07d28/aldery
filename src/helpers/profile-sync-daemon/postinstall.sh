#!/usr/bin/env bash

# Moving web browser's profile to RAM reduces hard
# disk read/write, especially improves the I/O operations
# in SSDs and improves web browser's speed and responsiveness.

# Check if psd.conf exists in /home/$USER/.config/psd/ directory
if [ ! -f /home/$USER/.config/psd/psd.conf ]; then
    # Create psd configuration file
    psd
fi

# Edit psd configuration file
sed -i 's/#BROWSERS/BROWSERS="firefox"/' /home/$USER/.config/psd/psd.conf

# Enable and start psd service
sudo systemctl --user enable psd.service
sudo systemctl --user start psd.service
