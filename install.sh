#!/bin/bash

set -e # stop the script on the first error

# function to display an error message and exit the script
error_exit() {
  echo "$1" >&2 # display the message on the standard error output
  exit "${2:-1}" # return the given error code or 1 by default
}

# function to check if a program is installed and install it if needed
install_package() {
  if ! command -v "$1" &> /dev/null; then # if the program is not installed
    if [ "$#" -eq 2 ]; then # if the package name is provided
      echo "Installing $2..."
      sudo dnf install "$2" -y || error_exit "Failed to install $2." "$?" # install the package
    else # if the package name is not provided
      error_exit "$1 is not installed and no package name provided."
    fi
  fi
}

install_package git # install git

rm -rf /tmp/aldery

# clone the repository and run the installation
echo "Cloning the Aldery repository and starting the installation..."
if git clone https://github.com/w23b07d28/aldery.git /tmp/aldery; then
  cd /tmp/aldery/src || error_exit "Cannot enter the Aldery directory."
  bash main.sh || error_exit "Installation failed."
else
  error_exit "Failed to clone the Aldery repository."
fi

# remove the repository
rm -rf /tmp/aldery

echo "Installation completed successfully."
