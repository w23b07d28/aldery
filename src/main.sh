#!/bin/bash

# Set the base directory to the current working directory
BASEDIR=$(pwd)

# Source the YAML module
source ./src/modules/yaml.sh

# Print a message indicating that program installation is starting
echo "Installing programs..."

# Loop through each file in the "programs" directory
find ./src/programs -type f -print0 | while IFS= read -r -d $'\0' file; do
  
  # Get the package name from the file name
  package_name=$(basename "$file")
  
  # Convert hyphens to underscores in the package name
  base_name=$(echo "$package_name" | tr "-" "_") 
  
  # Create variables for the pre-install, install, and post-install scripts
  preinstall="${base_name}preinstall"
  install="${base_name}install"
  postinstall="${base_name}postinstall"

  # Execute the pre-install script if it exists
  if [ -n "${!preinstall}" ]; then
    # shellcheck disable=SC2086
    eval ${!preinstall}
  fi

  # Execute the install script if it exists, otherwise install the package using the package manager
  if [ -n "${!install}" ]; then
    # shellcheck disable=SC2086
    eval ${!install}
  else
    sudo xbps-install -y "${package_name}"
  fi

  # Execute the post-install script if it exists
  if [ -n "${!postinstall}" ]; then
    # shellcheck disable=SC2086
    eval ${!postinstall}
  fi

  # Change the working directory back to the base directory
  cd "$BASEDIR" || exit
done

# Print a message indicating that program installation is complete
echo "Program installation complete."

# echo "Download dotfiles"
# git clone --bare https://github.com/w23b07d28/dotfiles.git "$HOME/.dotfiles"
