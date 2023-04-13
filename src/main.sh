#!/usr/bin/env bash

# Update the system
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf upgrade --refresh -y
sudo dnf check -y
sudo dnf autoremove -y
sudo fwupdmgr get-devices -y
sudo fwupdmgr refresh --force -y
sudo fwupdmgr get-updates -y
sudo fwupdmgr update -y

# Modules
source ./src/modules/repositories.sh
source ./src/modules/yaml.sh
BASEDIR=$(pwd)

# Install programs
find ./src/programs -type f -print0 | while IFS= read -r -d $'\0' file; 
do
  package_name=$(basename "$file")
  base_name=$(echo "$package_name" | tr "-" "_") 
  create_variables "$file" "$base_name"

  preinstall="${base_name}preinstall"
  install="${base_name}install"
  postinstall="${base_name}postinstall"

  # shellcheck disable=SC2086
  [ -n "${!preinstall}" ] && eval ${!preinstall}

  if [ -n "${!install}" ]; then
    # shellcheck disable=SC2086
    eval ${!install}
  else
    sudo dnf install -y "${package_name}"
  fi

  # shellcheck disable=SC2086
  [ -n "${!postinstall}" ] && eval ${!postinstall}

  cd "$BASEDIR" || exit
done

#echo "Download dotfiles"
#git clone --bare https://github.com/w23b07d28/dotfiles.git "$HOME/.dotfiles"
