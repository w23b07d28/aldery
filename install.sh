#!/bin/bash
Remove any previous Aldery installation

rm -rf /tmp/aldery
Install Git

echo "Installing Git..."
sudo dnf install git -y
Clone the Aldery repository to /tmp/aldery and run the installation script

echo "Cloning the Aldery repository and starting the installation..."
git clone https://github.com/w23b07d28/aldery.git /tmp/aldery
cd /tmp/aldery || { echo "Error: Could not change to directory /tmp/aldery. Exiting." >&2; exit 1; }
bash ./src/main.sh
Clean up the temporary directory

echo "Cleaning up..."
rm -rf /tmp/aldery

echo "Installation completed successfully."