#!/bin/bash

# Install Git and clone the repository to start installation
echo "Installing Git and cloning the repository..."
sudo dnf install git -y || { echo "Failed to install Git."; exit 1; }
git clone https://github.com/w23b07d28/aldery.git /tmp/aldery || { echo "Failed to clone the repository."; exit 1; }
cd /tmp/aldery/src || { echo "Failed to change directory."; exit 1; }

# Run the installation script
echo "Running the installation script..."
bash ./main.sh || { echo "Failed to run the installation script."; exit 1; }

# Remove the cloned repository from /tmp
echo "Removing the cloned repository from /tmp..."
rm -rf /tmp/aldery
